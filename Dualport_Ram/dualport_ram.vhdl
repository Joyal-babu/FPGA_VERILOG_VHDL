----------------------------------------------------------------------------------
-- Company: 
-- Engineer: JOYAL 
-- 
-- Create Date: 02.12.2023 13:16:47
-- Design Name: 
-- Module Name: dualport_ram - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dualport_ram is
    generic( data_width : natural := 16;
            ram_depth   : natural := 1024
           );

    Port ( clka    : in STD_LOGIC;
         clkb      : in STD_LOGIC;
         reset     : in STD_LOGIC;
         en_b      : in STD_LOGIC;
         addra     : in STD_LOGIC_VECTOR (9 downto 0);
         addrb     : in STD_LOGIC_VECTOR (9 downto 0);
         datain_a  : in STD_LOGIC_VECTOR (15 downto 0);
         wea       : in STD_LOGIC;
         dataout_b : out STD_LOGIC_VECTOR (15 downto 0)
        );
end dualport_ram;

architecture Behavioral of dualport_ram is

    -- constant data_width : natural := 16;
    -- constant ram_depth  : natural := 1024;

    signal addra_i : STD_LOGIC_VECTOR (9 downto 0);
    signal addrb_i : STD_LOGIC_VECTOR (9 downto 0);
    signal wea_i   : STD_LOGIC;

    -- declaring array to store ram data

    type ar_mem is array ((ram_depth-1) downto 0) of STD_LOGIC_VECTOR((data_width-1) downto 0);
    signal dp_ram : ar_mem;

begin

    wea_i   <= '0' when reset = '1' else wea;
    addra_i <= addra;
    addrb_i <= addrb;

    -- 2 clocks

    process(clka)
    begin
        if(rising_edge(clka)) then
            if(wea_i = '1') then
                dp_ram(to_integer(unsigned(addra_i))) <= datain_a;
            end if;
        end if;
    end process;

    process(clkb, reset)
    begin
        if(reset = '1') then
            dataout_b <= (others => '0');
        elsif(rising_edge(clkb)) then
            if(en_b = '1') then
                dataout_b <= dp_ram(to_integer(unsigned(addrb_i)));
            end if;
        end if;
    end process;
    
      -- 1 clock
    
--    process(clka, reset)
--    begin 
--        if(reset = '1') then
--            dataout_b <= (others => '0');
--        elsif(rising_edge(clka)) then
--            if(wea_i = '1') then
--                dp_ram(to_integer(unsigned(addra_i))) <= datain_a;
--            end if;  
--            if(en_b = '1') then
--                dataout_b <= dp_ram(to_integer(unsigned(addrb_i)));
--            end if;    
--        end if;
--    end process;

end Behavioral;
