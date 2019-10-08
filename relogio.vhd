library IEEE;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity relogio is
	Generic ( 
		TOTAL_SW : natural := 3; --Quantidade total de chaves
		TOTAL_KEY : natural := 2; --Quantidade total de botoes
		DATA_WIDTH : natural := 8; --Tamanho dos dados
		PC_SIZE : natural := 10 --Tamanho total de instrucoes na ROM
	);
	port
	(
		CLOCK_50 : in std_logic; --Clock de 50M
		SW : in std_logic_vector(17 downto 0); --Entrada das chaves
		KEY : in std_logic_vector(3 downto 0); --Entrada dos botoes
		
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0); --Saida para os displays

		LEDR : out std_logic_vector(17 downto 0); --Saida para os leds vermelhos
		LEDG : out std_logic_vector(7 downto 0) --Saida para os leds verdes
		
	);
end entity;

architecture relogioArc of relogio is

	--Sinais utilizados para conectar todas as entidades
	signal sig_data_in, sig_data_out : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal sig_rom_in : std_logic_vector(24 downto 0);
	signal sig_rom_out : std_logic_vector(PC_SIZE-1 downto 0);
	signal sig_add : std_logic_vector(9 downto 0);
	signal sig_red, sig_wed, sig_es70, sig_es71, sig_es72, sig_es73, sig_es74, sig_es75, sig_es76, sig_es77, sig_sesw, sig_ekey, sig_ebt : std_logic;
	  
begin
	--Conecta todas as entidades, fazendo o relogio funcionar 
	
	--Port Map do processador
	CPU: entity work.my_processador
		Generic Map (DATA_PC_SIZE=>PC_SIZE)
		Port Map(
			data_in => sig_data_in,
			ROM_in => sig_rom_in,
			clk => CLOCK_50,
			ROM_out => sig_rom_out,
			data_out => sig_data_out,
			addr => sig_add,
			readEnableDecoder => sig_red,
			writeEnableDecoder => sig_wed 
		 );
	
	--Port Map do decoder 
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
	
	--Port Map das chaves
	SW_MAP: entity work.my_sw
		Generic Map( 
			TOTAL_SW => TOTAL_SW,
			DATA_SIZE => DATA_WIDTH
		)
		Port Map(
			sw_in => SW(TOTAL_SW-1 downto 0),
			enable => sig_sesw,
			sw_out => sig_data_in,
			indicaLed => LEDR(TOTAL_SW-1 downto 0)
		);
	
	--Port Map dos bototes
	KEY_MAP: entity work.my_key
		Generic Map(
			TOTAL_KEY => TOTAL_KEY,
			DATA_SIZE => DATA_WIDTH
		)
		Port Map(
		   led_in=> LEDG(TOTAL_KEY-1 downto 0),
			key_in => KEY(TOTAL_KEY-1 downto 0),
			enable => sig_ekey,
			key_out => sig_data_in
		);
		
	--Port Map da base de tempo
	BT_MAP: entity work.my_base_tempo
		Generic Map(BT_RAPIDO=>5000)
		Port Map(
			clk => CLOCK_50,
			sw_in => SW(17),
			enable => sig_ebt,
			ledRapido => LEDR(17),
			reset => sig_data_out(0),
			readEnable => sig_red,
			saida_clk => sig_data_in,
			writeEnable=>sig_wed
		);
	
	--Port Map da ROM
	ROM: entity work.my_memoryROM
		Generic Map(
        dataWidth => 25,
        addrWidth => PC_SIZE
		)
		Port Map(
			Endereco => sig_rom_out,
			Dado => sig_rom_in
		);
	
	--Port Map do display 0
	DISPLAY0: entity work.my_conversor7seg
		Port Map(saida7seg => HEX0, dadoHex => sig_data_out(3 downto 0), enable => sig_es70, clk => CLOCK_50);
	
	--Port Map do display 1
	DISPLAY1: entity work.my_conversor7seg
		Port Map(saida7seg => HEX1, dadoHex => sig_data_out(3 downto 0), enable => sig_es71, clk => CLOCK_50);
		
	--Port Map do display 2
	DISPLAY2: entity work.my_conversor7seg
		Port Map(saida7seg => HEX2, dadoHex => sig_data_out(3 downto 0), enable => sig_es72, clk => CLOCK_50);
	
	--Port Map do display 3
	DISPLAY3: entity work.my_conversor7seg
		Port Map(saida7seg => HEX3, dadoHex => sig_data_out(3 downto 0), enable => sig_es73, clk => CLOCK_50);
		
	--Port Map do display 4
	DISPLAY4: entity work.my_conversor7seg
		Port Map(saida7seg => HEX4, dadoHex => sig_data_out(3 downto 0), enable => sig_es74, clk => CLOCK_50);
		
	--Port Map do display 5
	DISPLAY5: entity work.my_conversor7seg
		Port Map(saida7seg => HEX5, dadoHex => sig_data_out(3 downto 0), enable => sig_es75, clk => CLOCK_50);
		
	--Port Map do display 6
	DISPLAY6: entity work.my_conversor7seg
		Port Map(saida7seg => HEX6, dadoHex => sig_data_out(3 downto 0), enable => sig_es76, clk => CLOCK_50);
		
	--Port Map do display 7
	DISPLAY7: entity work.my_conversor7seg
		Port Map(saida7seg => HEX7, dadoHex => sig_data_out(3 downto 0), enable => sig_es77, clk => CLOCK_50);
	
end architecture;