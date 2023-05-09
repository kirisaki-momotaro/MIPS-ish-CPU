library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--author--IOANNIDIS CHRISTOS 2018030006

entity MEMSTAGE is
Port (     ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
			  
			  
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  
           MM_Addr : out  STD_LOGIC_VECTOR (10 downto 0);
           MM_WrEn : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);	
			  
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

signal byte_op:STD_LOGIC_VECTOR (2 downto 0);
signal tmp_ALU_MEM_Addr:STD_LOGIC_VECTOR (31 downto 0);

begin	
		
		
	
	
	--mem address
	tmp_ALU_MEM_Addr<=ALU_MEM_Addr;	
	byte_op<=ByteOp & tmp_ALU_MEM_Addr(1 downto 0);
	
	with byte_op select
		
		MM_WrEn<="00000000000000000000000011111111" when "100",
					"00000000000000001111111100000000" when "101",
					"00000000111111110000000000000000" when "110",
					"11111111000000000000000000000000" when "111",
					"11111111111111111111111111111111" when others;
	
	MM_Addr<=tmp_ALU_MEM_Addr(12 downto 2)+"10000000000";	
	
	with byte_op select
	
	MEM_DataOut<=MM_RdData and "00000000000000000000000011111111" when "100",
					 MM_RdData and "00000000000000001111111100000000" when "101",
					 MM_RdData and "00000000111111110000000000000000" when "110",
					 MM_RdData and "11111111000000000000000000000000" when "111",
					 MM_RdData and "11111111111111111111111111111111" when others;
	
	MM_WrData<=MEM_DataIn;	
	
	

end Behavioral;

