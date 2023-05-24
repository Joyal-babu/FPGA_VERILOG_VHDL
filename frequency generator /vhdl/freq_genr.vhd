library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity freq_genr is
    Port ( 
           clk     : in  STD_LOGIC;
           rst     : in  STD_LOGIC;
           f_100hz : out STD_LOGIC;
           f_50hz  : out STD_LOGIC;
           f_10hz  : out STD_LOGIC;
           f_1hz   : out STD_LOGIC );
end freq_genr;

architecture Behavioral of freq_genr is

  -- Constants to create the frequencies needed:
  -- Formula is: (100 MHz / 100 Hz * 50% duty cycle)
  -- So for 100 Hz: 100,000,000 / 100 * 0.5 = 500000
  -- So for 50  Hz: 100,000,000 / 50  * 0.5 = 1000000
  -- So for 10  Hz: 100,000,000 / 10  * 0.5 = 5000000
  -- So for 1   Hz: 100,000,000 / 1   * 0.5 = 50000000

constant count_100hz : natural := 500000;
constant count_50hz  : natural := 1000000;
constant count_10hz  : natural := 5000000;
constant count_1hz   : natural := 50000000;

signal cntr_100hz : natural range 0 to count_100hz;
signal cntr_50hz  : natural range 0 to count_50hz;
signal cntr_10hz  : natural range 0 to count_10hz;
signal cntr_1hz   : natural range 0 to count_1hz;

signal f_100hz_i : std_logic;
signal f_50hz_i  : std_logic;
signal f_10hz_i  : std_logic;
signal f_1hz_i   : std_logic;

begin
f_100hz <= f_100hz_i;
f_50hz  <= f_50hz_i;
f_10hz  <= f_10hz_i;
f_1hz   <= f_1hz_i;

process(clk)
begin
    if (rising_edge(clk)) then 
        if(rst = '1')then
            f_100hz_i <= '0';
        else
            if(cntr_100hz = (count_100hz - 1)) then
                f_100hz_i  <= not(f_100hz_i);
                cntr_100hz <= 0;
            else
                cntr_100hz <= cntr_100hz + 1;
            end if;
        end if;
    end if;
end process;

process(clk)
begin
    if (rising_edge(clk)) then 
        if(rst = '1')then
            f_50hz_i <= '0';
        else
            if(cntr_50hz = (count_50hz - 1)) then
                f_50hz_i   <= not(f_50hz_i);
                cntr_50hz  <= 0;
            else
                cntr_50hz <= cntr_50hz + 1;
            end if;
        end if;
    end if;
end process;

process(clk)
begin
    if (rising_edge(clk)) then 
        if(rst = '1')then
            f_10hz_i <= '0';
        else
            if(cntr_10hz = (count_10hz - 1)) then
                f_10hz_i   <= not(f_10hz_i);
                cntr_10hz  <= 0;
            else
                cntr_10hz <= cntr_10hz + 1;
            end if;
        end if;
    end if;
end process;

process(clk)
begin
    if (rising_edge(clk)) then 
        if(rst = '1')then
            f_1hz_i <= '0';
        else
            if(cntr_1hz = (count_1hz - 1)) then
                f_1hz_i   <= not(f_1hz_i);
                cntr_1hz  <= 0;
            else
                cntr_1hz <= cntr_1hz + 1;
            end if;
        end if;
    end if;
end process;

end Behavioral;
