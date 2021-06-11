
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX is
   Port (
           CLK   : in STD_LOGIC;
           RESET : in STD_LOGIC;
           V     : in STD_LOGIC_VECTOR (2 downto 0):= "000"; 
           wyj   : out STD_LOGIC
         );
end entity MUX;

architecture MUX_Arch of MUX is

begin

wyj <=   '1' when V(0) = '1' and V(1) = '1' and V(2) = '1' else
         '0' when V(0) = '0' and V(1) = '0' and V(2) = '0' else
         '-';
         


end architecture MUX_Arch;
