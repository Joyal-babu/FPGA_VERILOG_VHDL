----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2025 16:16:21
-- Design Name: 
-- Module Name: data_extd - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_extd is
    generic (
            data_limit : std_logic_vector(31 downto 0)
        );
    Port ( 
            clock     : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            valid     : in  STD_LOGIC;
            data      : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
            valid_out : out STD_LOGIC;
            data_out  : out STD_LOGIC_VECTOR(31 DOWNTO 0)
            );
end data_extd;

architecture Behavioral of data_extd is

   signal ext_cnt        : std_logic_vector(31 downto 0);
   signal data_lmt_adj   : std_logic_vector(31 downto 0);
   signal data_lmt_reg   : std_logic_vector(31 downto 0);
   signal ext_vld        : std_logic;
   signal valid_in_d     : std_logic;
   signal data_in_d      : std_logic_vector(31 downto 0); 

begin

    data_lmt_reg <= data_limit;

    process(data_lmt_reg)
    begin
        if(data_limit <= 1024) then
            data_lmt_adj <= x"00000400";
        elsif(data_limit > 1024 and data_limit <= 2048) then
            data_lmt_adj <= x"00000800";
        elsif(data_limit > 2048 and data_limit <= 3072) then
            data_lmt_adj <= x"00000C00";
        elsif(data_limit > 3072 and data_limit <= 4096) then
            data_lmt_adj <= x"00001000";
        elsif(data_limit > 4096 and data_limit <= 5120) then
            data_lmt_adj <= x"00001400";
        elsif(data_limit > 5120 and data_limit <= 6144) then
            data_lmt_adj <= x"00001800";
        elsif(data_limit > 6144 and data_limit <= 7168) then
            data_lmt_adj <= x"00001C00";
        elsif(data_limit > 7168 and data_limit <= 8192) then
            data_lmt_adj <= x"00002000";
        else
            data_lmt_adj <= x"00002000";    
        end if;
    end process;

    process(clock, reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                ext_cnt <= (others => '0');
                ext_vld <= '0';
            elsif(valid = '1') then
                ext_cnt <= ext_cnt + '1';
                ext_vld <= '1';
            elsif(ext_vld = '1' and ext_cnt < (data_lmt_adj)) then               -- ext_cnt > (data_limit - 1)
                ext_cnt <= ext_cnt + '1';
                ext_vld <= '1';
            else
                ext_cnt <= (others => '0');
                ext_vld <= '0';             
            end if;
        end if;
    end process;
    
    process(clock, reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                valid_in_d <= '0';
                data_in_d  <= (others => '0');
            else
                valid_in_d <= valid;
                data_in_d  <= data;
            end if;
        end if;
    end process;
    
    data_out  <= data_in_d when valid_in_d = '1' else (others => '0');
    valid_out <= ext_vld;

end Behavioral;
