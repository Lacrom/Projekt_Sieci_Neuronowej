
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_signed.all;
--use IEEE.numeric_std.all;

library Neuron;
use Neuron.all;

library MUX;
use MUX.all;

entity Siec_Neuronowa is
    generic(
		      b: integer := 4
	        );
	port(
		CLK      : in  std_logic;	
		Reset    : in  std_logic;	
		wejscie1  : in  signed (b-1 downto 0);
		waga1 : in signed (b-1 downto 0) := "0000";
		waga2 : in signed (b-1 downto 0) := "0000";
		waga3 : in signed (b-1 downto 0) := "0000";
		Start      : in std_logic:= '0';
		wyjscie  : out std_logic
	);
end entity Siec_Neuronowa;

architecture Siec_Neuronowa_Arch of Siec_Neuronowa is


signal wykonano : std_logic :='0';
signal V : std_logic_vector (2 downto 0);
signal Wyjscie_sig : std_logic;

        ---------------------------------
        -- Neurony wejsciowy -- sygnaly--
                -- Neuron 1 --
--  Pierwsze wejscie neuronu i jego sygna造
signal neuron_1 : signed (b-1 downto 0):="0000";
signal w_1      : signed (b-1 downto 0):="0000";
signal y_1      : signed (2*b-1 downto 0);

--  drugi wejscie neuronu i jego sygna造
signal neuron_2 : signed (b-1 downto 0):="0000";

--  trzecie wejscie neuronu i jego sygna造
signal neuron_3 : signed (b-1 downto 0):="0000";

--  czwarte wejscie neuronu i jego sygna造
signal neuron_4 : signed (b-1 downto 0):="0000";
signal w_2      : signed (b-1 downto 0):="0000";
signal y_2     : signed (2*b-1 downto 0);
                -- Neuron 2 --
--  piate wejscie neuronu i jego sygna造
signal neuron_5 : signed (b-1 downto 0):="0000";


--  szoste wejscie neuronu i jego sygna造
signal neuron_6 : signed (b-1 downto 0):="0000";

--  siodme wejscie neuronu i jego sygna造
signal neuron_7 : signed (b-1 downto 0):="0000";
signal w_3      : signed (b-1 downto 0):="0000";
signal y_3     : signed (2*b-1 downto 0);
                -- Neuron 2 --
--  osme wejscie neuronu i jego sygna造
signal neuron_8 : signed (b-1 downto 0):="0000";


--  dziewiate wejscie neuronu i jego sygna造
signal neuron_9 : signed (b-1 downto 0):="0000";

       

        ---------------------------------
        -- Neurony wyjsciowe -- sygnaly--

--signal neuron_wy_1 : signed (b-1 downto 0);
--signal neuron_wy_2 : signed (b-1 downto 0);
--signal neuron_wy_3 : signed (b-1 downto 0);

--signal w_wy_1      : signed (b-1 downto 0);
--signal y_wy_1      : signed (2*b-1 downto 0);


-- Komponent Neuron
Component Neuron is 
     generic( r : integer :=3;
              b : integer :=4
             );
   
   Port (x1         : in signed (b-1 downto 0);
         x2         : in signed (b-1 downto 0);
         x3         : in signed (b-1 downto 0);
         w          : in signed (b-1 downto 0);
         CLK        : in std_logic;
         y          : out signed (2*b-1 downto 0)
         );  
             
end component Neuron;

component MUX is
        Port (
           CLK   : in STD_LOGIC;
           RESET : in STD_LOGIC;
           V     : in STD_LOGIC_VECTOR (2 downto 0); 
           wyj   : out STD_LOGIC
         );
end component MUX;


type Stany is (Bezczynnosc, WarstwaWej, Koniec );        -- typ wyliczeniowy
signal stan, stan_nast : Stany;

begin
        ----------------------
        -- Neurony wywo豉ne --
        ----------------------
        -- Warstwa wejsciowa--
NEU1: Neuron generic map (r => 3, b => 4)
                     port map ( CLK => CLK,   
                                x1  => neuron_1,    
                                x2  => neuron_2,      
                                x3  => neuron_3,
                                w   => waga1,
                                y   => y_1
                                );
NEU2: Neuron generic map (r => 3, b => 4)
                     port map ( CLK => CLK,   
                                x1  => neuron_5,    
                                x2  => neuron_6,      
                                x3  => neuron_7,
                                w   => waga2,
                                y   => y_2
                                );
                                                            
NEU3: Neuron generic map (r => 3, b => 4)
                     port map ( CLK => CLK,   
                                x1  => neuron_7,    
                                x2  => neuron_8,      
                                x3  => neuron_9,
                                w   => waga3,
                                y   => y_3
                                );
                                
MUX1: MUX port map (
                     CLK => CLK,
                     RESET => Reset,
                     V => V,
                     wyj => Wyjscie_sig
                    );                        

                                
--NEU4: Neuron generic map (r => 3, b => 4)
  --                   port map ( CLK => CLK,   
    --                            x1  => neuron_wy_1,    
      --                          x2  => neuron_wy_2,      
        --                        x3  => neuron_wy_3,
          --                      w   => w_wy_1,
            --                    y   => y_wy_1
              --                  );
              



reg:process(CLK, RESET)              
   begin
      if (RESET='1') then
	      stan <= Bezczynnosc;
	   elsif (CLK'Event and CLK = '1') then
	      stan <= stan_nast;
	   end if;
   end process reg;
  
 komb:process(wejscie1, stan, Start, wykonano)            
   --variable wykonano : integer; 
   begin
       
       stan_nast <= stan;
		 case stan is 
		     when Bezczynnosc =>                               
			     if (Start ='1') then         
				     stan_nast <= WarstwaWej; 
				     wykonano <= '0';                     
				  elsif (start ='0') then 				  
				     stan_nast <= Bezczynnosc;  
				  end if;
				  
			  when WarstwaWej =>                                 
			     if (Start ='1') then
				     stan_nast <= Koniec;
				     wykonano <= '1';
				 elsif (Start ='1') then
				     stan_nast <= Bezczynnosc;
				 end if;
				 
				 
			  when Koniec =>                                   
			     if (wykonano = '1') then
				     stan_nast <= Bezczynnosc;
				 elsif (wykonano = '0') then
				     stan_nast <= WarstwaWej;
				 end if; 
         end case;
   end process komb;
 
proces_pracy: process (wejscie1, stan, wykonano, y_1, y_2, y_3, neuron_1, neuron_2, neuron_3, neuron_4, neuron_5, neuron_6, neuron_7, neuron_8, neuron_9)
begin

            if (stan = WarstwaWej) then
            
                            -- Neuron 1 --
                     neuron_1 <= wejscie1;

                     neuron_2 <= wejscie1;

                     neuron_3 <= wejscie1;
                            -- Neuron 2
                     neuron_4 <= wejscie1;
                            
                     neuron_5 <= wejscie1;

                     neuron_6 <= wejscie1;
                     
                     neuron_7 <= wejscie1;
                     
                     neuron_8 <= wejscie1;
                     
                     neuron_9 <= wejscie1;             
      
                     
                     
            elsif (stan = Koniec) then
            
                     
                     if (y_1(7) = '0' and y_2(7) = '0' and y_3(7) = '0') then
                            V <= "111";   
                     elsif (y_1(7) = '1' and y_2(7) = '1' and y_3(7) = '1') then
                            V <= "000";
                     else 
                            V <= "100";
         
                     end if;
              else 
                     neuron_1 <= "0000";

                     neuron_2 <= "0000";

                     neuron_3 <= "0000";
                            -- Neuron 2
                     neuron_4 <= "0000";
                            
                     neuron_5 <= "0000";

                     neuron_6 <= "0000";
                     
                     neuron_7 <= "0000";
                     
                     neuron_8 <= "0000";
                     
                     neuron_9 <= "0000";
                     
                     
            
            end if;
   
    
end process proces_pracy; 

wyjscie <= '1' when Wyjscie_sig ='1' else
           '0' when Wyjscie_sig ='0' else
           '-';


end architecture Siec_Neuronowa_Arch;
