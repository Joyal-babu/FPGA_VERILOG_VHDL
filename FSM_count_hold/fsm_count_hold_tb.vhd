library IEEE;
use IEEE.std_logic_1164.all;

entity fsm_count_hold_count_tb is
--	port( );
end fsm_count_hold_count_tb;

architecture Behavioral of fsm_count_hold_count_tb is

component fsm_count_hold_count is
	port( clk   : in std_logic;
    	  reset : in std_logic  );
end component;

signal clk, reset : std_logic := '0';

begin
--instantiating the design under test

DUT : fsm_count_hold_count port map(
		clk   => clk,
        reset => reset );
        
clock_process : process
begin
	clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;
end process;

reset_process : process
begin
	clk <= '1'; wait for 500 ns;
	clk <= '0'; wait;
end process;

end Behavioral;
