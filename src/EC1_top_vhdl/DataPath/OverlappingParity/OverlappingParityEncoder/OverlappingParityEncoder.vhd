library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity OverlappingParityEncoder is

Port (
	input                           :   in      std_logic_vector(7 downto 0);
    output                          :   out     std_logic_vector(13 downto 0));
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
    syndrome        :   out std_logic_vector(2 downto 0));
END COMPONENT;

COMPONENT BitCorrection PORT(
    input1          :   in  std_logic_vector(6 downto 0);
    input2          :   in  std_logic_vector(2 downto 0);
    output          :   out std_logic_vector(6 downto 0));
END COMPONENT;

COMPONENT CodeWordConcatenation PORT(
    input1          :   in  std_logic_vector(6 downto 0);
    input2          :   in  std_logic_vector(6 downto 0);
    output          :   out std_logic_vector(13 downto 0));
END COMPONENT;

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

ParityCalculation7to4 : ParityCalculation PORT MAP(
    input   =>  input(7 downto 4),
    output  =>  pc_pc_red74);

ParityCalculation7to4_redundant : ParityCalculation PORT MAP(
    input   =>  pc_pc_red74(6 downto 3),
    output  =>  pc_red74_syn74);

SyndromeCalculation7to4 : SyndromeCalculation PORT MAP(
    input1      =>  pc_red74_syn74,
    input2      =>  pc_pc_red74(2 downto 0),
    output      =>  syn74_bc74_o,
    syndrome    =>  syn74_bc74_s);
    
BitCorrection7to4 : BitCorrection PORT MAP(
    input1      =>  syn74_bc74_o,
    input2      =>  syn74_bc74_s,
    output      =>  bc74_cwc);
    
ParityCalculation3to0 : ParityCalculation PORT MAP(
    input   =>  input(3 downto 0),
    output  =>  pc_pc_red30);
     
ParityCalculation3to0_redundant : ParityCalculation PORT MAP(
    input   =>  pc_pc_red30(6 downto 3),
    output  =>  pc_red30_syn30);

SyndromeCalculation3to0 : SyndromeCalculation PORT MAP(
    input1      =>  pc_red30_syn30,
    input2      =>  pc_pc_red30(2 downto 0),
    output      =>  syn30_bc30_o,
    syndrome    =>  syn30_bc30_s); 
    
BitCorrection3to0 : BitCorrection PORT MAP(
    input1      =>  syn30_bc30_o,
    input2      =>  syn30_bc30_s,
    output      =>  bc30_cwc);    
    
CodeWordConcatenation7to0_13to0 : CodeWordConcatenation PORT MAP(
    input1      =>  bc30_cwc,
    input2      =>  bc74_cwc,
    output      =>  output);

end Behavioral;