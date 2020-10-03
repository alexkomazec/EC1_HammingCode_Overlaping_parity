library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity word_corrector is
 port (
    check       :   in std_logic_vector(2 downto 0);
    code        :   in std_logic_vector(3 downto 0);
    output      :   out std_logic_vector(3 downto 0));
    
end entity word_corrector;

architecture Behavioral of word_corrector is
signal output_s    :   std_logic_vector(3 downto 0);
begin

process(check,code) is
begin


     case check is
     
                when "011" =>
                    output_s      <=  code(3)&code(2)&code(1)&(not(code(0)));
                when "101" =>
                    output_s      <=  code(3)&code(2)&(not(code(1)))&code(0);
                when "110" =>
                    output_s      <=  code(3)&(not(code(2)))&code(1)&code(0);
                when "111" =>
                    output_s      <=  (not(code(3)))&code(2)&code(1)&code(0);                     
                when others =>
                    output_s      <=   code;
                end case;
                
end process;

output<=output_s;

end architecture Behavioral;