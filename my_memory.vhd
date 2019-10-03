library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_memory IS
     generic (
          dataWidth: natural := 16;
          addrWidth: natural := 4
     );
    port (
        clk : IN STD_LOGIC;
            Endereco : IN STD_LOGIC_VECTOR (addrWidth-1 DOWNTO 0);
        Dado : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
end entity;

architecture sincrona OF my_memory IS

   
begin
    

end architecture;