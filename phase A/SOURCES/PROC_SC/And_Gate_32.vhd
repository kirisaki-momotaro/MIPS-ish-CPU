----------------------------------------------------------------------------------
-- Technical University Of Crete
-- School Of Electrical & Computer Engineering 

-- Computer Organisation [HRY302]
-- Lab 5 - 20052020

-- Christos Ioannidis  -  2018030006

-- Project Name  HRY302_part_1
-- Module Name   ALU
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity And_Gate_32 is
    Port ( Input : in  STD_LOGIC_VECTOR (31 downto 0);
           Enable : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end And_Gate_32;

architecture Behavioral of And_Gate_32 is

begin
	process(Input,Enable)
		begin
			for i in 0 to 31 loop
				Output(i)<=Input(i) and Enable;
			end loop;
	end process;


end Behavioral;

