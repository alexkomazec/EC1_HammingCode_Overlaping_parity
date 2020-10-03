library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EC1_tb is
end;

architecture bench of EC1_tb is

COMPONENT EC1
PORT (
        Clock                               :   in std_logic;
        Reset                               :   in std_logic;
        Input_A                             :   in std_logic_vector(7 downto 0);
        IR_opcode                           :   out std_logic_vector(2 downto 0);
        Output                              :   out std_logic_vector(7 downto 0);
        Aneq0                               :   out std_logic;
        Halt                                :   out std_logic;
        Q_state                             :   out std_logic_vector(2 downto 0);
        PC_MUX_P                            :   out std_logic_vector(3 downto 0);
        IR_ROM_P                            :   out std_logic_vector(7 downto 0);
        RAM_Data                            :   in  std_logic_vector(7 downto 0);
        RAM_Error_code                      :   in  std_logic_vector(6 downto 0);
        RAM_Sel                             :   in  std_logic;
        RAM_Reset_Address                   :   in  std_logic_vector(3 downto 0);
        IRload,PCload,INmux,Aload,JNZmux    :   out std_logic
);
END COMPONENT;

signal Clock                                :   std_logic;
signal Reset                                :   std_logic;
signal Q_state                              :   std_logic_vector(2 downto 0);
signal IR_opcode                            :   std_logic_vector(2 downto 0);
signal Input_A                              :   std_logic_vector(7 downto 0);
signal Output                               :   std_logic_vector(7 downto 0);
signal Aneq0                                :   std_logic;
signal Halt                                 :   std_logic ;
signal IR_ROM_P                             :   std_logic_vector(7 downto 0);
signal IRload,PCload,INmux,Aload,JNZmux     :   std_logic;
signal PC_MUX_P                             :   std_logic_vector(3 downto 0);
signal RAM_Data                             :   std_logic_vector(7 downto 0);
signal RAM_Error_code                       :   std_logic_vector(6 downto 0);
signal RAM_Sel                              :   std_logic;
signal RAM_Reset_Address                    :   std_logic_vector(3 downto 0);

begin

uut: EC1 port map ( 
    Clock               =>  Clock,
    Reset               =>  Reset,
    Q_state             =>  Q_state,
    IR_opcode           =>  IR_opcode,
    Input_A             =>  Input_A,
    Output              =>  Output,
    Aneq0               =>  Aneq0,
    Halt                =>  Halt,
    IR_ROM_P            =>  IR_ROM_P,
    IRload              =>  IRload,
    PCload              =>  PCload,
    INmux               =>  INmux,
    Aload               =>  Aload,
    JNZmux              =>  JNZmux,
    RAM_Data            =>  RAM_Data,
    RAM_Error_code      =>  RAM_Error_code,
    RAM_Sel             =>  RAM_Sel,
    RAM_Reset_Address   =>  RAM_Reset_Address,
    PC_MUX_P            =>  PC_MUX_P );
--Bilo je potrebno povezati portove EC1 sa kreiranim signalima. Levo su portovi,a desno
--signali na koje dovodimo vrednosti i pratimo izlaz.

stimulus: process
begin
    Reset               <='1','0' after 3200 ns;

        RAM_Data            <="01100000","10000000" after 150 ns, "10100000" after 350 ns,"11000001" after 550 ns,"11111111" after 750 ns,"00000000" after 950 ns,"00000000" after 1150 ns,"00000000" after 1350 ns,"00000000" after 1550 ns,"00000000" after 1750 ns,"00000000" after 1950 ns,"00000000" after 2150 ns,"00000000" after 2350 ns,"00000000" after 2550 ns,"00000000" after 2750 ns,"00000000" after 2950 ns;
     -- RAM_Data            <="01100000","01100000" after 150 ns, "10100000" after 350 ns,"11000001" after 550 ns,"11111111" after 750 ns,"00000000" after 950 ns,"00000000" after 1150 ns,"00000000" after 1350 ns,"00000000" after 1550 ns,"00000000" after 1750 ns,"00000000" after 1950 ns,"00000000" after 2150 ns,"00000000" after 2350 ns,"00000000" after 2550 ns,"00000000" after 2750 ns,"00000000" after 2950 ns;
    
                      --<='1','0' after 10 ns,'1' after 12 us,'0' after 13 us;
    RAM_Reset_Address   <="0000","0001" after 150 ns, "0010" after 350 ns,"0011" after 550 ns,"0100" after 750 ns,"0101" after 950 ns,"0110" after 1150 ns,"0111" after 1350 ns,"1000" after 1550 ns,"1001" after 1750 ns,"1010" after 1950 ns,"1011" after 2150 ns,"1100" after 2350 ns,"1101" after 2550 ns,"1110" after 2750 ns,"1111" after 2950 ns;

    --Error code that is the same as desired input  
    --RAM_Error_code      <= "0110000","1000000" after 150 ns, "1010000" after 350 ns,"1100000" after 550 ns,"1111111" after 750 ns,"0000000" after 950 ns,"0000000" after 1150 ns,"0000000" after 1350 ns,"0000000" after 1550 ns,"0000000" after 1750 ns,"0000000" after 1950 ns,"0000000" after 2150 ns,"0000000" after 2350 ns,"0000000" after 2550 ns,"0000000" after 2750 ns,"0000000" after 2950 ns;
    
    --9 error codes are different from desired and others are the same
      RAM_Error_code      <= "0100000","0000000" after 150 ns, "1000000" after 350 ns,"1000000" after 550 ns,"0111111" after 750 ns,"1000000" after 950 ns,"0100000" after 1150 ns,"0010000" after 1350 ns,"0001000" after 1550 ns,"0000000" after 1750 ns,"0000000" after 1950 ns,"0000000" after 2150 ns,"0000000" after 2350 ns,"0000000" after 2550 ns,"0000000" after 2750 ns,"0000000" after 2950 ns;
    
    --RAM_Error_code      <= "0010000","0010000" after 150 ns, "1000000" after 350 ns,"1000000" after 550 ns,"0111111" after 750 ns,"1000000" after 950 ns,"0100000" after 1150 ns,"0010000" after 1350 ns,"0001000" after 1550 ns,"0000000" after 1750 ns,"0000000" after 1950 ns,"0000000" after 2150 ns,"0000000" after 2350 ns,"0000000" after 2550 ns,"0000000" after 2750 ns,"0000000" after 2950 ns;
    
    RAM_Sel             <= '1', '0' after 3000 ns;
    Input_A             <=x"03";
wait;
end process;

clk_gen: process
begin
    Clock <= '0', '1' after 100 ns;
    wait for 200 ns;
end process;
--clk_gen proces predstavlja proces koji generi?e takt signal sa periodom od 200 ns.

end;