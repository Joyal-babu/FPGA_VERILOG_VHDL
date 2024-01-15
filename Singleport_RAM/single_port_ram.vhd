----------------------------------------------------------------------------------
-- Company: 
-- Engineer: JOYAL 
-- 
-- Create Date: 21.11.2023 23:26:18
-- Design Name: 
-- Module Name: single_port_ram - Behavioral
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

entity single_port_ram is
    generic ( 
            data_width : natural := 16;
            ram_depth   : natural := 1024 );
    Port (
        clock      : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        data_ina   : in  STD_LOGIC_VECTOR (15 downto 0);
        addra      : in  STD_LOGIC_VECTOR (9 downto 0);
        we_a       : in  STD_LOGIC;
        data_outa  : out STD_LOGIC_VECTOR (15 downto 0);
        rd_data_valid : out STD_LOGIC );
end single_port_ram;

architecture Behavioral of single_port_ram is

    -- constant data_width : natural := 16;
    -- constant ram_depth  : natural := 1024;

    type ar_mem is array (0 downto (ram_depth-1)) of std_logic_vector((data_width-1) downto 0);
    signal sp_ram : ar_mem;

begin

    process(clock, reset)
    begin
        if(reset = '1') then
            data_outa     <= (others => '0');
            rd_data_valid <= '0';
        elsif(rising_edge(clock)) then
            if(we_a = '1') then
                sp_ram(to_integer(unsigned(addra))) <= data_ina;
                rd_data_valid <= '0';
            else
                data_outa <= sp_ram(to_integer(unsigned(addra)));
                rd_data_valid <= '1';
            end if;
        end if;
    end process;


end Behavioral;
