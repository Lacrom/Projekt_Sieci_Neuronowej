
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.hardlims_funl.all;

entity packageCall is 
     generic ( b : integer := 8
              );
     
     port (  clk : in std_logic;
             n   : in signed (b-1 downto 0);
             wyj : out signed (b-1 downto 0)
             
           );
end entity packageCall;

architecture packageCall_Arch of packageCall is


begin


     wyj <= hardlims(n);
   
    
end architecture packageCall_Arch;
