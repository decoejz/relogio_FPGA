library IEEE;
use ieee.std_logic_1164.all;

entity my_display is
  port (
	 --Valor em binário do numero que seja mostrado. 10 = A , 11 = P
	 DisplayIN : in STD_LOGIC_VECTOR(3 downto 0); 
	 --Seleciona qual display será escrito
	 Seletor: in STD_LOGIC_VECTOR(2 downto 0);
	 --Passa o display que será escrito
     HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0)
  );
end entity;



architecture displayArch of my_display is

begin

     case Seletor is
	  
		when '000'=>
				display0 : entity work.my_conversor7seg
					Port map (saida7seg => HEX0, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		when '001'=>
				display1 : entity work.my_conversor7seg
					Port map (saida7seg => HEX1, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		when '010'=>
				display2 : entity work.my_conversor7seg
					Port map (saida7seg => HEX2, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		when '011'=>
				display3 : entity work.my_conversor7seg
					Port map (saida7seg => HEX3, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		when '100'=>
				display4 : entity work.my_conversor7seg
					Port map (saida7seg => HEX4, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		when '101'=>
				display5 : entity work.my_conversor7seg
					Port map (saida7seg => HEX5, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		when '110'=>
				display6 : entity work.my_conversor7seg
					Port map (saida7seg => HEX6, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		when '111'=>
				display7 : entity work.my_conversor7seg
					Port map (saida7seg => HEX7, dadoHex => DisplayIN, apaga => '0', overFlow => '0', negativo => '0');
		end case;
	 
end architecture;