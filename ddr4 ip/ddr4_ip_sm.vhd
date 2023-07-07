library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ddr4_ip_sm is
	port( sys_clk_p : in std_logic;
          sys_clk_n : in std_logic;
          ui_clk_in : in std_logic;
          reset     : in std_logic  );
          
architecture behaviour of ddr4_ip_sm is

component 
end component;

constant data_width : natural := 128;
constant data_depth : natural := 100;

type ext_data is array ((data_depth - 1) downto 0) of std_logic_vector ((data_width - 1) downto 0);

signal ddr4_data : ext_data := ( x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757",
                                 x"1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F",
                                 x"3657076365AD7652767DE78465DE6546",
                                 x"632874361089D782714634F786527EAD",
                                 x"732675676ADFCCCC675626AA75672966",
                                 x"72656106756346567AAAAAAAAAA89877",
                                 x"7260968376736024544156FF766523EA",
                                 x"7822997345763EDA6346245DEC657467",
                                 x"0895467154EAD6463576EDA565467226",
                                 x"27046EDAC623546DECF6745636BAEEDA",
                                 x"76354675ED63546BBD7876453BBA8757"  );
                                 
signal app_hi_pri     : std_logic :='0';
signal ddr4_addr      : std_logiv_vector(16 downto 0);
signal calib_complete : std_logic;
signal ddr4_ba        : std_logic_vector(1 downto 0);
signal ddr4_cke       : std_logic_vector(0 downto 0);
signal ddr4_cs_n      : std_logic_vector(0 downto 0);
signal ddr4_dm_dbi_n : std_logic_vector(1 downto 0);
signal ddr4_dq       : std_logic_vector(15 downto 0);
signal ddr4_dqs_c    : std_logic_vector(1 downto 0);
signal ddr4_dqs_t    : std_logic_vector(1 downto 0);
signal ddr4_odt      : std_logic_vector(0 downto 0);
signal ddr4_bg       : std_logic_vector(0 downto 0);
signal ddr4_reset_n  : std_logic;
signal ddr4_act_n    : std_logic;
signal ddr4_ck_c     : std_logic_vector(0 downto 0);
signal ddr4_ck_t     : std_logic_vector(0 downto 0);
signal ddr4_ui_clk   : std_logic;
signal ddr4_ui_clk_sync_rst   : std_logic;
signal ddr4_app_rd_data_end   : std_logic;
signal ddr4_app_rd_data_valid : std_logic;
signal ddr4_app_rdy           : std_logic;
signal ddr4_app_wdf_rdy       : std_logic;
signal ddr4_app_rd_data       : std_logic_vector(127 downto 0);
signal app_en        : std_logic;
signal app_wdf_end   : std_logic;
signal app_wdf_wren  : std_logic;
signal app_addr      : std_logic_vector(29 downto 0);
signal app_wdf_mask  : std_logic_vector(15 downto 0);
signal app_cmd       : std_logic_vector(2 downto 0);
signal app_wdf_data  : std_logic_vector(127 downto 0);

signal arr_index : std_logic_vector(10 downto 0);
signal cntr_1    : natural;

type state_type is (st1_reset, st2_ini_calib_complete_wait, st3_write, st4_read, st5_hold);
signal state, next_state : state_type;

begin

process(ui_clk_in) then
begin
	if(rising_edge(ui_clk_in)) then
    	if(reset = '1') then
        	state <= st1_reset;
        else 
        	state <= next_state;
        end if;
    end if;
    
process(state, ui_clk_in)
begin
	case(state) is 
    	when st1_reset => 
        	app_en <= '0';
            app_wdf_wren <= '0';
            app_wdf_end  <= '0';
            cntr_1       <=  0;
            app_addr     <= (others => '0');
            arr_index    <= (others => '0');
            app_wdf_data <= (others => '0');
            app_wdf_mask <= (others => '0');
            app_cmd      <= (others => '0');
            next_state   <= st2_ini_calib_complete_wait;
            
        when st2_ini_calib_complete_wait =>
        	if(rising_edge(ui_clk_in)) then
            	if(calib_complete <= '1') then 
                	next_state <= st3_write;
                else
                	next_state <= st2_ini_calib_complete_wait;
                end if;
             end if;
             
        when st3_write =>
        	if(rising_edge(ui_clk_in)) then
            	cntr_1 <= cntr_1 + 1;
                app_en <= '1';
                app_cmd <= "000";
                if(cntr_1 < 100) then
                	app_wdf_wren <= '1';
                    app_wdf_end  <= '1';
                    if(arr_index < 100) then
                    	arr_index <= arr_index + 1;
                        if(ddr4_app_rdy = '1' and ddr4_app_wdf_rdy = '1') then
                        	app_wdf_data <= ddr4_data(to_integer(unsigned(arr_index)));
