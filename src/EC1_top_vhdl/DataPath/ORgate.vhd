library IEEE;
use IEEE.std_logic_1164.all;

entity ORgate is

    port(in1 : in std_logic_vector(7 downto 0);
         out1 : out std_logic);

end ORgate;


architecture Behavioral of ORgate is

 begin
    
    out1 <= in1(7) or in1(6) or in1(5) or in1(4) or in1(3) or in1(2) or in1(1) or in1(0);

end Behavioral;