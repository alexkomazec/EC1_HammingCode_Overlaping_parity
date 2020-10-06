entity library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity OverlappingParityDeecoder is

Port (
	input                           :   in      std_logic_vector(13 downto 0);
    output                          :   out     std_logic_vector(7 downto 0));
end OverlappingParityEncoder;


architecture Behavioral of OverlappingParityEncoder is

COMPONENT ParityCalculation PORT(
    input       :   in  std_logic_vector(3 downto 0);
    output      :   out std_logic_vector(6 downto 0));
END COMPONENT;

COMPONENT SyndromeCalculation PORT(
    input1          :   in  std_logic_vector(6 downto 0);
    input2          :   in  std_logic_vector(2 downto 0);
    output          :   out std_logic_vector(6 downto 0);
    syndrome        :   out std_logic_vector(6 downto 0));
END COMPONENT;

COMPONENT BitCorrection PORT(
    input1          :   in  std_logic_vector(6 downto 0);
    input2          :   in  std_logic_vector(2 downto 0);
    output          :   out std_logic_vector(6 downto 0));
END COMPONENT;

signal pc_syn13_7               :   std_logic_vector(2 downto 0);
signal pc_syn6_0                :   std_logic_vector(2 downto 0);
signal syn13to7_bc13to7_o       :   std_logic_vector(6 downto 0);
signal syn6to0_bc6to0_o         :   std_logic_vector(6 downto 0);
signal syn13to7_bc13to7_s       :   std_logic_vector(2 downto 0);
signal syn6to0_bc6to0_s         :   std_logic_vector(2 downto 0);
signal bc13to7_cc2              :   std_logic_vector(3 downto 0);
signal bc13to7_cc1              :   std_logic_vector(3 downto 0);


signal pc_pc_red74              :   std_logic_vector(6 downto 0);
signal pc_pc_red30              :   std_logic_vector(6 downto 0);
signal pc_red74_syn74           :   std_logic_vector(6 downto 0);
signal pc_red30_syn30           :   std_logic_vector(6 downto 0);
signal syn74_bc74_o             :   std_logic_vector(6 downto 0);
signal syn74_bc74_s             :   std_logic_vector(2 downto 0);
signal syn30_bc30_o             :   std_logic_vector(6 downto 0);
signal syn30_bc30_s             :   std_logic_vector(2 downto 0);
signal bc74_cwc                 :   std_logic_vector(6 downto 0);
signal bc30_cwc                 :   std_logic_vector(6 downto 0);

begin

ParityCalculation13_7 : ParityCalculation PORT MAP(
    input   =>  input(13 downto 10),
    output  =>  pc_syn13_7);

SyndromeCalculation13_7 : SyndromeCalculation PORT MAP(
    input1      =>  input(13 downto 7),
    input2      =>  pc_syn13_7,
    output      =>  syn13to7_bc13to7_o,
    syndrome    =>  syn13to7_bc13to7_s);

BitCorrection13_7 : BitCorrection PORT MAP(
    input1      =>  syn13to7_bc13to7_o,
    input2      =>  syn13to7_bc13to7_s,
    output      =>  bc13to7_cc2);

ParityCalculation6_0 : ParityCalculation PORT MAP(
    input   =>  input(6 downto 3),
    output  =>  pc_syn13_7);

SyndromeCalculation6_0 : SyndromeCalculation PORT MAP(
    input1      =>  input(6 downto 0),
    input2      =>  pc_syn6_0,
    output      =>  syn6to0_bc6to0_o,
    syndrome    =>  syn6to0_bc6to0_s);

BitCorrection6_0 : BitCorrection PORT MAP(
    input1      =>  syn6to0_bc6to0_o,
    input2      =>  syn6to0_bc6to0_s,
    output      =>  bc13to7_cc1);
    
output <=   bc13to7_cc2&bc13to7_cc1;

end Behavioral;