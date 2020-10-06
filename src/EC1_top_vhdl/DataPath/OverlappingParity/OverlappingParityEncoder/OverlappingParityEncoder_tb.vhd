library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity OverlappingParityEncoder_tb is
end;

architecture bench of OverlappingParityEncoder_tb is

COMPONENT OverlappingParityEncoder
PORT (
    input                           :   in      std_logic_vector(7 downto 0);
    output                          :   out     std_logic_vector(13 downto 0)
);
END COMPONENT;

signal input    :   std_logic_vector(7 downto 0);
signal output   :   std_logic_vector(13 downto 0);


begin

uut: OverlappingParityEncoder port map ( 
    input   =>  input,
    output  =>  output);

stimulus: process
begin
    
    input   <= "11111111"; --'0' after 3000 ns;

wait;
end process;

end;