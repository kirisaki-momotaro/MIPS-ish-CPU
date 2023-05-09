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

entity MUX_ALU is
    Port ( RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           MUX_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC);
end MUX_ALU;

architecture Behavioral of MUX_ALU is

begin
with(ALU_Bin_sel) select
				MUX_out<= RF_B when '0',
				Immed when '1',
				Immed when others;


end Behavioral;

