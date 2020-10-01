library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EC1 is
Port (
    Clock                                   :   in  std_logic;
    Reset                                   :   in  std_logic;
    Q_state                                 :   out std_logic_vector(2 downto 0);
    IR_opcode                               :   out std_logic_vector(2 downto 0);
    Input_A                                 :   in  std_logic_vector(7 downto 0);
    Output                                  :   out std_logic_vector(7 downto 0);
    Aneq0                                   :   out std_logic;
    Halt                                    :   out std_logic;
    IRload,PCload,INmux,Aload,JNZmux        :   out std_logic;
    PC_MUX_P                                :   out std_logic_vector(3 downto 0);
    RAM_Data                                :   in  std_logic_vector(7 downto 0);
    RAM_Error_code                          :   in  std_logic_vector(6 downto 0);
    RAM_Sel                                 :   in  std_logic;
    RAM_Reset_Address                       :   in  std_logic_vector(3 downto 0);
    IR_ROM_P                                :   out std_logic_vector(7 downto 0)
);
end EC1;

architecture Behavioral of EC1 is

COMPONENT DataPath PORT(
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
END COMPONENT;

COMPONENT ControlUnit PORT(
    Clock,Reset                             : in std_logic;
    IRload,PCload,INmux,Aload,JNZmux,Halt   : out std_logic;
    Aneq0                                   : in std_logic;
    IR                                      : in std_logic_vector(7 downto 5);
    States                                  : out std_logic_vector(2 downto 0)
); END COMPONENT;

signal IRload_s,PCload_s,INmux_s,Aload_s,JNZmux_s,Aneq0_s: std_logic;
signal IR_20: std_logic_vector(2 downto 0);
signal IR_ROM_P_s: std_logic_vector(3 downto 0);
begin

    DP : DataPath PORT MAP(
        Clock               =>  Clock,
        Reset               =>  Reset,
        IRload              =>  IRload_s,
        PCload              =>  PCload_s,
        INmux               =>  INmux_s,
        Aload               =>  Aload_s,
        JNZmux              =>  JNZmux_s,
        Aneq0               =>  Aneq0_s,
        IRtoCU              =>  IR_20,
        OUTPUT              =>  Output,
        INPUT               =>  Input_A,
        RAM_Data            =>  RAM_Data,
        RAM_Error_code      =>  RAM_Error_code,
        RAM_Sel             =>  RAM_Sel,
        RAM_Reset_Address   =>  RAM_Reset_Address,
        PC_MUX_P            =>  PC_MUX_P,
        IR_ROM_P            =>  IR_ROM_P);
        
    CU : ControlUnit PORT MAP(
        Clock       =>Clock,
        Reset       =>Reset,
        IRload      =>IRload_s,
        PCload      =>PCload_s,
        INmux       =>INmux_s,
        Aload       =>Aload_s,
        JNZmux      =>JNZmux_s,
        Aneq0       =>Aneq0_s,
        Halt        =>Halt,
        States      =>Q_state,
        IR          =>IR_20
        );
        
    IR_opcode       <=IR_20;
    IRload          <=IRload_s;
    PCload          <=PCload_s;
    INmux           <=INmux_s;
    Aload           <=Aload_s;
    JNZmux          <=JNZmux_s;
    Aneq0           <=Aneq0_s;
    
end Behavioral;