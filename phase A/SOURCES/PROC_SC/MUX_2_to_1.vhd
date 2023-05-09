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


entity MUX_2_to_1 is
    Port ( PC_plus_4 : in  STD_LOGIC_VECTOR (31 downto 0);
				PC_sel: in  STD_LOGIC;
           PC_Immed_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MUX_Output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_2_to_1;

architecture Behavioral of MUX_2_to_1 is
signal tmp_MUX_Output :STD_LOGIC_VECTOR (31 downto 0);

begin
process(PC_plus_4,PC_sel,PC_Immed_out) 
	begin

	if (PC_sel='0') then
		tmp_MUX_Output<= PC_plus_4;
	else
		tmp_MUX_Output<= PC_Immed_out;
	end if;
			
end process;
MUX_Output<=tmp_MUX_Output;
end Behavioral;

