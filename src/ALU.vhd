library ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity ALU is
port (Clock      : in std_logic; -- input clock signal
		A, B  	  : in unsigned(7 DOWNTO 0); -- 8-bit inputs from latches A and B
		OP         : in unsigned (15 DOWNTO 0); -- 16-bit selector for Operation from Decoder
		Neg        : out std_logic; -- is the result of the negative? ste -ve bit output
		R1         : out unsigned (3 DOWNTO 0); -- lower 4-bits of 8-bit result output
		R2         : out unsigned (3 DOWNTO 0) -- higher 4-bits of 8-bit result output
);
end ALU;

architecture calculation of ALU is -- temporary signal declarations
signal Reg1, Reg2, Result : unsigned (7 DOWNTO 0) := (others => '0');
begin
	Reg1 <= A; -- temporarily store A in Reg1 local variable
	Reg2 <= B; -- temporarily store B in Reg2 local variable

process (Clock, OP)
begin
	if (rising_edge(Clock)) THEN -- do the calculation @ positive edge of clock cycle
		Neg <= '0'; -- default
		case OP is
			WHEN "0000000000000001" =>
				-- do addition for Reg1 and Reg2
				Result <= Reg1 + Reg2;
				
			WHEN "0000000000000010" =>
				-- do subtraction
				-- "Neg" bit set if required
				Result <= Reg1 - Reg2;
				if (Reg1 < Reg2) then
					Neg <= '1';
				else 
					Neg <= '0';
				end if;
	
				
			WHEN "0000000000000100" =>
				-- do inverse A
				Result <= NOT Reg1;
					Neg <= '0';
				
			WHEN "0000000000001000" =>
				-- do boolean NAND
				Result <= (NOT (Reg1 AND Reg2));
					Neg <= '0';
					
			WHEN "0000000000010000" =>
				-- do boolean NOR
				Result <= (NOT (Reg1 OR Reg2));
					Neg <= '0';
					
			WHEN "0000000000100000" =>
				-- do boolean AND
				Result <= (Reg1 AND Reg2);
					Neg <= '0';
					
			WHEN "0000000001000000" =>
				-- do boolean XOR
				Result <= (Reg1 XOR Reg2);
					Neg <= '0';
					
			WHEN "0000000010000000" =>
				-- do boolean OR
				Result <= (Reg1 OR Reg2);
					Neg <= '0';
					
			WHEN "0000000100000000" =>
				-- do boolean XNOR
				Result <= (Reg1 XNOR Reg2);
					Neg <= '0';
			WHEN OTHERS =>
				-- dont care, do nothing
				Result <= (others => '0');
		end case;
	end if;
end process;

R1 <= Result(3 DOWNTO 0); -- since the output seven segments can
R2 <= Result(7 DOWNTO 4); -- only 4-bits, split the 8-bit to two 4-bits
end calculation;

		

