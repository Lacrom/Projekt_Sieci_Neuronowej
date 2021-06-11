library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_signed.all;

library Neuron;
use Neuron.all;
library Funkcja_AKtywacji_1;
use Funkcja_AKtywacji_1.all;

entity Siec_Neuronowa_TBench is
        generic ( b: integer := 4
                );
end Siec_Neuronowa_TBench;

architecture Siec_Neuronowa_TBench_Arch of Siec_Neuronowa_TBench is

component Siec_Neuronowa is
        generic(
		          b: integer := 4
	           );
	port(
		CLK      : in  std_logic;	
		Reset    : in  std_logic;	
		wejscie1 : in  signed (b-1 downto 0);
		waga1     : in signed (b-1 downto 0);
		waga2     : in signed (b-1 downto 0);
		waga3    : in signed (b-1 downto 0);
		Start      : in std_logic;
		wyjscie  : out std_logic
        );
end component Siec_Neuronowa;

signal CLK : std_logic := '0';
signal Reset : std_logic := '0';
signal wejscie1 : signed (b-1 downto 0);
signal Waga1 : signed (b-1 downto 0);
signal Waga2 : signed (b-1 downto 0);
signal Waga3 : signed (b-1 downto 0);
signal Start : std_logic := '0';
signal wyjscie : std_logic;


-- definicja okresu zegara
constant CLK_period : time := 20 ns;

begin

uut: Siec_Neuronowa   GENERIC MAP (b => 4)
                      PORT MAP ( CLK => CLK,
                               Reset => Reset,
                               wejscie1 => wejscie1,
                               waga1 => waga1,
                               waga2 => waga2,
                               waga3 => waga3,
                               Start => Start,
                               wyjscie => Wyjscie
                                );
                                
-- definicja zegara
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
   
    -- proces symulacji
   stim_proc: process
   begin
        
        Reset <= '1'; wait for 3*CLK_period;
        Reset <= '0'; wait for 2*CLK_period;
        
        waga1 <= "0010"; 
        waga2 <= "0111";
        waga3 <= "1001";
        wait for 20ns;
        
        Start <= '1';
        wejscie1 <= "1010";
        wait for 2*CLK_period;
        Start <= '0';
        wait for CLK_period;
        Start <= '1';
        wait for 5*CLK_period;
        
        waga1 <= "1010"; 
        waga2 <= "1111";
        waga3 <= "1001";
        wait for 100ns;
        
        waga1 <= "1010";
        waga2 <= "1010";
        waga3 <= "1010";
        wait for 100ns;
        
   assert false severity failure;
   end process stim_proc;

end Siec_Neuronowa_TBench_Arch;
