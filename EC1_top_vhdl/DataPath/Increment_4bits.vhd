library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Increment_4bits is 
   port(    
        input1  : in std_logic_vector(3 downto 0);
        output1 : out std_logic_vector(3 downto 0));
end Increment_4bits;
 
architecture Behavioral of Increment_4bits is
   
begin
   
   output1   <= input1+ 1;
   
end Behavioral;