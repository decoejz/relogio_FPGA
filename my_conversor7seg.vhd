
library IEEE;
use ieee.std_logic_1164.all;

entity conversorHex7seg is
    port
    (
        -- Input ports
        -- Recebe o valor em binário do que será mostrado
        dadoHex  : in  std_logic_vector(3 downto 0);
		  
		  enable : in std_logic;
        -- Valores condicionais sem ser do relógio
        apaga    : in  std_logic := '0';
        negativo : in  std_logic := '0';
        overFlow : in  std_logic := '0';
        -- Output ports
        -- Desenho do display em bits
        saida7seg : out std_logic_vector(6 downto 0) 
    );
end entity;

architecture comportamento of conversorHex7seg is
   --
   --       0
   --      ---
   --     |   |
   --    5|   |1
   --     | 6 |
   --      ---
   --     |   |
   --    4|   |2
   --     |   |
   --      ---
   --       3
   --

  signal rascSaida7seg: std_logic_vector(6 downto 0);

begin
    rascSaida7seg <=    	"1000000" when (dadoHex="0000" AND enable='1') else ---0
                            "1111001" when (dadoHex="0001" AND enable='1') else ---1
                            "0100100" when (dadoHex="0010" AND enable='1') else ---2
                            "0110000" when (dadoHex="0011" AND enable='1') else ---3
                            "0011001" when (dadoHex="0100" AND enable='1') else ---4
                            "0010010" when (dadoHex="0101" AND enable='1') else ---5
                            "0000010" when (dadoHex="0110" AND enable='1') else ---6
                            "1111000" when (dadoHex="0111" AND enable='1') else ---7
                            "0000000" when (dadoHex="1000" AND enable='1') else ---8
                            "0010000" when (dadoHex="1001" AND enable='1') else ---9
                            "0001000" when (dadoHex="1010" AND enable='1') else ---A
                            "1110011" when (dadoHex="1011" AND enable='1') else ---P
									 
                            "1111111"; -- Apaga todos segmentos.

    saida7seg <=     		"1100010" when (overFlow='1') else
                            "1111111" when (apaga='1' and negativo='0') else
                            "0111111" when (apaga='0' and negativo='1') else
									 rascSaida7seg;
end architecture;