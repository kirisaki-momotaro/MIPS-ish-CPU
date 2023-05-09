
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--author--IOANNIDIS CHRISTOS 2018030006

entity PC_Immed_Adder is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			PC_plus_four : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end PC_Immed_Adder;

architecture Behavioral of PC_Immed_Adder is
signal immed_times_four:STD_LOGIC_VECTOR (29 downto 0);

begin
	process(PC_Immed,PC_plus_four,immed_times_four)
		begin
		immed_times_four<=PC_Immed(31 downto 2);
		output<=PC_plus_four+(immed_times_four & "00");
	end process;
end Behavioral;

