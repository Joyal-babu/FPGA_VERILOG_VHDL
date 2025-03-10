----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2025 11:35:13
-- Design Name: 
-- Module Name: data_comp_top - Behavioral
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

entity data_comp_top is
    Port ( clock      : in  STD_LOGIC;
           reset      : in  STD_LOGIC;
           comp_data  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
           data_valid : out STD_LOGIC
           );
end data_comp_top;

architecture Behavioral of data_comp_top is
    
    component data_genr is
    generic (
           data_lmt_gen : STD_LOGIC_VECTOR(31 DOWNTO 0)
           );
    Port ( clock        : in  STD_LOGIC;
           reset        : in  STD_LOGIC;
           data_out     : out STD_LOGIC_VECTOR(31 DOWNTO 0);
           data_vld     : out STD_LOGIC 
           );
    end component data_genr;
    
    component data_comp is
        generic (
            data_lmt_comp : std_logic_vector(31 downto 0)
            );
        Port ( 
            clock         : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            data_in       : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
            valid_in      : in  STD_LOGIC;       
            comp_data_out : out STD_LOGIC_VECTOR(31 DOWNTO 0);
            comp_data_vld : out STD_LOGIC                
            );
    end component data_comp;
    
    signal data_out : std_logic_vector(31 downto 0);
    signal data_vld : std_logic;
    
    constant data_lmt_gen  : std_logic_vector(31 downto 0) := x"00001800";
    constant data_lmt_comp : std_logic_vector(31 downto 0) := x"00001388";         -- data_lmt_comp value should be less then data_lmt_gen

begin

    data_genr_inst : data_genr
        generic map (
            data_lmt_gen => data_lmt_gen 
            )
        port map (
            clock        => clock,    
            reset        => reset,    
            data_out     => data_out,    
            data_vld     => data_vld      
            );
            
    data_comp_inst : data_comp
        generic map (
            data_lmt_comp  => data_lmt_comp
            )
        port map (
            clock          => clock,
            reset          => reset,
            data_in        => data_out,
            valid_in       => data_vld,
            comp_data_out  => comp_data,
            comp_data_vld  => data_valid
            );


end Behavioral;
