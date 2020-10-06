library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ParityCalculation is
 port (
    input       :   in std_logic_vector(3 downto 0);
    output      :   out std_logic_vector(6 downto 0));
end entity ParityCalculation;

architecture Behavioral of ParityCalculation is

begin

output    <=  input(3)&input(2)&input(1)&input(0)&(input(1) xor input(2) xor input(3) )&( input(0) xor input(2) xor input(3) )&(input(0) xor input(1) xor input(3) );

end architecture Behavioral;