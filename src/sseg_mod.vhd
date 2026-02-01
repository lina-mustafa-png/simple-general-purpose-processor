LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg_mod IS
	PORT ( bcd  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 leds : OUT STD_LOGIC_VECTOR(0 TO 6)
	);
END sseg_mod;

ARCHITECTURE Behavior OF sseg_mod IS
BEGIN 
	PROCESS (bcd)
	BEGIN
			CASE bcd IS          --    abcdefg
			WHEN "1010" => leds <=NOT "0110011"; -- y
			WHEN "1011" => leds <=NOT "1110110"; -- n
			WHEN OTHERS => leds <= "-------";
			
		END CASE;
	END PROCESS;
END Behavior;