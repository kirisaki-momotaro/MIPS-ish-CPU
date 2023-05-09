
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--author--IOANNIDIS CHRISTOS 2018030006


entity ALU_Cntl is
    Port ( func : in  STD_LOGIC_VECTOR (5 downto 0); 
				instr_type : in  STD_LOGIC_VECTOR (2 downto 0); 
           ALU_Operation : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU_Cntl;

architecture Behavioral of ALU_Cntl is

begin


ALU_Operation<=			"1110" when (instr_type="000")else --alu out =rf b--not used
								"0000"  when (instr_type="001")else--+immed
								"0011"  when (instr_type="010")else--or immed
								"0101"  when (instr_type="011")else--nand immed
								func(3 downto 0);
								
	
					
					

end Behavioral;

