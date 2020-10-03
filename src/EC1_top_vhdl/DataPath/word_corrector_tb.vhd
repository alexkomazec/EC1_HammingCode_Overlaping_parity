library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity word_corrector_tb is
end;

architecture bench of word_corrector_tb is

COMPONENT word_corrector
PORT (
    check       :   in std_logic_vector(2 downto 0);
    code        :   in std_logic_vector(2 downto 0);
    output      :   out std_logic_vector(2 downto 0));
END COMPONENT;

signal    check     :   std_logic_vector(2 downto 0);
signal    code      :   std_logic_vector(2 downto 0);
signal    output    :   std_logic_vector(2 downto 0);

begin

uut: word_corrector port map ( 
    check       =>  check,
    code        =>  code,
    output      =>  output
    );


stimulus: process
begin
   
   -- check       <="000","101" after 1000 ns, "110" after 2000 ns;--"001" after 1000 ns,"010" after 2000 ns,"011" after 3000 ns,"100" after 4000 ns,"101" after 5000 ns,"110" after 6000 ns,"111" after 7000 ns,"000" after 8000 ns ,"001" after 9000 ns,"010" after 10000 ns,"011" after 11000 ns,"100" after 12000 ns,"101" after 13000 ns,"110" after 14000 ns,"111" after 15000 ns;
    check       <="001" after 1000 ns,"010" after 2000 ns,"011" after 3000 ns,"100" after 4000 ns,"101" after 5000 ns,"110" after 6000 ns,"111" after 7000 ns,"000" after 8000 ns ,"001" after 9000 ns,"010" after 10000 ns,"011" after 11000 ns,"100" after 12000 ns,"101" after 13000 ns,"110" after 14000 ns,"111" after 15000 ns;
    code        <="111","000" after 7000 ns;

wait;
end process;

--clk_gen: process
--begin
--    Clock <= '0', '1' after 100 ns;
--    wait for 200 ns;
--end process;
--clk_gen proces predstavlja proces koji generi?e takt signal sa periodom od 200 ns.

end;