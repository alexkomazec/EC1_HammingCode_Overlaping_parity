library ieee;
use ieee.std_logic_1164.all;

entity A_register is
port (
    clk     : in std_logic;
    Clear   : in std_logic;
    Load    : in std_logic;
    D       : in std_logic_vector(7 downto 0);
    A       : out std_logic_vector(7 downto 0));
end entity A_register;


architecture Behavioral of A_register is
begin

A_register: process (clk) is
    begin
    if(Clear ='1') then 
        A <= "00000000";
    elsif (clk'event and clk = '1') then
        if (Load = '1') then
            A <= D;
        end if;
    end if;
end process;

end architecture Behavioral;