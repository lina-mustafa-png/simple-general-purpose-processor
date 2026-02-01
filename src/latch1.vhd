LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY latch1 IS
	PORT (A				 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Reset, Clock : IN STD_LOGIC;
			Q				 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
		
END latch1;

ARCHITECTURE Behavior OF latch1 IS
BEGIN
	PROCESS (Reset, Clock)
	BEGIN
		IF Reset = '0' THEN
			Q <= "00000000";
		ELSIF Clock'EVENT AND CLOCK = '1' THEN
			Q <= A;
		END IF;
	END PROCESS;
END Behavior;