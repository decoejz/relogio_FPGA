
library IEEE;
use ieee.std_logic_1164.all;

entity my_uc is
    port
    (
       opcode : in std_logic_vector(4 downto 0); -- OPCODE que vem direto da ROM
		 jle : in std_logic; -- Variavel que salva se um valor A > B
		 je : in std_logic; -- Variavel que salva se um valor A = B
		 jbe : in std_logic; -- Variavel que salva se um valor A < B
		 
		 muxPc : out std_logic; -- MUX que define se o pc pula instrucao ou soma 1
		 muxRegUla : out std_logic; -- MUX que define se o dado que entra na ULA vem do imediato ou registrador
		 funcUla : out std_logic_vector(2 downto 0); -- Funcao que a ULA deve fazer
		 muxRegSai : out std_logic; -- MUX que define para onde vai o resultado da ULA
		 weBC : out std_logic; -- Habilita ou desabilita a escrita no banco de registradores
		 readEnable : out std_logic; -- Habilita o read do decoder
		 writeEnable : out std_logic -- Habilita o write do decoder
    );
end entity;

architecture ucArc of my_uc is
	
begin

	process(opcode, jle, je, jbe)
	begin
		
		-- ADD R1, R2, R3
		if (opcode = "00000") then
			muxPc <= '0';
			muxRegUla <= '1';
			funcUla <= "000";
			muxRegSai <= '1';
			weBC <= '1';
			readEnable <= '0';
			writeEnable <= '0';
		 
		-- ADDi R1, R2 Imediato
		elsif (opcode = "00001") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "000";
			muxRegSai <= '1';
			weBC <= '1';
			readEnable <= '0';
			writeEnable <= '0';
		
		-- LOAD R, End
		elsif (opcode = "00010") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "011";
			muxRegSai <= '0';
			weBC <= '0';
			readEnable <= '0';
			writeEnable <= '1';
		
		-- JMP Imediato
		elsif (opcode = "00011") then
			muxPc <= '1';
			muxRegUla <= '0';
			funcUla <= "011";
			muxRegSai <= '1';
			weBC <= '0';
			readEnable <= '0';
			writeEnable <= '0';
		
		-- CMPi R1, R2, Imediato
		elsif (opcode = "00100") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "001";
			muxRegSai <= '1';
			weBC <= '1';
			readEnable <= '0';
			writeEnable <= '0';
		
		-- Lea End, R
		elsif (opcode = "00101") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "011";
			muxRegSai <= '0';
			weBC <= '1';
			readEnable <= '1';
			writeEnable <= '0';
		
		-- JLE Imediato
		-- A CMPi devolve uma flag dizendo se é maior ou nao,
		-- decidindo se pula
		elsif (opcode = "00110") then
			muxPc <= not (jle);
			muxRegUla <= '0';
			funcUla <= "011";
			muxRegSai <= '0';
			weBC <= '0';
			readEnable <= '0';
			writeEnable <= '0';
		
		-- LEAi R, Imediato
		-- Salva o valor imediato no registrador R
		elsif (opcode = "00111") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "011";
			muxRegSai <= '1';
			weBC <= '1';
			readEnable <= '0';
			
		-- JE Imediato
		-- Pula baseado na flag indicando se o valor é igual
		elsif (opcode = "01000") then
			muxPc <= je;
			muxRegUla <= '0';
			funcUla <= "011";
			muxRegSai <= '0';
			weBC <= '0';
			readEnable <= '0';
			writeEnable <= '0';
			
		-- JBE Imediato
		-- Pula baseado na flag indicando se o valor é igual
		elsif (opcode = "01001") then
			muxPc <= jbe;
			muxRegUla <= '0';
			funcUla <= "011";
			muxRegSai <= '0';
			weBC <= '0';
			readEnable <= '0';
			
		-- CMPe R1, R2, Imediato
		-- R2 = se(R1 = imediato)
		elsif (opcode = "01010") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "100";
			muxRegSai <= '1';
			weBC <= '1';
			readEnable <= '0';
			writeEnable <= '0';
			
		-- CMPle R1, R2, Imediato
		-- R2 = se(R1 < imediato)
		elsif (opcode = "01011") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "101";
			muxRegSai <= '1';
			weBC <= '1';
			readEnable <= '0';
			writeEnable <= '0';
		
			end if;
	end process;
	
end architecture;