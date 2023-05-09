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

entity Immediate_Handler is
    Port ( immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end Immediate_Handler;

architecture Behavioral of Immediate_Handler is

begin
	process(immediate,ImmExt)
		begin
			if(ImmExt="00") then
				if(immediate(15)='0') then
					Immed<=(x"0000" & immediate);
				else
					Immed<=("1111111111111111" & immediate);
				end if;
			elsif(ImmExt="01") then
				Immed<=( immediate & x"0000");
			elsif(ImmExt="10") then
				Immed<=(x"0000" & immediate);
			else
				Immed<=x"00000000";
			end if;
				
			
	end process;

end Behavioral;

