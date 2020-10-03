library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decrement_8bits is 
   port(    
        input1  : in std_logic_vector(7 downto 0);
        output1 : out std_logic_vector(7 downto 0));
end decrement_8bits;
 
architecture Behavioral of decrement_8bits is
   
begin

   output1   <= input1 - 1;
   
end Behavioral;