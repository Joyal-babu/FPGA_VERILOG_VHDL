library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ddr4_ip_sm_tb is
--  Port ( );
end ddr4_ip_sm_tb;

architecture Behavioral of ddr4_ip_sm_tb is

component ddr4_ip_sm is
	port( 
	      sys_clk_p : in std_logic;
          sys_clk_n : in std_logic;
          ui_clk_in : in std_logic;
          reset     : in std_logic  );
end component;

signal sys_clk_p, sys_clk_n, ui_clk_in, reset : std_logic := '0';

begin

DUT: ddr4_ip_sm port map(
        sys_clk_p => sys_clk_p,
        sys_clk_n => sys_clk_n,
        ui_clk_in => ui_clk_in,
        reset     => reset      );
        
process_reset : process
begin
    reset <= '1'; wait for 500 ns;
    reset <= '0'; wait;
end process;

sys_clk_process : process
begin
    sys_clk_p <= '1'; sys_clk_n <= '0'; wait for 5 ns;
    sys_clk_p <= '0'; sys_clk_n <= '1'; wait for 5 ns;
end process;

ui_clk_process : process
begin
    ui_clk_in <= '1'; wait for 3 ns;
    ui_clk_in <= '0'; wait for 3 ns;
end process;


end Behavioral;
