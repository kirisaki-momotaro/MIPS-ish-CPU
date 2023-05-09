
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

entity DATAPATH is
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
				MEM_data_to_write : out STD_LOGIC_VECTOR(31 downto 0)--
				
				);
end DATAPATH;

architecture Behavioral of DATAPATH is








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



begin
decode_inst:DECODE
	PORT MAP(Instr=>MEM_instruction,
	RF_WrEn=>RF_WrEn,
	ALU_out=>ALU_output_tmp,
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
	PORT MAP(RF_A=>RF_A_output_tmp,
	RF_B=>RF_B_output_tmp,
	Immed=>Immed_output_tmp
	,ALU_Bin_sel=>ALU_Bin_sel,
	ALU_func=>ALU_4_bit_operation_tmp,----------------------------------
	ALU_out=>ALU_output_tmp
	,ALU_zero=>ALU_zero);
	
	





memstage_inst:MEMSTAGE
	PORT MAP(ByteOp=>ByteOp,Mem_WrEn=>Mem_WrEn
	,ALU_MEM_Addr=>ALU_output_tmp-----------------------------------------------SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
	,MEM_DataIn=>RF_B_output_tmp--rfa for addres rfb for data
	
	,MEM_DataOut=>MEM_output_tmp
	,MM_Addr=>MEM_write_data_address
	,MM_WrEn=>MEM_write_enable_data
	,MM_WrData=>MEM_data_to_write		
	,MM_RdData=>MEM_return_data);

alu_cntl_inst:ALU_Cntl
	PORT MAP(func=>MEM_instruction(5 downto 0),instr_type=>instr_type,ALU_Operation=>ALU_4_bit_operation_tmp);


ifstage_inst:IFSTAGE
	PORT MAP(PC_Immed=>Immed_output_tmp
	,PC_sel=>PC_sel,PC_LdEn=>PC_LdEn
	,Reset=>RST
	,Clk=>Clk
	,PC=>PC);
	
	
	
end Behavioral;

