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

entity PROC_SC is
    Port ( Clk : in  STD_LOGIC;
	 RST: in  STD_LOGIC);
end PROC_SC;

architecture Behavioral of PROC_SC is




signal tmp_MEM_data_to_write: STD_LOGIC_VECTOR (31 downto 0); 

signal tmp_RF_B_sel :  STD_LOGIC;
signal tmp_RF_WrEn :   STD_LOGIC;
signal tmp_ImmExt  :   STD_LOGIC_VECTOR (1 downto 0);
signal tmp_RF_WrData_sel  :   STD_LOGIC;							
signal tmp_PC_sel :   STD_LOGIC;
signal tmp_PC_LdEn :   STD_LOGIC;
				--exstage
signal tmp_ALU_Bin_sel :   STD_LOGIC;
signal tmp_ALU_func :   STD_LOGIC_VECTOR (3 downto 0);
				--mem
signal tmp_ByteOp :   STD_LOGIC;			
signal tmp_Mem_WrEn :   STD_LOGIC;
signal tmp_Reset :   STD_LOGIC;
				
				
signal tmp_instr_type :   STD_LOGIC_VECTOR (2 downto 0); 
				
signal tmp_ALU_zero:   STD_LOGIC;
				
				
				
				
				
				
signal tmp_PC:  STD_LOGIC_VECTOR (31 downto 0);    --address of the next instruction --TO MEMORY				
signal tmp_MEM_instruction:  STD_LOGIC_VECTOR (31 downto 0);-- next instruction --TO MEMORY
				
				--memstage signals
signal tmp_MEM_write_data_address : STD_LOGIC_VECTOR(10 downto 0);--data address to write to memory 
signal tmp_MEM_write_enable_data  :STD_LOGIC_VECTOR(31 downto 0);--
signal tmp_MEM_return_data : STD_LOGIC_VECTOR(31 downto 0);--



component DATAPATH is
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
end component;


component CONTROL is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			   
				
				
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
				
				Reset : out  STD_LOGIC
				
	 
	 );
end component;

component RAM is
	port (
		clk : in std_logic;
		inst_addr : in std_logic_vector(10 downto 0);
		inst_dout : out std_logic_vector(31 downto 0);
		data_we : in std_logic;
		data_addr : in std_logic_vector(10 downto 0);
		data_din : in std_logic_vector(31 downto 0);
		data_dout : out std_logic_vector(31 downto 0);
		byte_operation : in std_logic_vector(31 downto 0));
	end component;

begin

ran_inst:RAM
	PORT MAP(clk=>Clk,
	inst_addr=>tmp_PC(12 downto 2),
	inst_dout=>tmp_MEM_instruction,
	data_we=>tmp_Mem_WrEn,
	data_addr=>tmp_MEM_write_data_address,
	data_din=>tmp_MEM_data_to_write,
	data_dout=>tmp_MEM_return_data,
	byte_operation=>tmp_MEM_write_enable_data);
control_inst:CONTROL
	PORT MAP(
	Instr=>tmp_MEM_instruction,	
	RF_B_sel=>tmp_RF_B_sel,
	RF_WrEn=>tmp_RF_WrEn,
	ImmExt=>tmp_ImmExt,
	RF_WrData_sel=>tmp_RF_WrData_sel,
	PC_sel=>tmp_PC_sel,
	PC_LdEn=>tmp_PC_LdEn,
	ALU_Bin_sel=>tmp_ALU_Bin_sel,	
	ByteOp=>tmp_ByteOp,
	Mem_WrEn=>tmp_Mem_WrEn,
	Reset=>tmp_Reset,
	instr_type=>tmp_instr_type);

datapath_inst:DATAPATH
	PORT MAP(Clk=>Clk,
	RF_B_sel=>tmp_RF_B_sel,
	RF_WrEn=>tmp_RF_WrEn,
	ImmExt=>tmp_ImmExt,
	RF_WrData_sel=>tmp_RF_WrData_sel,
	PC_sel=>tmp_PC_sel,
	PC_LdEn=>tmp_PC_LdEn,
	ALU_Bin_sel=>tmp_ALU_Bin_sel,
	
	ByteOp=>tmp_ByteOp,
	Mem_WrEn=>tmp_Mem_WrEn,
	RST=>RST,
	instr_type=>tmp_instr_type,
	ALU_zero=>tmp_ALU_zero,
	PC=>tmp_PC,
	MEM_instruction=>tmp_MEM_instruction,
	MEM_write_data_address=>tmp_MEM_write_data_address,
	MEM_write_enable_data=>tmp_MEM_write_enable_data,
	MEM_return_data=>tmp_MEM_return_data,
	MEM_data_to_write=>tmp_MEM_data_to_write);
	

end Behavioral;

