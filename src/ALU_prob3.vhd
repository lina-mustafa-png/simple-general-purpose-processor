library ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU_prob3 is
port (Clock      : in std_logic; -- input clock signal
		A, B  	  : in unsigned(7 DOWNTO 0); -- 8-bit inputs from latches A and B
		student_id : in unsigned(3 DOWNTO 0); -- 4-bit student id from FSM
		OP         : in unsigned (15 DOWNTO 0); -- 16-bit selector for Operation from Decoder
		Result     : out unsigned (3 DOWNTO 0) -- higher 4-bits of 8-bit result output
);
end ALU_prob3;

architecture calculation of ALU_prob3 is -- temporary signal declarations
signal cond_yn : std_logic;

begin
--'y' if one of the 2 digits of B are less than FSM output 
--(student_id) and 'n' otherwise. 
	cond_yn <= '1' when
			(B(3 DOWNTO 0) < student_id) or
			(B(7 DOWNTO 4) < student_id)
		else '0';
			
process (Clock)
begin
	if (rising_edge(Clock)) THEN -- do the calculation @ positive edge of clock cycle
		if cond_yn = '1' then 
			Result <= "1010"; -- y
		else 
			Result <= "1011"; -- n
		end if;
	end if;
end process;
end calculation;