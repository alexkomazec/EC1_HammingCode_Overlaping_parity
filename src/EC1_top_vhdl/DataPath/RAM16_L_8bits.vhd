library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RAM16_L_8bits is
 port (
    clk             :   in  std_logic;
    Reset           :   in  std_logic;
    Address         :   in  std_logic_vector(3 downto 0);
    Reset_Address   :   in  std_logic_vector(3 downto 0);
    Data            :   in  std_logic_vector(7 downto 0);
    Error_code      :   in  std_logic_vector(6 downto 0);
    Sel             :   in  std_logic;
    Q               :   out std_logic_vector(7 downto 0) );

end entity RAM16_L_8bits;

architecture Behavioral of RAM16_L_8bits is
 
COMPONENT OverlapingParity_wth_correction
PORT (
    input                           :   in  std_logic_vector(3 downto 0);
    Sel                             :   in  std_logic;
    code_error                      :   in std_logic_vector(6 downto 0);
    output                          :   out std_logic_vector(3 downto 0));
END COMPONENT;

 type ram_type_t is array (0 to 15)
 of std_logic_vector(7 downto 0);
 signal ram_s: ram_type_t;
 signal RAM_bits                    :   std_logic_vector(3 downto 0);
 signal check_sum_dp_begin          :   std_logic_vector(4 downto 0);
 signal check_sum_dp_end            :   std_logic_vector(4 downto 0);
 signal check_sum_dp_error          :   std_logic;
begin

op: OverlapingParity_wth_correction port map ( 
    input =>  Data(7 downto 4),
    output      =>  RAM_bits,
    Sel         =>  Sel,
    code_error  =>  Error_code 
    );
 

 write_ram: process (clk) is
 begin
     if(Reset = '1') then
        ram_s(conv_integer(Reset_Address)) <= RAM_bits & Data(3 downto 0);
     elsif (clk'event and clk = '1') then
        Q <= ram_s(conv_integer(Address));
     end if;
 end process;
 
 
end architecture Behavioral;