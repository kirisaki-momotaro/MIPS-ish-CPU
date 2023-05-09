
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--author--IOANNIDIS CHRISTOS 2018030006

entity DATAPATH_MC is
		Port ( 
		
		
				 Clk : in  STD_LOGIC;
				--alu
				ALU_Bin_sel : in  STD_LOGIC;
				--ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
	 
				 --rf
				 --Instr : in  STD_LOGIC_VECTOR (31 downto 0);--inside
				 RF_WrEn : in  STD_LOGIC;
				 --MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);--inside
				 RF_WrData_sel  : in  STD_LOGIC;	 
				 RF_B_sel : in  STD_LOGIC;
				 ImmExt  : in  STD_LOGIC_VECTOR (1 downto 0);
				 
				  --ALU_output : out  STD_LOGIC_VECTOR (31 downto 0);--inside
				  ALU_zero : out  STD_LOGIC;
				  RST:in  STD_LOGIC;
				
				--ifstage			
				PC_sel : in  STD_LOGIC;
				PC_LdEn : in  STD_LOGIC;
				
				
				
				--mem
				ByteOp : in  STD_LOGIC;			
				Mem_WrEn : in  STD_LOGIC;
				
				
				
				instr_type : in  STD_LOGIC_VECTOR (2 downto 0); 
				
				
				
				
				--				
				PC: out STD_LOGIC_VECTOR (31 downto 0);    --address of the next instruction --TO MEMORY				
				MEM_instruction: in STD_LOGIC_VECTOR (31 downto 0);-- next instruction --TO MEMORY
				
				--memstage signals
				MEM_write_data_address :out STD_LOGIC_VECTOR(10 downto 0);--data address to write to memory 
				MEM_write_enable_data :out STD_LOGIC_VECTOR(31 downto 0);--
				MEM_return_data : in STD_LOGIC_VECTOR(31 downto 0);--
				MEM_data_to_write : out STD_LOGIC_VECTOR(31 downto 0);--
				
				
				
				--MC
				instruction_register_write_enable:in STD_LOGIC;-----CONTROL SIGNAL
				instruction_register_out:out STD_LOGIC_VECTOR(31 downto 0)
				
				);
end DATAPATH_MC;

architecture Behavioral of DATAPATH_MC is


----------------------------------------------------------------------------------------------------------------------
component Cpu_Register is
	 Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
----------------------------------------------------------------------------------------------------------------------




component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;----------------
           PC_LdEn : in  STD_LOGIC;------------------
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end component;



component MEMSTAGE is
Port (     ByteOp : in  STD_LOGIC;-----------------
           Mem_WrEn : in  STD_LOGIC;-----------------------
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
			  
			  
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrEn : out  STD_LOGIC_VECTOR (31 downto 0);---------------------------------------------
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);	
			  
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALU_Cntl is
    Port ( func : in  STD_LOGIC_VECTOR (5 downto 0); 
				instr_type : in  STD_LOGIC_VECTOR (2 downto 0); 	 
           ALU_Operation : out  STD_LOGIC_VECTOR (3 downto 0));
end component;


component DECODE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);--
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel  : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
			  
           ImmExt  : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);--
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);--
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  RST:in  STD_LOGIC);--
end component;

component EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);--
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);--
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);--
			  
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);----
           ALU_zero : out  STD_LOGIC);
end component;







signal ALU_output_tmp:STD_LOGIC_VECTOR(31 downto 0);-- data from alu to write to a register
signal MEM_output_tmp:STD_LOGIC_VECTOR(31 downto 0);-- data from memory to write to a register--FROM MEMORY
signal Immed_output_tmp :STD_LOGIC_VECTOR(31 downto 0);--immed value to alu

signal RF_A_output_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal RF_B_output_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal instructions_tmp:STD_LOGIC_VECTOR(31 downto 0);

signal ALU_4_bit_operation_tmp:STD_LOGIC_VECTOR(3 downto 0);

--register signals


signal instruction_register_output:STD_LOGIC_VECTOR(31 downto 0);
signal memory_data_register_output:STD_LOGIC_VECTOR(31 downto 0);
signal register_A_output:STD_LOGIC_VECTOR(31 downto 0);
signal register_B_output:STD_LOGIC_VECTOR(31 downto 0);
signal register_ALU_output:STD_LOGIC_VECTOR(31 downto 0);

begin


instruction_register:Cpu_Register
	PORT MAP(CLK=>Clk,RST=>RST,WE=>instruction_register_write_enable
	,Datain=>MEM_instruction,Dataout=>instruction_register_output);
	
memory_data_register:Cpu_Register
	PORT MAP(CLK=>Clk,RST=>RST,WE=>'1'
	,Datain=>MEM_return_data,Dataout=>memory_data_register_output);	
	
register_A:Cpu_Register
	PORT MAP(CLK=>Clk,RST=>RST,WE=>'1'
	,Datain=>RF_A_output_tmp,Dataout=>register_A_output);	

register_B:Cpu_Register
	PORT MAP(CLK=>Clk,RST=>RST,WE=>'1'
	,Datain=>RF_B_output_tmp,Dataout=>register_B_output);	
	
ALU_output_register:Cpu_Register
	PORT MAP(CLK=>Clk,RST=>RST,WE=>'1'
	,Datain=>ALU_output_tmp,Dataout=>register_ALU_output);	


decode_inst:DECODE
	PORT MAP(Instr=>instruction_register_output,
	RF_WrEn=>RF_WrEn,
	ALU_out=>register_ALU_output,
	MEM_out=>MEM_output_tmp
	,RF_WrData_sel=>RF_WrData_sel,
	RF_B_sel=>RF_B_sel,
	ImmExt=>ImmExt,
	Clk=>Clk
	,Immed=>Immed_output_tmp,
	RF_A=>RF_A_output_tmp,
	RF_B=>RF_B_output_tmp,
	RST=>RST);


exstage_inst:EXSTAGE
	PORT MAP(RF_A=>register_A_output,
	RF_B=>register_B_output,
	Immed=>Immed_output_tmp
	,ALU_Bin_sel=>ALU_Bin_sel,
	ALU_func=>ALU_4_bit_operation_tmp,----------------------------------
	ALU_out=>ALU_output_tmp
	,ALU_zero=>ALU_zero);
	
	





memstage_inst:MEMSTAGE
	PORT MAP(ByteOp=>ByteOp,Mem_WrEn=>Mem_WrEn
	,ALU_MEM_Addr=>register_ALU_output-----------------------------------------------SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
	,MEM_DataIn=>RF_B_output_tmp--rfa for addres rfb for data
	
	,MEM_DataOut=>MEM_output_tmp
	,MM_Addr=>MEM_write_data_address
	,MM_WrEn=>MEM_write_enable_data
	,MM_WrData=>MEM_data_to_write		
	,MM_RdData=>memory_data_register_output);

alu_cntl_inst:ALU_Cntl
	PORT MAP(func=>instruction_register_output(5 downto 0),instr_type=>instr_type,ALU_Operation=>ALU_4_bit_operation_tmp);


ifstage_inst:IFSTAGE
	PORT MAP(PC_Immed=>Immed_output_tmp
	,PC_sel=>PC_sel,PC_LdEn=>PC_LdEn
	,Reset=>RST
	,Clk=>Clk
	,PC=>PC);
	
process(instruction_register_output) is
begin
instruction_register_out<=instruction_register_output;
end process;
	
end Behavioral;
