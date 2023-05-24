library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_blinker_tb is
--  Port ( );
end led_blinker_tb;

architecture Behavioral of led_blinker_tb is

component led_blinker is
    Port ( 
           clk    : in STD_LOGIC;
           led_en : in STD_LOGIC;
           rst    : in STD_LOGIC;
           sw1    : in STD_LOGIC;
           sw2    : in STD_LOGIC;
           led_drive : out STD_LOGIC );
end component;

signal clk, led_en, rst, sw1, sw2, led_drive : std_logic := '0';

begin
-- instantiating the design under test 

DUT : led_blinker port map(
                    clk    => clk,
                    led_en => led_en,
                    rst    => rst,
                    sw1    => sw1,
                    sw2    => sw2,
                    led_drive => led_drive );
                    
clock_stimulus : process 
begin
    clk <= '0'; wait for 20 ns;
    clk <= '1'; wait for 20 ns;
end process;

stimulus_process : process
begin
    rst <= '1'; led_en <= '0'; wait for 500 ns;
    rst <= '0'; led_en <= '1';
    sw1 <= '0'; sw2 <= '0'; wait for 300 ms;
    sw1 <= '0'; sw2 <= '1'; wait for 300 ms;
    sw1 <= '1'; sw2 <= '0'; wait for 700 ms;
    sw1 <= '1'; sw2 <= '1'; wait for 1000 ms;
    wait;
end process;

end Behavioral;
