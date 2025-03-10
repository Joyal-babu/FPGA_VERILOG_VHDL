----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2024 15:53:10
-- Design Name: 
-- Module Name: adder_test - Behavioral
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

entity adder_test is
    Port (  
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC; 
            clk_en : in  STD_LOGIC;
            in1    : in  STD_LOGIC_VECTOR(3 downto 0);
            in2    : in  STD_LOGIC_VECTOR(3 downto 0);
            in3    : in  STD_LOGIC_VECTOR(3 downto 0);
            resf   : out STD_LOGIC_VECTOR(4 downto 0)
         );
end adder_test;

architecture Behavioral of adder_test is

    COMPONENT c_addsub_0
      PORT (
        A    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        B    : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        CLK  : IN  STD_LOGIC;
        C_IN : IN  STD_LOGIC;
        CE   : IN  STD_LOGIC;
        SCLR : IN  STD_LOGIC;
        S    : OUT STD_LOGIC_VECTOR(4 DOWNTO 0) 
      );
    END COMPONENT;
    
    signal res1 : std_logic_vector(4 downto 0);
    signal res2 : std_logic_vector(4 downto 0);
    
    
begin

    resf <= res1;

    adder_inst1 : c_addsub_0
    PORT MAP 
        (
            A    => in1,
            B    => in2,
            CLK  => clk,
            C_IN => '0',
            CE   => clk_en,
            SCLR => rst,
            S    => res1
        );
    
--    adder_inst2 : c_addsub_0
--    PORT MAP 
--        (
--            A    => res1(3 downto 0),
--            B    => in3,
--            CLK  => clk,
--            C_IN => res1(4),
--            CE   => clk_en,
--            SCLR => rst,
--            S    => res2
--        );
        
--    adder_inst3 : c_addsub_0
--    PORT MAP 
--        (
--            A    => in3,
--            B    => in4,
--            CLK  => clk,
--            C_IN => '0',
--            CE   => clk_en,
--            SCLR => rst,
--            S    => res2
--        );

end Behavioral;
