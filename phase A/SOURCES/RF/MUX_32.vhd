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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_32 is
    Port (reg0 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg1 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg2 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg3 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg4 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg5 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg6 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg7 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg8 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg9 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg10 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg11 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg12 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg13 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg14 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg15 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg16 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg17 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg18 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg19 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg20 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg21 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg22 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg23 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg24 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg25 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg26 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg27 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg28 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg29 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg30 : in  STD_LOGIC_VECTOR (31 downto 0);
	 reg31 : in  STD_LOGIC_VECTOR (31 downto 0);	 
			  MUX_Output: out  STD_LOGIC_VECTOR (31 downto 0);	
           Ard : in  STD_LOGIC_VECTOR (4 downto 0));
end MUX_32;

architecture Behavioral of MUX_32 is

begin
	
			with(Ard) select
				MUX_Output<= reg0 when "00000",
					reg1 when "00001",
					reg2 when "00010",
					reg3 when "00011",
					reg4 when "00100",
					reg5 when "00101",
					reg6 when "00110",
					reg7 when "00111",
					reg8 when "01000",
					reg9 when "01001",
					reg10 when "01010",
					reg11 when "01011",
					reg12 when "01100",
					reg13 when "01101",
					reg14 when "01110",
					reg15 when "01111",
					reg16 when "10000",
					reg17 when "10001",
					reg18 when "10010",
					reg19 when "10011",
					reg20 when "10100",
					reg21 when "10101",
					reg22 when "10110",
					reg23 when "10111",
					reg24 when "11000",
					reg25 when "11001",
					reg26 when "11010",
					reg27 when "11011",
					reg28 when "11100",
					reg29 when "11101",
					reg30 when "11110",
					reg31 when "11111",
					reg0  when others;
					
		
					


end Behavioral;

