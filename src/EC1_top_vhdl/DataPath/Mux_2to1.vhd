library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2to1 is
    Port ( sel : in  STD_LOGIC;
           x1   : in  STD_LOGIC_VECTOR (3 downto 0);
           x2   : in  STD_LOGIC_VECTOR (3 downto 0);
           y    : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_2to1;

architecture Behavioral of Mux_2to1 is
begin

    y <= x1 when (sel = '1') else x2;
    
end Behavioral;