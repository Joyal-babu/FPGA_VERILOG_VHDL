----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2025 12:01:48
-- Design Name: 
-- Module Name: Top_module_TB - Behavioral
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

entity Top_module_TB is
--  Port ( );
end Top_module_TB;

architecture Behavioral of Top_module_TB is

    component data_comp_top is
        Port ( clock      : in  STD_LOGIC;
               reset      : in  STD_LOGIC;
               comp_data  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
               data_valid : out STD_LOGIC
               );
    end component data_comp_top;
    
    signal clock, reset : std_logic := '0';
    signal comp_data    : std_logic_vector(31 downto 0);
    signal data_valid   : std_logic;

begin

    clock <= not clock after 5ns;
    reset <= '1', '0'  after 500ns;

    DUT : data_comp_top 
        port map (
            clock        => clock,
            reset        => reset,
            comp_data    => comp_data,
            data_valid   => data_valid 
        );

end Behavioral;
