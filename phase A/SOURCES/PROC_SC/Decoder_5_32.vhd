
----------------------------------------------------------------------------------
-- Technical University Of Crete
-- School Of Electrical & Computer Engineering 

-- Computer Organisation [HRY302]
-- Lab 5 - 20052020

-- Christos Ioannidis  -  2018030006

-- Project Name  HRY302_part_1
-- Module Name   ALU
----------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder_5_32 is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Decoder_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder_5_32;

architecture Behavioral of Decoder_5_32 is

begin
	process(Awr)
	
		begin
			Decoder_Out<=x"00000000";
			for n in 0 to 31 loop
				if (Awr=n) then
					Decoder_out(n)<='1';
				end if;
			end loop;
	end process;
			
					


end Behavioral;

