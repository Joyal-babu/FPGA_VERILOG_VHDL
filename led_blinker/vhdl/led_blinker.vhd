library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity led_blinker is
    Port ( 
           clk    : in STD_LOGIC;
           led_en : in STD_LOGIC;
           rst    : in STD_LOGIC;
           sw1    : in STD_LOGIC;
           sw2    : in STD_LOGIC;
           led_drive : out STD_LOGIC );
end led_blinker;

architecture Behavioral of led_blinker is

constant count_100hz : natural := 125000;
constant count_50hz  : natural := 250000;
constant count_10hz  : natural := 1250000;
constant count_1hz   : natural := 12500000;

signal cntr_100hz : natural range 0 to count_100hz;
signal cntr_50hz  : natural range 0 to count_50hz;
signal cntr_10hz  : natural range 0 to count_10hz;
signal cntr_1hz   : natural range 0 to count_1hz;

signal f_100hz_i : std_logic;
signal f_50hz_i  : std_logic;
signal f_10hz_i  : std_logic;
signal f_1hz_i   : std_logic;

signal led_freq_select : std_logic;

begin

led_drive <= (led_freq_select and led_en);

process(clk)                                             -- FOR 100 Hz
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

process(clk)                                            -- FOR 50 Hz
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

process(clk)                                            -- FOR 10 Hz
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

process(clk)                                             -- FOR 1 Hz
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

led_freq_select <= f_100hz_i when (sw1 = '0' and sw2 = '0') else
                   f_50hz_i  when (sw1 = '0' and sw2 = '1') else
                   f_10hz_i  when (sw1 = '1' and sw2 = '0') else
                   f_1hz_i;

end Behavioral;
