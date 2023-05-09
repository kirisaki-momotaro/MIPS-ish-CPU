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


entity Instr_Separator is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           out_25_21 : out  STD_LOGIC_VECTOR (4 downto 0);
           out_15_11 : out  STD_LOGIC_VECTOR (4 downto 0);
           out_20_16 : out  STD_LOGIC_VECTOR (4 downto 0);
           out_15_0 : out  STD_LOGIC_VECTOR (15 downto 0));
end Instr_Separator;

architecture Behavioral of Instr_Separator is
signal instruction:STD_LOGIC_VECTOR (31 downto 0);
begin
instruction<=Instr;
out_25_21<=instruction(25 downto 21);
out_15_11<=instruction(15 downto 11);
out_20_16<=instruction(20 downto 16);
out_15_0<=instruction(15 downto 0);
end Behavioral;

