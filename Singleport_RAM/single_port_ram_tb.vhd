----------------------------------------------------------------------------------
-- Company: 
-- Engineer: JOYAL
-- 
-- Create Date: 22.11.2023 23:17:14
-- Design Name: 
-- Module Name: single_port_ram_tb - Behavioral
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

entity single_port_ram_tb is
    --  Port ( );
end single_port_ram_tb;

architecture Behavioral of single_port_ram_tb is

    component single_port_ram is
        generic(
            data_width : integer;
            ram_depth  : integer
        );
        Port (
            clock      : in  STD_LOGIC;
            reset      : in  STD_LOGIC;
            data_ina   : in  STD_LOGIC_VECTOR (15 downto 0);
            addra      : in  STD_LOGIC_VECTOR (9 downto 0);
            we_a       : in  STD_LOGIC;
            data_outa  : out STD_LOGIC_VECTOR (15 downto 0);
            rd_data_valid : out STD_LOGIC );
    end component;

    constant data_width : integer := 16;
    constant ram_depth  : integer := 1024;


    signal clock, reset, we_a, rd_data_valid : std_logic := '0';
    signal data_ina, data_outa               : std_logic_vector(15 downto 0) := (others => '0');
    signal addra                             : std_logic_vector(9 downto 0)  := (others => '0');

begin

    DUT : single_port_ram
        generic map(
            data_width => data_width,
            ram_depth  => ram_depth
        )
        port map(
            clock         => clock,
            reset         => reset,
            data_ina      => data_ina,
            addra         => addra,
            we_a          => we_a,
            data_outa     => data_outa,
            rd_data_valid => rd_data_valid
        );

    clock <= not clock after 5 ns;
    reset <= '1', '0'  after 500 ns;


    process
    begin
        wait until reset = '0';
        --wait on reset;

        for i in 0 to (ram_depth-1) loop
            we_a <= '1';
            wait until clock = '1';
            data_ina <= data_ina + x"000F";
            addra    <= addra + '1';
        end loop;
        
        wait for 60 ns;
        addra <= (others => '0');
        we_a  <= '0';
        
        for i in 0 to (ram_depth-1) loop
            wait until clock = '1';
            addra <= addra + '1';
        end loop;
        
    end process;

end Behavioral;
