library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity fsm_count_hold_count is
	port( clk   : in std_logic;
    	  reset : in std_logic  );
end fsm_count_hold_count;

architecture Behavioral of seq_detect_000 is

constant hold_at   : natural  := 200;
constant hold_lmt  : natural  := 100;
constant count_lmt : natural  := 400;

type state_type is (st1_reset, st2_count, st3_hold, st4_count_resume);
signal state,next_state : state_type;

signal count      : std_logic_vector(10 downto 0);
signal hold_count : std_logic_vector(7 downto 0);

begin

process(clk)
begin
	if(rising_edge(clk)) then
    	if(reset = '1') then
        	state <= st1_reset;
        else
        	state <= next_state;
        end if;
    end if;
end process;

process(clk, state)
begin
	case(state) is
    	when st1_reset => 
        	count      <= (others => '0');
            hold_count <= (others => '0');
            next_state <= st2_count;
            
        when st2_count =>
        	if(rising_edge(clk)) then
            	if(count = hold_at) then
                	next_state <= st3_hold;
                else
                	count <= count + 1;
                end if;
            end if;
            
        when st3_hold =>
        	if(rising_edge(clk)) then
            	if(hold_count = hold_lmt) then
                	hold_count <= hold_count;
                    next_state <= st4_count_resume;
                else
                	hold_count <= hold_count + 1;
                    count <= count;
                end if;
            end if;
            
        when st3_count_resume =>
        	if(rising_edge(clk)) then
            	if(count = count_lmt) then
                    next_state <= st1_reset;
                else
                	count <= count + 1;
                end if;
            end if;
        
        when others =>
        	next_state <= st1_reset;
   end case;
end process;

end Behavioral;
