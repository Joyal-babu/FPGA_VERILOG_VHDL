----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.02.2025 16:15:43
-- Design Name: 
-- Module Name: top_module - Behavioral
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

entity top_module is
    Port ( 
            clock : in STD_LOGIC;
            reset : in STD_LOGIC
            );
end top_module;

architecture Behavioral of top_module is
    
    component data_genr is
        generic (
            data_limit : std_logic_vector(31 downto 0)
            );
        Port ( 
            clock      : in  STD_LOGIC;
            reset      : in  STD_LOGIC;
            valid      : out STD_LOGIC;
            data       : out STD_LOGIC_VECTOR(31 DOWNTO 0)
            );
    end component data_genr;

    component data_extd is
        generic (
            data_limit : std_logic_vector(31 downto 0)
            );
        Port ( 
            clock      : in STD_LOGIC;
            reset      : in STD_LOGIC;
            valid      : in STD_LOGIC;
            data       : in STD_LOGIC_VECTOR(31 DOWNTO 0)
            );
    end component data_extd;
    
    signal data  : std_logic_vector(31 downto 0);
    signal valid : std_logic;

    constant data_limit : std_logic_vector(31 downto 0) := x"00001450";           

begin

    data_genr_inst : data_genr
        generic map(
            data_limit => data_limit
            )
        port map(
            clock      => clock,
            reset      => reset,
            valid      => valid,
            data       => data 
            );

    data_extd_inst : data_extd
        generic map(
            data_limit => data_limit
            )
        port map(
            clock      => clock,
            reset      => reset,
            valid      => valid,
            data       => data 
            );


end Behavioral;
