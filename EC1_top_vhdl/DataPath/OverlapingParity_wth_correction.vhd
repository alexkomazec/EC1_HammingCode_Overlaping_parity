library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity OverlapingParity_wth_correction is

Port (
    input                           :   in  std_logic_vector(3 downto 0);
    Sel                             :   in  std_logic;
    code_error                      :   in std_logic_vector(6 downto 0);
    output                          :   out std_logic_vector(3 downto 0));
end OverlapingParity_wth_correction;


architecture Behavioral of OverlapingParity_wth_correction is

COMPONENT word_corrector PORT(
    check       :   in std_logic_vector(2 downto 0);
    code        :   in std_logic_vector(3 downto 0);
    output      :   out std_logic_vector(3 downto 0));
END COMPONENT;

COMPONENT OverlapingParity PORT(
    input       :   in std_logic_vector(3 downto 0);
    output      :   out std_logic_vector(3 downto 0);
    Sel         :   in std_logic;
    check_port  :   out std_logic_vector(2 downto 0);
    code_error  :   in std_logic_vector(6 downto 0));
END COMPONENT;

signal code                           : std_logic_vector(3 downto 0);
signal check                          : std_logic_vector(2 downto 0);

begin
wc : word_corrector PORT MAP(
    check           =>check,
    code            =>code,
    output          =>output
    );

op : OverlapingParity PORT MAP(
    input           =>input,
    output          =>code,
    check_port      =>check,
    Sel             =>Sel,    
    code_error      =>code_error);

end Behavioral;