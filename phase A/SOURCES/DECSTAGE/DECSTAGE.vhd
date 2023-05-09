
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--author--IOANNIDIS CHRISTOS 2018030006

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECODE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel  : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt  : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  RST:in  STD_LOGIC);
end DECODE;

architecture Behavioral of DECODE is
component RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  RST : in  STD_LOGIC);
end component;

component MUX_2_to_1_5_bits is
    Port ( input_0 : in  STD_LOGIC_VECTOR (4 downto 0);
           input_1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel : in  STD_LOGIC;
           MUX_Output : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

component MUX_RF_WrData is
    Port ( ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RD_WrData_sel : in  STD_LOGIC;
           WrData : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Instr_Separator is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           out_25_21 : out  STD_LOGIC_VECTOR (4 downto 0);
           out_15_11 : out  STD_LOGIC_VECTOR (4 downto 0);
           out_20_16 : out  STD_LOGIC_VECTOR (4 downto 0);
           out_15_0 : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component Immediate_Handler is
    Port ( immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal MUX_2_to_1_5_bits_out :STD_LOGIC_VECTOR (4 downto 0);
signal MUX_RF_WrData_out :STD_LOGIC_VECTOR (31 downto 0);
signal read_reg_1 :STD_LOGIC_VECTOR (4 downto 0);
signal read_reg_2 :STD_LOGIC_VECTOR (4 downto 0);
signal write_reg :STD_LOGIC_VECTOR (4 downto 0);
signal immediate:STD_LOGIC_VECTOR (15 downto 0);

begin
Register_File:RF
	PORT MAP(Ard1=>read_reg_1,Ard2=>MUX_2_to_1_5_bits_out,Awr=>write_reg
	,Dout1=>RF_A,Dout2=>RF_B,Din=>MUX_RF_WrData_out,WrEn=>RF_WrEn
	,CLK=>Clk,RST=>RST);
	
WrData_MUX:MUX_RF_WrData
	PORT MAP(ALU_out=>ALU_out,MEM_out=>MEM_out
	,RD_WrData_sel=>RF_WrData_sel,WrData=>MUX_RF_WrData_out);
	
Instr_MUX:MUX_2_to_1_5_bits
	PORT MAP(input_0=>read_reg_2,input_1=>write_reg,RF_B_sel=>RF_B_sel
	,MUX_Output=>MUX_2_to_1_5_bits_out);

Instruction_Separator:Instr_Separator
	PORT MAP(Instr=>Instr,out_25_21=>read_reg_1,out_15_11=>read_reg_2
	,out_20_16=>write_reg,out_15_0=>immediate);

Imm_Handler:Immediate_Handler
	PORT MAP(immediate=>immediate,ImmExt=>ImmExt,Immed=>Immed);
end Behavioral;

