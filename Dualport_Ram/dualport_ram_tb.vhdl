----------------------------------------------------------------------------------
-- Company: 
-- Engineer: JOYAL
-- 
-- Create Date: 03.12.2023 22:02:13
-- Design Name: 
-- Module Name: dualport_ram_tb - Behavioral
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

entity dualport_ram_tb is
    --  Port ( );
end dualport_ram_tb;

architecture Behavioral of dualport_ram_tb is

    component dualport_ram is
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
    end component;

    constant data_width : natural := 16;
    constant ram_depth  : natural := 1024;

    signal clka, clkb, reset, en_b, wea : STD_LOGIC := '0';
    signal addra, addrb        : STD_LOGIC_VECTOR (9 downto 0)  := (others => '0');
    signal datain_a, dataout_b : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

begin
    
    clka  <= not clka after 5ns;
    clkb  <= not clkb after 10ns;
    reset <= '1', '0' after 500ns;
    
    process
    begin
        wait until reset = '0';
        wait for 100ns;
        
        for i in 0 to (ram_depth-1) loop
            wea <= '1';
            wait until clka = '1';
            datain_a <= datain_a + x"000F";
            addra    <= addra + 1;             
        end loop;
        
        wea <= '0';
        wait for 100ns;
        
        for i in 0 to (ram_depth-1) loop
            en_b <= '1';
            wait until clkb = '1';
            addrb    <= addrb + 1;             
        end loop; 
        
              
        
        wea <= '1'; 
        datain_a <= x"0064";
        addra <= x"00" & "11";
        --en_b <= '1';
        addrb <= x"0D" & "01";
        
        
            
    end process;
    
    
    DUT : dualport_ram
        generic map( data_width => data_width,
                     ram_depth   => ram_depth )

        port map ( clka      => clka,
                   clkb      => clkb,
                   reset     => reset,
                   en_b      => en_b,
                   addra     => addra,
                   addrb     => addrb,
                   datain_a  => datain_a,
                   wea       => wea,
                   dataout_b => dataout_b
                );
    

end Behavioral;
