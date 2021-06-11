----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2021 01:33:11
-- Design Name: 
-- Module Name: MUX_STR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_STR is
    Port ( X : in STD_LOGIC_VECTOR (3 downto 0);
           A : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC);
end MUX_STR;

architecture Behavioral of MUX_STR is

begin
Z <= X(0) when A ="00" else
     X(1) when A ="01" else
     X(2) when A ="10" else
     X(3) when A ="11" else
     '-';

end Behavioral;
