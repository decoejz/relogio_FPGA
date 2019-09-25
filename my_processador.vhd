
library IEEE;
use ieee.std_logic_1164.all;

entity my_processador is
    port
    (
       A : in std_logic
    );
end entity;

architecture processadorArc of my_processador is


begin

	ula1 : entity work.my_ula
		Port map (A => A,B => B,func => "00", Y => Y, Z => Z)
    
end architecture;