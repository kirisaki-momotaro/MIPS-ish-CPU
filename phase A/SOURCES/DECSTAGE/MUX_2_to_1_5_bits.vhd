
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

entity MUX_2_to_1_5_bits is
    Port ( input_0 : in  STD_LOGIC_VECTOR (4 downto 0);
           input_1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RF_B_sel : in  STD_LOGIC;
           MUX_Output : out  STD_LOGIC_VECTOR (4 downto 0));
end MUX_2_to_1_5_bits;

architecture Behavioral of MUX_2_to_1_5_bits is


begin
	with(RF_B_sel) select
				MUX_Output<= input_0 when '0',
				input_1 when '1',
				input_1 when others;

end Behavioral;

