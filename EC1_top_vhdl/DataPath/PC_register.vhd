library ieee;
use ieee.std_logic_1164.all;

entity PC_register is
port (
    clk     : in std_logic;
    Clear   : in std_logic;
    Load    : in std_logic;
    D       : in std_logic_vector(3 downto 0);
    PC      : out std_logic_vector(3 downto 0));
end entity PC_register;


architecture Behavioral of PC_register is
begin

PC_register: process (clk) is
    begin
    if(Clear ='1') then 
        PC <= "0000";
    elsif (clk'event and clk = '1') then
        if (Load = '1') then
            PC <= D;
        end if;
    end if;
end process;

end architecture Behavioral;