LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder IS
	PORT(w 	: IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 3 inputs
		  En  : IN STD_LOGIC;
		  y	: OUT STD_LOGIC_VECTOR(0 TO 7)); -- 8 outputs
END decoder;

ARCHITECTURE Behavior OF decoder IS
begin
	process (w, En)
	begin
		if En = '1' then
			case w is
				when "000" => y <= "10000000";
				when "001" => y <= "01000000";
				when "010" => y <= "00100000";
				when "011" => y <= "00010000";
				when "100" => y <= "00001000";
				when "101" => y <= "00000100";
				when "110" => y <= "00000010";
				when "111" => y <= "00000001";
				when others => y <= "00000000";
			end case;
		else
			y <= (others => '0');
		end if;
	end process;
end Behavior;