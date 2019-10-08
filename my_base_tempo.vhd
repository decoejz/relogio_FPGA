LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity my_base_tempo is
	Generic ( DATA_SIZE : natural := 8; --Tamanho do dado que deve ser enviado para o processador
            BT_RAPIDO : natural := 25000000 --Valor que deve ser usado para fazer a base de tempo mais rapida ou mais devagar que 1 segundo
    );
    port(
        clk : in std_logic;
        sw_in : in std_logic; --Chave que define qual a base de tempo que sera utilizada
        enable : in std_logic; --Habilita leitura de envio para o processador
		  
		reset : in std_logic; --Se a escrita estiver habilitada, ele zera a contagem
		readEnable : in std_logic; --Habilita leitura
		writeEnable : in std_logic; --Habilita escrita
		
		ledRapido : out std_logic; --Led que indica se a base esta em 1 segundo (apagado) ou mais rapido/devagar (ligado)
        saida_clk : out std_logic_vector(DATA_SIZE-1 downto 0)
    );
end entity;

architecture divInteiro of my_base_tempo is
    signal tick : std_logic := '0';
    signal divisor : natural := 50000000;
    signal contador : integer range 0 to 100000000 := 0;
begin
	divisor <= 50000000 when sw_in='0' else BT_RAPIDO; --Configura qual a base de tempo baseado na chave
	ledRapido <= sw_in; --Acende o led baseado na chave
    
    process(clk)
    begin
        if rising_edge(clk) then
			if (reset='1' AND writeEnable='1') then
				contador <= 0;
            -- contador e comparador
            elsif contador >= divisor then
                tick <= '1';
            else
                contador <= contador + 1;
				tick <= '0';
            end if;
        end if;
	end process;
    --Saida do clock em 8 bits quando enable, no contrário saida é impedância
	saida_clk <= ("0000000" & tick) when (enable='1' AND readEnable='1') else "ZZZZZZZZ";
end architecture divInteiro;