----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2025 15:30:21
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
        data_limit : std_logic_vector(31 downto 0)
        );
    Port ( 
        clock      : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        valid      : out STD_LOGIC;
        data       : out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
end data_genr;

architecture Behavioral of data_genr is

    signal counter : std_logic_vector(31 downto 0);
    signal data_i  : std_logic_vector(31 downto 0);
    signal valid_i : std_logic;    

begin

   valid <= valid_i;
   data  <= data_i; 

    process(clock, reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                counter <= (others => '0');
            elsif(counter < ((data_limit + data_limit) - 1)) then
                counter <= counter + '1';
            else
                counter <= (others => '0');
            end if;
        end if;
    end process;
    
    valid_i <= '1'     when counter <= (data_limit - 1) else '0';
    data_i  <= counter when counter <= (data_limit - 1) else (others => '0'); 


end Behavioral;
