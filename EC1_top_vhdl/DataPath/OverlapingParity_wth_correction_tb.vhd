library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity OverlapingParity_wth_correction_tb is
end;

architecture bench of OverlapingParity_wth_correction_tb is

COMPONENT OverlapingParity_wth_correction
PORT (
    input                           :   in  std_logic_vector(3 downto 0);
    Sel                             :   in  std_logic;
    code_error                      :   in std_logic_vector(6 downto 0);
    output                          :   out std_logic_vector(3 downto 0));
END COMPONENT;

signal    input                     :    std_logic_vector(3 downto 0);
signal    Sel                       :    std_logic;
signal    code_error                :    std_logic_vector(6 downto 0);
signal    output                    :    std_logic_vector(3 downto 0);


begin

uut: OverlapingParity_wth_correction port map ( 
    input       =>  input,
    output      =>  output,
    Sel         =>  Sel,
    code_error  =>  code_error 
    );


stimulus: process
begin
   
    Sel         <='0'       ,'1'        after 1000 ns;
    input       <="1000"; --( a3 a2 a1 a0)
    
    -- for input 1000             ( a3 a2 a1 a0) all should work
    code_error  <="1000000", "000000"   after 2950 ns, "110000" after 3500 ns, "101000" after 4000 ns, "1001000" after 4500 ns;
  
    -- for input 0000             ( a3 a2 a1 a0) all should work
    --code_error  <="0000000", "100000"   after 2950 ns, "01000" after 3500 ns, "001000" after 4000 ns, "0001000" after 4500 ns;
    
    -- for input 0001             ( a3 a2 a1 a0) all should not work
    --code_error  <="1000000", "110000"   after 2950 ns, "1110000" after 3500 ns, "1111000" after 4000 ns, "0100000" after 4500 ns;  
wait;
end process;


end;