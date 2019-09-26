
library IEEE;
use ieee.std_logic_1164.all;

entity my_uc is
    port
    (
       opcode : in std_logic_vector(4 downto 0); -- OPCODE que vem direto da ROM
		 
		 muxPc : out std_logic; -- MUX que define se o pc pula instrucao ou soma 1
		 muxRegUla : out std_logic; -- MUX que define se o dado que entra na ULA vem do imediato ou registrador
		 funcUla : out std_logic_vector(1 downto 0); -- Funcao que a ULA deve fazer
		 muxRegSai : out std_logic; -- MUX que define para onde vai o resultado da ULA
		 weBC : out std_logic -- Habilita ou desabilita a escrita no banco de registradores
    );
end entity;

architecture ucArc of my_uc is


begin

	process(opcode)
	begin
		
		-- ADD R1, R2, R3
		if (opcode = "00000") then
			muxPc <= '0';
			muxRegUla <= '1';
			funcUla <= "00";
			muxRegSai <= '1';
			weBC <= '1';
		 
		-- ADDi R1, R2 Imediato
		elsif (opcode = "00001") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "00";
			muxRegSai <= '1';
			weBC <= '1';
		
		-- LOAD R, End
		elsif (opcode = "00010") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "11";
			muxRegSai <= '0';
			weBC <= '0';
		
		-- JMP Imediato
		elsif (opcode = "00011") then
			muxPc <= '1';
			muxRegUla <= '0';
			funcUla <= "11";
			muxRegSai <= '1';
			weBC <= '0';
		
		-- CMPi R1, R2, Imediato
		elsif (opcode = "00100") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "01";
			muxRegSai <= '1';
			weBC <= '1';
		
		-- Lea End, R
		elsif (opcode = "00101") then
			muxPc <= '0';
			muxRegUla <= '0';
			funcUla <= "11";
			muxRegSai <= '0';
			weBC <= '1';
		
		-- JLE R, Imediato
		-- elsif (opcode = "00110") then
		--		muxPc <= '';
		-- 	muxRegUla <= '';
		-- 	funcUla <= "";
		-- 	muxRegSai <= '';
		-- 	weBC <= '';
				
			end if;
	end process;
	
end architecture;