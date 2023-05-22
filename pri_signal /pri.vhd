library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity pwm_mod is
    generic
    (
        max_count   : natural := 315800;
        sof_length  : natural := 400;
        on_time     : natural := 2048;
        off_time    : natural := 4096;
        eof_length  : natural := 1200;
        start_delay : natural := 5000;
        eof_delay   : natural := 2000;  
        no_of_pulse : natural := 50
     );
    Port 
    (
        clk   : in  std_logic;
        a_rstn: in  std_logic;
        sof   : out std_logic;                              -- start of frame , signal indicating the start
        pri   : out std_logic;                              -- pulse repetition interval 
        eof   : out std_logic                               -- end of frame , signal indicating the end 
    );
end pwm_mod;

architecture Behavioral of pwm_mod is
    signal pulse_width : std_logic_vector( 12 downto 0 );   -- width of a single pulse of pri
    signal pri_start   : std_logic_vector( 12 downto 0 );   -- starting of pri signal , (sof length + start delay of pri)
    signal pri_dur     : std_logic_vector( 18 downto 0 );   -- total duration of pri signal , ( no. of pulses * pulse width) 
    signal pri_end     : std_logic_vector( 18 downto 0 );   -- ending of pri signal , (pri start + pri duration )
    signal eof_start   : std_logic_vector( 18 downto 0 );   -- starting of eof signal , (pri end + eof delay)
    signal eof_end     : std_logic_vector( 18 downto 0 );   -- ending of eof signal , (eof start + eof length)
    signal glob_count  : std_logic_vector( 18 downto 0 );   -- global counter 
    signal pulse_count : std_logic_vector( 12 downto 0 );   -- counter for pri pulse
    signal pri_i       : std_logic;
    signal reset       : std_logic;
    signal a_rst       : std_logic;
    signal rst_cnt     : std_logic_vector( 3 downto 0 );
    signal reset_sig   : std_logic;
    
begin
   pulse_width <=  std_logic_vector(to_unsigned(on_time,13))     +  std_logic_vector(to_unsigned(off_time,13));
   pri_start   <=  std_logic_vector(to_unsigned(start_delay,13)) +  std_logic_vector(to_unsigned(sof_length,13));
   pri_dur     <=  std_logic_vector(to_unsigned(no_of_pulse,6))  *  pulse_width;
   pri_end     <=  ("000000" & pri_start) + pri_dur;
   eof_start   <=  pri_end   + std_logic_vector(to_unsigned(eof_delay,18));
   eof_end     <=  eof_start + std_logic_vector(to_unsigned(eof_length,18));
   pri         <=  pri_i;
   a_rst       <=  not(a_rstn); 
   reset_sig   <= '0' when rst_cnt = 12 else '1'; 
    
process(clk,a_rst)
begin
       if(a_rst = '1')then
            rst_cnt <= (others => '0');
       elsif rising_edge(clk) then
            If(rst_cnt < 12) then
                rst_cnt <= rst_cnt + 1;
            else
                rst_cnt <= rst_cnt;
            end if;
       end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
       reset <= reset_sig;
    end if;
end process;    
                    
process(clk)
begin
    if rising_edge(clk) then
        if( reset = '1' ) then
            pri_i         <= '0';
            pulse_count <= (others => '0');
         else            
            if( (glob_count >= ("00000" & pri_start)) and glob_count < pri_end ) then                
                    if( pulse_count < ( pulse_width - 1 )) then
                        pulse_count <= pulse_count + 1;
                            if( pulse_count < on_time ) then
                                pri_i <= '1';
                            else
                                pri_i <= '0';
                            end if;
                    else
                        pulse_count <= (others => '0');
                    end if;
            else 
                pri_i <= '0';                
            end if;
     end if;
   end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if( reset = '1' ) then
            glob_count  <= (others => '0');
        else
            if(glob_count < max_count) then 
              glob_count <= glob_count + 1;
            else
              glob_count <= (others => '0');
            end if;
        end if;
    end if;
end process;                              
   
process(reset,glob_count)
begin
    if(reset = '1') then
        sof <= '0';
    elsif(glob_count >= sof_length) then
        sof <= '0';
    else
        sof <= '1';
    end if;         
end process; 

process(reset,glob_count,eof_start,eof_end)
begin
    if(reset = '1') then
        eof <= '0';
    elsif((glob_count  >= eof_start) and (glob_count  < eof_end)) then
       eof <= '1';
    else
       eof <= '0';
    end if;         
end process;
  
end Behavioral;
