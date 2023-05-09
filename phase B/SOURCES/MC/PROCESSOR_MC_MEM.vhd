
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity PROCESSOR_MC_MEM is
port(Clk : in  STD_LOGIC;
	 RST: in  STD_LOGIC);
end PROCESSOR_MC_MEM;

architecture Behavioral of PROCESSOR_MC_MEM is
component PROCESSOR_MC is
    Port ( Clk : in  STD_LOGIC;
	 RST: in  STD_LOGIC;
	 
	 
	 inst_addr : out std_logic_vector(10 downto 0);
		inst_dout : in std_logic_vector(31 downto 0);
		data_we : out std_logic;
		data_addr : out std_logic_vector(10 downto 0);
		data_din : out std_logic_vector(31 downto 0);
		data_dout : in std_logic_vector(31 downto 0);
		byte_operation : out std_logic_vector(31 downto 0)
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
	
	
	
	
	
	
	
	
signal tmp_MEM_data_to_write: STD_LOGIC_VECTOR (31 downto 0); 
signal tmp_PC:  STD_LOGIC_VECTOR (31 downto 0);    --address of the next instruction --TO MEMORY				
signal tmp_MEM_instruction:  STD_LOGIC_VECTOR (31 downto 0);-- next instruction --TO MEMORY
				
				--memstage signals
signal tmp_MEM_write_data_address : STD_LOGIC_VECTOR(10 downto 0);--data address to write to memory 
signal tmp_MEM_write_enable_data  :STD_LOGIC_VECTOR(31 downto 0);--
signal tmp_MEM_return_data : STD_LOGIC_VECTOR(31 downto 0);--\
signal tmp_Mem_WrEn :   STD_LOGIC;

begin
inst_PROCESSOR_MC:PROCESSOR_MC
PORT MAP(Clk=>Clk,RST=>RST,
inst_addr=>tmp_PC(12 downto 2),
	inst_dout=>tmp_MEM_instruction,
	data_we=>tmp_Mem_WrEn,
	data_addr=>tmp_MEM_write_data_address,
	data_din=>tmp_MEM_data_to_write,
	data_dout=>tmp_MEM_return_data,
	byte_operation=>tmp_MEM_write_enable_data);
	
inst_RAM:RAM
PORT MAP(
	clk=>Clk,
	inst_addr=>tmp_PC(12 downto 2),
	inst_dout=>tmp_MEM_instruction,
	data_we=>tmp_Mem_WrEn,
	data_addr=>tmp_MEM_write_data_address,
	data_din=>tmp_MEM_data_to_write,
	data_dout=>tmp_MEM_return_data,
	byte_operation=>tmp_MEM_write_enable_data);

end Behavioral;

