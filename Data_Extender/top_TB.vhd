----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2025 12:24:37
-- Design Name: 
-- Module Name: top_TB - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_TB is
--  Port ( );
end top_TB;

architecture Behavioral of top_TB is

    component top_module is
        Port ( 
                clock : in STD_LOGIC;
                reset : in STD_LOGIC
                );
    end component top_module;
    
    signal clock, reset : std_logic := '0';

begin

    clock <= not clock after 5ns;
    reset <= '1', '0'  after 500ns;

     DUT : top_module
        port map (
            clock  => clock,
            reset  => reset
            );


end Behavioral;
