library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SyndromeCalculation is
 port (
    input1          :   in  std_logic_vector(6 downto 0);
    input2          :   in  std_logic_vector(2 downto 0);
    output          :   out std_logic_vector(6 downto 0);
    syndrome        :   out std_logic_vector(2 downto 0));
end entity SyndromeCalculation;

architecture Behavioral of SyndromeCalculation is

begin

syndrome    <=  (input1(2)xor input2(2))&(input1(1)xor input2(1))&(input1(0)xor input2(0));
output      <=  input1;

end architecture Behavioral;