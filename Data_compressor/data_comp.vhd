----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2025 11:39:27
-- Design Name: 
-- Module Name: data_comp - Behavioral
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

entity data_comp is
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
end data_comp;

architecture Behavioral of data_comp is

    signal count : std_logic_vector(31 downto 0);
    signal valid : std_logic;             
    signal data  : std_logic_vector(31 downto 0);

begin
    
    comp_data_out  <= data;
    comp_data_vld  <= valid;
    
    process(clock, reset)
    begin
        if(rising_edge(clock)) then
            if(reset = '1') then
                count <= (others => '0');
            elsif(valid_in = '1') then
                count <= count + '1';
            else
                count <= (others => '0'); 
            end if;
        end if;
    end process;
    
    valid  <= '1' when (count <= (data_lmt_comp - 1) and valid_in = '1') else '0';
    data   <= data_in when valid = '1' else (others => '0');

end Behavioral;
