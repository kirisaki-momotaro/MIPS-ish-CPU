
---------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Technical University Of Crete
-- School Of Electrical & Computer Engineering 

-- Computer Organisation [HRY302]


-- Christos Ioannidis  -  2018030006

-- Project Name  HRY302_part_1
-- Module Name   
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;







entity register_4_bit is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Datain : in  STD_LOGIC_VECTOR (3 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (3 downto 0));
end register_4_bit;

architecture Behavioral of register_4_bit is
signal Register_Data :STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
	process
		begin
		
			WAIT UNTIL CLK'EVENT AND CLK = '1';
			
			IF (RST = '1') THEN
				Register_Data<="0000";
			ELSE
				IF(WE = '1') THEN
					Register_Data<=Datain;
					
				ELSE
					Register_Data<=Register_Data;
					
				END IF;
				
				
			END IF;	
		
	end process;
	Dataout<=Register_Data;	
end Behavioral;