----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2025 17:09:59
-- Design Name: 
-- Module Name: data_genr - Behavioral
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

entity data_genr is
    generic (
           data_lmt_gen : STD_LOGIC_VECTOR(31 DOWNTO 0)
           );
    Port ( clock        : in  STD_LOGIC;
           reset        : in  STD_LOGIC;
           data_out     : out STD_LOGIC_VECTOR(31 DOWNTO 0);
           data_vld     : out STD_LOGIC 
           );
end data_genr;

architecture Behavioral of data_genr is

    signal count       : std_logic_vector(31 downto 0);
    signal count_d     : std_logic_vector(31 downto 0);
    signal valid       : std_logic;
    signal valid_out   : std_logic;

    constant dn_count      : std_logic_vector(31 downto 0) := data_lmt_gen  + x"00000800";     

begin

    process(clock, reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                count <= (others => '0');
                valid <= '0';
            else
                if(count < (data_lmt_gen)) then
                    count <= count + '1';
                    valid <= '1';
                elsif(count >= (data_lmt_gen) and count < dn_count-1 ) then
                    count <= count + '1';
                    valid <= '0';
                else
                    count <= (others => '0');
                    valid <= '0';
                end if;
            end if;
        end if;
    end process;
    
    process(clock, reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                count_d <= (others => '0');
            else
                count_d <= count;
            end if;
        end if;    
    end process;
    
    data_out <= count_d when valid = '1' else (others => '0');
    data_vld <= valid;
    



end Behavioral;
