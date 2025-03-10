----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2024 16:19:28
-- Design Name: 
-- Module Name: adder_test_tb - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_test_tb is
--  Port ( );
end adder_test_tb;

architecture Behavioral of adder_test_tb is

    component adder_test is
    Port (  
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC; 
            clk_en : in  STD_LOGIC;
            in1    : in  STD_LOGIC_VECTOR(3 downto 0);
            in2    : in  STD_LOGIC_VECTOR(3 downto 0);
            in3    : in  STD_LOGIC_VECTOR(3 downto 0);
            resf   : out STD_LOGIC_VECTOR(4 downto 0)
         );
    end component adder_test;
    
    signal clk     : std_logic := '0'; 
    signal rst     : std_logic := '0';
    signal clk_en  : std_logic := '0';
    signal in1     : std_logic_vector(3 downto 0) := (others => '0');
    signal in2     : std_logic_vector(3 downto 0) := (others => '0');
    signal in3     : std_logic_vector(3 downto 0) := (others => '0');
    signal resf    : std_logic_vector(4 downto 0) ;
     

begin

    clk    <= not clk  after 6.6666ns;
    rst    <= '1', '0' after 1000ns;
    clk_en <= '0', '1' after 1500ns;
    in1    <= "1111";
    in2    <= "1111";
    in3    <= "1111";

    DUT : adder_test
        port map
            (
                clk     => clk   ,
                rst     => rst   ,
                clk_en  => clk_en,
                in1     => in1   ,
                in2     => in2   ,
                in3     => in3   ,
                resf    => resf  
            );
        
end Behavioral;
