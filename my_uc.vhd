
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
		 writeEnable : out std_logic; -- Habilita o write do decoder
		 muxRegEsc : out std_logic -- Habilita qual o endereco de escrita no banco de registradores
    );
end entity;

architecture ucArc of my_uc is

--ADD R1, R2, R3 : R3=R2+R1
constant ADD : std_logic_vector(4 downto 0) := "00000";

--ADDi R1, R2 Imediato : R2=R1+Imediato
constant ADDi : std_logic_vector(4 downto 0) := "00001"

--LOAD R, End : Move o que esta em R para o End
constant LOAD : std_logic_vector(4 downto 0) := "00010";

--JMP Imediato : Pula para a linha da ROM referente ao Imediato
constant JMP : std_logic_vector(4 downto 0) := "00011";

--CMPi R1, R2, Imediato : Compara se o valor de R1 > Imediato e salva em R2
constant CMPi : std_logic_vector(4 downto 0) := "00100";

--LEA End, R : Le as informacoes do End e salva em R
constant LEA : std_logic_vector(4 downto 0) := "00101";

--JLE Imediato : A CMPi devolve uma flag dizendo se é maior ou nao, decidindo se pula para o Imediato
constant JLEC : std_logic_vector(4 downto 0) := "00110";

--LEAi R, Imediato : Salva o valor imediato no registrador R
constant LEAi : std_logic_vector(4 downto 0) := "00111";

--JE Imediato : Pula para o Imediato baseado na flag indicando se o valor é igual
constant JEC : std_logic_vector(4 downto 0) := "01000";

--JBE Imediato : Pula para o Imediato baseado na flag indicando se o valor é igual
constant JBEC : std_logic_vector(4 downto 0) := "01001";

--CMPe R1, R2, Imediato : Salva em R2 se R1 = Imediato
constant CMPe : std_logic_vector(4 downto 0) := "01010";

--CMPle R1, R2, Imediato : Salva em R2 se R1 < Imediato
constant CMPle : std_logic_vector(4 downto 0) := "01011";
	
begin

	muxPc <= '1' when opcode = JMP else
				not (jle) when opcode = JLEC else
				je when opcode = JEC else
				jbe when opcode = JBEC else
				'0';
				
	muxRegUla <= '1' when opcode=ADD OR opcode=LOAD OR opcode=LEA else
					 '0';
	
	funcUla <= "000" when opcode=ADD OR opcode=ADDi else
				  "001" when opcode=CMPi else
				  "011" when opcode=LOAD OR opcode=LEAi else
				  "100" when opcode=CMPe else
				  "101" when opcode=CMPle else
				  "111";
				  
 	muxRegSai <= '1' when opcode=ADD OR opcode=ADDi OR
								 opcode=CMPi OR opcode=LEAi OR opcode=CMPe OR opcode=CMPle else
					 '0';
					 
	weBC <= '1' when opcode=ADD OR opcode=ADDi OR opcode=CMPi OR opcode=LEA OR
						  opcode=LEAi OR opcode=CMPe OR opcode=CMPle else
			  '0';
			  
	readEnable <= '1' when opcode=LEA else
					  '0';
	
	writeEnable <= '1' when opcode=LOAD else
						'0';
						
	muxRegEsc <= '0' when opcode=ADD else
					 '1';
					 
end architecture;