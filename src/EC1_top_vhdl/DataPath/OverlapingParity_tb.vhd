library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity OverlapingParity_tb is
end;

architecture bench of OverlapingParity_tb is

COMPONENT OverlapingParity
PORT (
    input       :   in std_logic_vector(2 downto 0);
    output      :   out std_logic_vector(2 downto 0);
    Sel         :   in std_logic;
    code_error  :   in std_logic_vector(5 downto 0)
);
END COMPONENT;

signal    input       :   std_logic_vector(2 downto 0);
signal    output      :   std_logic_vector(2 downto 0);
signal    Sel         :   std_logic;
signal    code_error  :   std_logic_vector(5 downto 0);

begin

uut: OverlapingParity port map ( 
    input       =>  input,
    output      =>  output,
    Sel         =>  Sel,
    code_error  =>  code_error 
    );


stimulus: process
begin
   
    Sel         <='0'       ,'1'        after 2950 ns;
    input       <="001";
    code_error  <="000000"  ,"100000"   after 2950 ns;

wait;
end process;

--clk_gen: process
--begin
--    Clock <= '0', '1' after 100 ns;
--    wait for 200 ns;
--end process;
--clk_gen proces predstavlja proces koji generi?e takt signal sa periodom od 200 ns.

end;