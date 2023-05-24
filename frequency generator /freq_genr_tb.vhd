library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_genr_tb is
--  Port ( );
end freq_genr_tb;

architecture Behavioral of freq_genr_tb is

component freq_genr is
    Port ( 
           clk     : in  STD_LOGIC;
           rst     : in  STD_LOGIC;
           f_100hz : out STD_LOGIC;
           f_50hz  : out STD_LOGIC;
           f_10hz  : out STD_LOGIC;
           f_1hz   : out STD_LOGIC );
end component;

signal clk, rst,f_100hz, f_50hz, f_10hz, f_1hz : std_logic := '0'; 

begin
-- instantiating the design under test 

DUT : freq_genr port map(
                            clk     => clk,
                            rst     => rst,
                            f_100hz => f_100hz,
                            f_50hz  => f_50hz,
                            f_10hz  => f_10hz,
                            f_1hz   => f_1hz    );
                
clock_process : process
begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;
end process;

stimulus_process : process
begin
    rst <= '1'; wait for 500 ns;
    rst <= '0'; wait;
end process;

end Behavioral;
