library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BitCorrection is
 port (
    input1          :   in  std_logic_vector(6 downto 0);   -- code word
    input2          :   in  std_logic_vector(2 downto 0);   -- syndrome
    output          :   out std_logic_vector(6 downto 0));  -- corrected code word
end entity BitCorrection;

architecture Behavioral of BitCorrection is
signal output_s    :   std_logic_vector(6 downto 0);
begin

process(input2,input1) is
begin


     case input2 is
     
                when "011" =>
                    output_s      <=  input1(6)&input1(5)&input1(4)&(not(input1(3)))&input1(2)&input1(1)&input1(0);
                when "101" =>
                    output_s      <=  input1(6)&input1(5)&(not(input1(4)))&input1(3)&input1(2)&input1(1)&input1(0);
                when "110" =>
                    output_s      <=  input1(6)&(not(input1(5)))&input1(4)&input1(3)&input1(2)&input1(1)&input1(0);
                when "111" =>
                    output_s      <=  (not(input1(6)))&input1(5)&input1(4)&input1(3)&input1(2)&input1(1)&input1(0);                     
                when others =>
                    output_s      <=   input1;
                end case;
                
    end process;

output<=output_s;

end architecture Behavioral;
