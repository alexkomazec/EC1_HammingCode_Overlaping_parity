library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CodeWordConcatenation is
 port (
    input1          :   in  std_logic_vector(6 downto 0);
    input2          :   in  std_logic_vector(6 downto 0);
    output          :   out std_logic_vector(13 downto 0));
    
end entity CodeWordConcatenation;

architecture Behavioral of CodeWordConcatenation is
begin

output<=input2 & input1;

end architecture Behavioral;