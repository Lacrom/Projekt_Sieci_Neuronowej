
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

package hardlims_funl is
function hardlims (signal n : signed) return
signed;
end hardlims_funl;

package body hardlims_funl is
function hardlims (signal n : signed) return signed
is variable y: signed (7 downto 0);
variable temp: integer range -8 to 7;
begin 
temp := conv_integer (n);
        if (temp >= 1) then
               temp := 1;
        else  
               temp := -1;
        end if;
y := conv_signed (temp, 8);
return y;
end hardlims;
end hardlims_funl;

