library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity OverlapingParity is
 port (
    input       :   in std_logic_vector(3 downto 0);
    output      :   out std_logic_vector(3 downto 0);
    Sel         :   in std_logic;
    check_port  :   out std_logic_vector(2 downto 0);
    code_error  :   in std_logic_vector(6 downto 0));
    
end entity OverlapingParity;

architecture Behavioral of OverlapingParity is

signal temp,temp_chk_err                :   std_logic_vector(6 downto 0);
signal mux_out                          :   std_logic_vector(6 downto 0);

begin

temp    <=  input(3)&input(2)&input(1)&input(0)&( input(1) xor input(2) xor input(3) )&( input(0) xor input(2) xor input(3) )&(input(0) xor input(1) xor input(3) );
mux_out <=  code_error when (Sel = '1') else temp;
temp_chk_err <= mux_out(6)&mux_out(5)&mux_out(4)&mux_out(3)&(mux_out(4) xor mux_out(5)xor mux_out(6) )&(mux_out(3) xor mux_out(5)xor mux_out(6))&(mux_out(3) xor mux_out(4)xor mux_out(6));
--                input(3)   input(2)   input(1)   input(0)        
process(temp_chk_err,temp) is
begin

    check_port <= temp_chk_err(2 downto 0) xor temp(2 downto 0);
end process;

output       <= temp_chk_err(6 downto 3); 

end architecture Behavioral;