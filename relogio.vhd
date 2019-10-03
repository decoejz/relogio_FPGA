library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity relogio is
	Generic ( 
		TOTAL_SW : natural := 3;
		TOTAL_KEY : natural := 2;
		DATA_WIDTH : natural := 8
	);
	port
	(
		clk : in std_logic;
		SW : in std_logic_vector(17 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0)		
	);
end entity;

architecture relogioArc of relogio is

	signal sig_data_in, sig_data_out : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal sig_rom_in : std_logic_vector(24 downto 0);
	signal sig_rom_out : std_logic_vector(9 downto 0);
	signal sig_add : std_logic_vector(7 downto 0);
	signal sig_red, sig_wed, sig_es70, sig_es71, sig_es72, sig_es73, sig_es74, sig_es75, sig_es76, sig_es77, sig_sesw, sig_ekey, sig_ebt : std_logic;

begin
    
	 CPU: entity work.my_processador
		Port Map(
			data_in => sig_data_in,
			ROM_in => sig_rom_in,
			clk => clk,
			ROM_out => sig_rom_out,
			data_out => sig_data_out,
			addr => sig_add,
			readEnableDecoder => sig_red,
			writeEnableDecoder => sig_wed
		 );
		 
	DECODER: entity work.my_decoder
		Port Map(
			 add_in => sig_add,
			 readEnable => sig_red,
			 writeEnable => sig_wed,
			 eseg70 => sig_es70,
			 eseg71 => sig_es71,
			 eseg72 => sig_es72,
			 eseg73 => sig_es73,
			 eseg74 => sig_es74,
			 eseg75 => sig_es75,
			 eseg76 => sig_es76,
			 eseg77 => sig_es77,
			 esw => sig_sesw,
			 ekey => sig_ekey,
			 ebt => sig_ebt
		);
	
	SW_MAP: entity work.my_sw
		Generic Map( 
			TOTAL_SW => TOTAL_SW,
			DATA_SIZE => DATA_WIDTH
		)
		Port Map(
			sw_in => SW(TOTAL_SW-1 downto 0),
			enable => sig_sesw,
			sw_out => sig_data_in
		);
		
	KEY_MAP: entity work.my_key
		Generic Map(
			TOTAL_KEY => TOTAL_KEY,
			DATA_SIZE => DATA_WIDTH
		)
		Port Map(
			key_in => KEY(TOTAL_KEY-1 downto 0),
			enable => sig_ekey,
			key_out => sig_data_in
		);
	
	BT_MAP: entity work.my_base_tempo
		Port Map(
			clk => clk,
			sw_in => SW(17),
			enable => sig_ebt,
			saida_clk => sig_data_in
		);
		
	ROM: entity work.my_memoryROM
		Generic Map(
        dataWidth => 25,
        addrWidth => 10
		)
		Port Map(
			Endereco => sig_rom_out,
			Dado => sig_rom_in
		);
	
	DISPLAY0: entity work.my_conversor7seg
		Port Map(saida7seg => HEX0, dadoHex => sig_data_out(3 downto 0), enable => sig_es70, apaga => '0', overFlow => '0', negativo => '0');
	
	DISPLAY1: entity work.my_conversor7seg
		Port Map(saida7seg => HEX1, dadoHex => sig_data_out(3 downto 0), enable => sig_es71, apaga => '0', overFlow => '0', negativo => '0');
		
	DISPLAY2: entity work.my_conversor7seg
		Port Map(saida7seg => HEX2, dadoHex => sig_data_out(3 downto 0), enable => sig_es72, apaga => '0', overFlow => '0', negativo => '0');
		
	DISPLAY3: entity work.my_conversor7seg
		Port Map(saida7seg => HEX3, dadoHex => sig_data_out(3 downto 0), enable => sig_es73, apaga => '0', overFlow => '0', negativo => '0');
		
	DISPLAY4: entity work.my_conversor7seg
		Port Map(saida7seg => HEX4, dadoHex => sig_data_out(3 downto 0), enable => sig_es74, apaga => '0', overFlow => '0', negativo => '0');
		
	DISPLAY5: entity work.my_conversor7seg
		Port Map(saida7seg => HEX5, dadoHex => sig_data_out(3 downto 0), enable => sig_es75, apaga => '0', overFlow => '0', negativo => '0');
		
	DISPLAY6: entity work.my_conversor7seg
		Port Map(saida7seg => HEX6, dadoHex => sig_data_out(3 downto 0), enable => sig_es76, apaga => '0', overFlow => '0', negativo => '0');
		
	DISPLAY7: entity work.my_conversor7seg
		Port Map(saida7seg => HEX7, dadoHex => sig_data_out(3 downto 0), enable => sig_es77, apaga => '0', overFlow => '0', negativo => '0');
	
end architecture;