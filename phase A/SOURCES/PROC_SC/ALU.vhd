----------------------------------------------------------------------------------
-- Technical University Of Crete
-- School Of Electrical & Computer Engineering 

-- Computer Organisation [HRY302]


-- Christos Ioannidis  -  2018030006

-- Project Name  HRY302_part_1
-- Module Name   ALU
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all; 


entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	
begin
	process(A,B,Op)
	variable temp: STD_LOGIC_VECTOR (32 downto 0);
	variable zeroVar: STD_LOGIC;
	variable outVar: STD_LOGIC_VECTOR (31 downto 0);
	variable ovfVar: STD_LOGIC;
	variable coutVar: STD_LOGIC;
	
		begin
			temp:="000000000000000000000000000000000";
			ovfVar:='0';
			zeroVar:='0';
			coutVar:='0';
			
			case Op is
				when "0000" =>
					temp:=('0' & A)+('0' & B);
					outVar:=temp(31 downto 0);
					coutVar:=temp(32);
					ovfVar:=temp(31) xor A(31) xor B(31) xor coutVar;
					
				when "0001" =>					
					temp:=('0' & A)-('0' &B);
					outVar:=temp(31 downto 0);
					coutVar:=temp(32);
					ovfVar:=temp(31) xor A(31) xor B(31) xor coutVar;
				when "0010" =>
					outVar:=A and B;
				when "0011" =>
					outVar:=A or B;
				when "0100" =>
					outVar:=not A;
				when "0101" =>
					outVar:=not(A and B);
				when "0110" =>
					outVar:=not(A or B);
				when "1000" =>
					outVar(31):=A(31);
					for I in 30 downto 0 loop
						outVar(I):=A(I+1);
					end loop;
				when "1001" =>
					outVar(31):='0';
					for I in 30 downto 0 loop
						outVar(I):=A(I+1);
					end loop;
				when "1010" =>
					outVar(0):='0';
					for I in 1 to 31 loop
						outVar(I):=A(I-1);
					end loop;
				when "1100" =>
					outVar(0):=A(31);
					for I in 1 to 31 loop
						outVar(I):=A(I-1);
					end loop;
				when "1101" =>
					outVar(31):=A(0);
					for I in 30 downto 0 loop
						outVar(I):=A(I+1);
					end loop;
				when "1110" =>--return b contents
					outVar:=B;
				when others=>
					outVar:="00000000000000000000000000000000";				
			end case;
			
			if(outVar = 0) then
				Zero<='1';
			else
				Zero<='0';
			end if;
			
			Output<=outVar;
			Ovf<=ovfVar;
			Zero<=zeroVar;
			Cout<=coutVar;
			
				
			
		end process;
				
				

end Behavioral;

