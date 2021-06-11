
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

library Funk_Aktywac;
use Funk_Aktywac.all;


entity Neuron_Sim is
        generic (   r : integer :=3;
                    b: integer := 4
                );
end entity Neuron_Sim;

architecture Siec_Neuronowa_TBench_Arch of Neuron_Sim is

component Neuron is
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
end component Neuron;

signal CLK : std_logic := '0';
signal x1 : signed (b-1 downto 0);
signal x2 : signed (b-1 downto 0);
signal x3 : signed (b-1 downto 0);

signal w  : signed (b-1 downto 0);
signal y  : signed (2*b-1 downto 0);

--signal n   : signed (b-1 downto 0);
--signal wyj : signed (b-1 downto 0);

-- definicja okresu zegara
constant CLK_period : time := 20 ns;

begin

uut: Neuron   GENERIC MAP (r => 3, b => 4)
                      PORT MAP ( CLK => CLK,
                               x1 => x1,
                               x2 => x2,
                               x3 => x3,
                               w => w,
                               y => y
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
            w <= "0000";
            x1 <= "0011";
            x2 <= "0100";
            x3 <= "0101";
            wait for 10ns;
            
            w <= "0111"; wait for 20ns;
            w <= "1000"; wait for 20ns;
            w <= "1001"; wait for 20ns;
            
            x1 <= "0110";
            x2 <= "0010";
            x3 <= "0010";
            
            w <= "0111"; wait for 20ns;
            w <= "1000"; wait for 20ns;
            w <= "1001"; wait for 20ns;
            
            
            x1 <= "0011";
            x2 <= "0100";
            x3 <= "0101";
            
            w <= "0111"; wait for 20ns;
            w <= "1000"; wait for 20ns;
            w <= "1001"; wait for 20ns;
            
   assert false severity failure;
   end process stim_proc;

end Siec_Neuronowa_TBench_Arch;
