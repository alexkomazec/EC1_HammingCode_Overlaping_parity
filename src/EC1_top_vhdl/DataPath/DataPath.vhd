library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity DataPath is

Port (
	Clock,Reset                     : in    std_logic;
	IRload,PCload,INmux,Aload,JNZmux: in    std_logic;
	Aneq0                           : out   std_logic;
    RAM_Data                        : in    std_logic_vector(7 downto 0);
    RAM_Error_code                  : in    std_logic_vector(6 downto 0);
    RAM_Sel                         : in    std_logic;
    RAM_Reset_Address               : in    std_logic_vector(3 downto 0);
	IRtoCU                          : out   std_logic_vector(2 downto 0);
	OUTPUT                          : out   std_logic_vector(7 downto 0);
	INPUT                           : in    std_logic_vector(7 downto 0);
	PC_MUX_P                        : out   std_logic_vector(3 downto 0);
	IR_ROM_P                        : out   std_logic_vector(7 downto 0) );
end DataPath;


architecture Behavioral of DataPath is

COMPONENT A_register PORT(
    Clear       : in std_logic;
	Load        : in std_logic;
	clk         : in std_logic;
	D           : in std_logic_vector(7 downto 0);
	A           : out std_logic_vector(7 downto 0) );
END COMPONENT;
--Definicija komponente za A registar

COMPONENT IR_register PORT(
    Clear       : in std_logic;
    Load        : in std_logic;
    clk         : in std_logic;
    D           : in std_logic_vector(7 downto 0);
    IR          : out std_logic_vector(7 downto 0) );
END COMPONENT;
--Definicija komponente za IR

COMPONENT PC_register PORT(
    Clear       : in std_logic;
    Load        : in std_logic;
    clk         : in std_logic;
    D           : in std_logic_vector(3 downto 0);
    PC          : out std_logic_vector(3 downto 0) );
END COMPONENT;
--Definicija komponente za PC

COMPONENT Increment_4bits PORT(
input1          : in std_logic_vector(3 downto 0);
output1         : out std_logic_vector(3 downto 0) );
END COMPONENT;

COMPONENT decrement_8bits PORT(
    input1      : in std_logic_vector(7 downto 0);
    output1     : out std_logic_vector(7 downto 0));
END COMPONENT;
--Definicija komponente za incrementer

COMPONENT Mux_2to1 PORT(
    x1          : in std_logic_vector(3 downto 0);
    x2          : in std_logic_vector(3 downto 0);
    sel         : in std_logic;
    y           : out std_logic_vector(3 downto 0));
END COMPONENT;
--Definicija komponente za Mux_to1 4 bit

COMPONENT Mux_2to1_8bits PORT(
    x1          : in std_logic_vector(7 downto 0);
    x2          : in std_logic_vector(7 downto 0);
    sel         : in std_logic;
    y           : out std_logic_vector(7 downto 0));
END COMPONENT;
--Definicija komponente za Mux_to1 8 bit
COMPONENT ORgate PORT(
    in1         : in std_logic_vector(7 downto 0);
    out1        : out std_logic ); END COMPONENT;
--Definicija komponente za ORgate

COMPONENT RAM16_L_8bits PORT(
    clk             : in    std_logic;
    Reset           : in    std_logic;
    Address         : in    std_logic_vector(3 downto 0);
    Reset_Address   : in    std_logic_vector(3 downto 0);
    Data            : in    std_logic_vector(7 downto 0);
    Error_code      : in    std_logic_vector(6 downto 0);
    Sel             : in    std_logic;
    Q               : out   std_logic_vector(7 downto 0) );
END COMPONENT;

signal A_MUX_S,A_OR_DEC_OUT_S,DEC_MUX_S : std_logic_vector(7 downto 0);
signal IR_75_S                          : std_logic_vector(7 downto 5);
signal IR_30_S                          : std_logic_vector(3 downto 0);
signal IR_ROM_S                         : std_logic_vector(7 downto 0);
signal PC_MUX_S,PC_INC_ADD_S            : std_logic_vector(3 downto 0);
signal INC_MUX_S                        : std_logic_vector(3 downto 0);
SIGNAL none                             : std_logic;
--Kreirali smo sve signale koje smo koristili za povezivanje izme?u komponenti sa slike 2

begin
A : A_register PORT MAP(
    Clear           =>Reset,
    Load            =>Aload,
    clk             =>Clock,
    D               =>A_MUX_S,
    A               =>A_OR_DEC_OUT_S);
--Povezivanje A sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

IR : IR_register PORT MAP(
    Clear           =>Reset,
    load            =>IRload,
    clk             =>Clock,
    D               =>IR_ROM_S,
    IR(7 downto 5)  =>IRtoCU,
    IR(4)           =>none,
    IR(3 downto 0)  =>IR_30_S);
--Povezivanje IR sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

PC : PC_register PORT MAP(
    Clear           =>Reset,
    Load            =>PCload,
    clk             =>Clock,
    D               =>PC_MUX_S,
    PC              =>PC_INC_ADD_S);
--Povezivanje PC sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

INC : Increment_4bits PORT MAP(
    input1          => PC_INC_ADD_S,
    output1         => INC_MUX_S);
--Povezivanje increment sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

MUX4bit : Mux_2to1 PORT MAP(
    x1              =>IR_30_S,
    x2              =>INC_MUX_S,
    sel             =>JNZmux,
    y               =>PC_MUX_S);
--Povezivanje Mux 4 bit sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

MUX8bit : Mux_2to1_8bits PORT MAP(
    x1              =>INPUT,
    x2              =>DEC_MUX_S,
    sel             =>INmux,
    y               =>A_MUX_S);
--Povezivanje Mux 8 bit sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

ORG : ORgate PORT MAP(
    in1             =>A_OR_DEC_OUT_S,
    out1            =>Aneq0 );
--Povezivanje ORgate sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

RAM : RAM16_L_8bits PORT MAP(
    clk             => Clock,
    Reset           => Reset,
    Address         => PC_INC_ADD_S,
    Data            => RAM_Data,
    Error_code      => RAM_Error_code,
    Reset_Address   => RAM_Reset_Address,
    Sel             => RAM_Sel,
    Q               => IR_ROM_S);

DEC : decrement_8bits PORT MAP(
    input1          =>A_OR_DEC_OUT_S,
    output1         =>DEC_MUX_S);
--Povezivanje ROM sa odre?enim signalima (Svaki od ovih signala je prikazan na slici 2

OUTPUT              <=A_OR_DEC_OUT_S;
IR_ROM_P            <=IR_ROM_S;
PC_MUX_P            <=PC_MUX_S;

end Behavioral;