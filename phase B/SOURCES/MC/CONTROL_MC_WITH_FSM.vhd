
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CONTROL_MC_FINAL is
port(
				CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
				
				Instr : in  STD_LOGIC_VECTOR (31 downto 0);
				
				
				ALU_Bin_sel : out  STD_LOGIC;--0 RFB,1 IMMED
				instr_type : out STD_LOGIC_VECTOR (2 downto 0); 
				RF_WrEn : out  STD_LOGIC;--write on register
				RF_WrData_sel  : out  STD_LOGIC; --0 write result from,1 write result from memory
				RF_B_sel : out  STD_LOGIC;--0 RB<- rd,1 RB<-rs				
				ImmExt  : out  STD_LOGIC_VECTOR (1 downto 0); --00 sign extend,					
				PC_sel : out  STD_LOGIC;--0 -> pc+4 1-> immediate
				PC_LdEn : out STD_LOGIC;--write in pc register
				ByteOp : out  STD_LOGIC;							
				Mem_WrEn : out  STD_LOGIC;
				
				Reset : out  STD_LOGIC;
				
				--MC
				instruction_register_write_enable:out STD_LOGIC
				
	 
	 );


end CONTROL_MC_FINAL;

architecture Behavioral of CONTROL_MC_FINAL is
component CONTROL_MC is
    Port ( 
				
				
	 Instr : in  STD_LOGIC_VECTOR (31 downto 0);
	 
				--MC
				State : in  STD_LOGIC_VECTOR (3 downto 0);
			   Next_State : out  STD_LOGIC_VECTOR (3 downto 0);
				--MC
				
				
				ALU_Bin_sel : out  STD_LOGIC;--0 RFB,1 IMMED
				instr_type : out STD_LOGIC_VECTOR (2 downto 0); 
				RF_WrEn : out  STD_LOGIC;--write on register
				RF_WrData_sel  : out  STD_LOGIC; --0 write result from,1 write result from memory
				RF_B_sel : out  STD_LOGIC;--0 RB<- rd,1 RB<-rs				
				ImmExt  : out  STD_LOGIC_VECTOR (1 downto 0); --00 sign extend,					
				PC_sel : out  STD_LOGIC;--0 -> pc+4 1-> immediate
				PC_LdEn : out STD_LOGIC;--write in pc register
				ByteOp : out  STD_LOGIC;							
				Mem_WrEn : out  STD_LOGIC;
				
				Reset : out  STD_LOGIC;
				
				--MC
				instruction_register_write_enable:out STD_LOGIC
				
	 
	 );
end component;


component register_4_bit is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (3 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal State_tmp:STD_LOGIC_VECTOR (3 downto 0); 
signal Next_State_tmp:STD_LOGIC_VECTOR (3 downto 0); 


begin

cntrl_mc:CONTROL_MC
PORT MAP(Instr=>Instr,State=>State_tmp,
Next_State=>Next_State_tmp,
ALU_Bin_sel=>ALU_Bin_sel,instr_type=>instr_type,RF_WrEn=>RF_WrEn,RF_WrData_sel=>RF_WrData_sel,RF_B_sel=>RF_B_sel,
ImmExt=>ImmExt,PC_sel=>PC_sel,PC_LdEn=>PC_LdEn,ByteOp=>ByteOp,Mem_WrEn=>Mem_WrEn
,Reset=>Reset,instruction_register_write_enable=>instruction_register_write_enable);


reg:register_4_bit
PORT MAP(CLK=>CLK,RST=>RST,WE=>'1',Datain=>Next_State_tmp,
Dataout=>State_tmp);
end Behavioral;

