library ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity ALU_mod is
port (Clock      : in std_logic; -- input clock signal
		A, B  	  : in unsigned(7 DOWNTO 0); -- 8-bit inputs from latches A and B
		OP         : in unsigned (15 DOWNTO 0); -- 16-bit selector for Operation from Decoder
		Neg        : out std_logic; -- is the result of the negative? ste -ve bit output
		R1         : out unsigned (3 DOWNTO 0); -- lower 4-bits of 8-bit result output
		R2         : out unsigned (3 DOWNTO 0) -- higher 4-bits of 8-bit result output
);
end ALU_mod;

architecture calculation of ALU_mod is -- temporary signal declarations
signal Reg1, Reg2, Result : unsigned (7 DOWNTO 0) := (others => '0');
signal Reg4 : unsigned (0 to 7);
begin
	Reg1 <= A; -- temporarily store A in Reg1 local variable
	Reg2 <= B; -- temporarily store B in Reg2 local variable

process (Clock)
begin
	if (rising_edge(Clock)) THEN -- do the calculation @ positive edge of clock cycle
		case OP is
			WHEN "0000000000000001" =>
				-- increment A by 2
				Result <= Reg1 + 2;
				
			WHEN "0000000000000010" =>
				-- shift B to right by two bits, input bit = 0 (SHR)
				Result <= "00" & Reg2(7 DOWNTO 2);
				
			WHEN "0000000000000100" =>
				-- shift A to right by four bits, input bit = 1 (SHR)
				Result <= "1111" & Reg1(7 DOWNTO 4);
				
			WHEN "0000000000001000" =>
				-- find the smaller value of A and B and produce the results (Min(A,B))
				if Reg1 < Reg2 then 
					Result <= Reg1;
				else 
					Result <= Reg2;
				end if;
					
			WHEN "0000000000010000" =>
				-- rotate A to right by two bits (ROR)
				Result <= Reg1(1 DOWNTO 0) & Reg1(7 DOWNTO 2);
					
			WHEN "0000000000100000" =>
				-- invert the bit-significance order of B
				Result <= Reg2(0) & Reg2(1) & Reg2(2) & Reg2(3) & Reg2(4) & Reg2(5) & Reg2(6) & Reg2(7);
					
			WHEN "0000000001000000" =>
				-- produce the result of XORing A and B
				Result <= Reg1 XOR Reg2;
					
					
			WHEN "0000000010000000" =>
				-- produce the summation of A and B, then decrease it by 4
				Result <= Reg1 + Reg2 - 4;
					
			WHEN "0000000100000000" =>
				-- produce all high bits on the output
				Result <= (others => '1');
				
			WHEN OTHERS =>
				-- dont care, do nothing
				Result <= (others => '0');
		end case;
	end if;
end process;

R1 <= Result(3 DOWNTO 0); -- since the output seven segments can
R2 <= Result(7 DOWNTO 4); -- only 4-bits, split the 8-bit to two 4-bits
end calculation;