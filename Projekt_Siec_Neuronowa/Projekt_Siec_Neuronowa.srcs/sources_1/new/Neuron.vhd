library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library Funk_Aktywac;
use Funk_Aktywac.all;


entity Neuron is
   generic( r : integer :=3;
            b : integer :=4);
   
   Port (
         CLK        : in std_logic;  
         x1         : in signed (b-1 downto 0);
         x2         : in signed (b-1 downto 0);
         x3         : in signed (b-1 downto 0);
         w          : in signed (b-1 downto 0);
         y          : out signed (2*b-1 downto 0)
         );  
             
         
end entity Neuron;

architecture Neuron_Arch of Neuron is

Component packageCall is
    generic ( b : integer := 4
              );
    Port ( CLK : in std_logic;
           n   : in signed (b-1 downto 0);
           wyj : out signed (b-1 downto 0)
          );
end component packageCall;

signal n_tym : signed (2*b-1 downto 0);
--signal y_tym : signed (2*b-1 downto 0);
signal y_p : signed (2*b-1 downto 0);


type weights is array (1 to r) of signed (b-1 downto 0);
type inputs is array (1 to r) of signed (b-1 downto 0);

begin
process (CLK, w, x1, x2, x3)
variable weight : weights;
variable input : inputs;
variable prod, accumulate : signed (2*b-1 downto 0);
begin    
          if (CLK'event and CLK = '1') then
              weight := w & weight (1 to r-1);
          end if;
input (1) := x1;
input (2) := x2;
input (3) := x3;
accumulate := (others => '0');

l1: for j in 1 to r loop 
prod := input (j)*weight (j);
accumulate := accumulate + prod;
end loop l1;
y_p <= accumulate;
end process;

pack1 : packageCall generic map( b => 8)
                    port map (
                              clk => CLK,
                              n => n_tym,
                              wyj => y
                              );

przejscie:process (CLK, y_p, n_tym)
begin
     
     if (CLK'Event and CLK = '1') then
            n_tym <= y_p;
     end if;
     
end process przejscie;


end architecture Neuron_Arch;
