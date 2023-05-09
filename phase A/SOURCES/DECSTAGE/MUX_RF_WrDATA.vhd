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

entity MUX_RF_WrData is
    Port ( ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RD_WrData_sel : in  STD_LOGIC;
           WrData : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_RF_WrData;

architecture Behavioral of MUX_RF_WrData is

begin
	with(RD_WrData_sel) select
				WrData<= ALU_out when '0',
				MEM_out when '1',
				MEM_out when others;

end Behavioral;

