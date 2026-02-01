library ieee;
use ieee.std_logic_1164.all;

-- moore = output is based only on the current state 
entity FSM is 
	port 
	(
		clk			  : in std_logic; -- step in time
		data_in  	  : in std_logic; -- step at '1' // tells FSM whether to move to next digit or stay
		reset			  : in std_logic; -- active high reset
		student_id	  : out std_logic_vector(3 downto 0);
		current_state : out std_logic_vector(3 downto 0)
	);
end entity;

architecture fsm of FSM is 
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
	
	signal yfsm : state_type; -- current state (storage)// yfsm = state
	
begin
-- state transition
	process (clk, reset)
	begin 
		if reset = '1' then
			yfsm <= s0;
		elsif (clk'event AND clk = '1') then -- rising_edge
			case yfsm is
				when s0 =>
					yfsm <= s1;
				
				when s1 =>
					yfsm <= s2;
					
				when s2 =>
					yfsm <= s3;
					
				when s3 =>
					yfsm <= s4;
					
				when s4 =>
					yfsm <= s5;
					
				when s5 =>
					yfsm <= s6;
					
				when s6 =>
					yfsm <= s7;
					
				when s7 =>
					yfsm <= s8;
					
				when s8 =>
					yfsm <= s0;
				
			end case;
		end if;
end process;

-- 501291607
-- output (student_id) depends only on the current state -> changes after the clock updates

process (yfsm) is
begin
	case yfsm is
		when s0 =>
			student_id 	  <= "0101"; -- 5
			
		when s1 =>
			student_id    <= "0000"; -- 0
			
		when s2 =>
			student_id    <= "0001"; -- 1
			
		when s3 =>
			student_id    <= "0010"; -- 2
			
		when s4 =>
			student_id    <= "1001"; -- 9
			
		when s5 =>
			student_id    <= "0001"; -- 1
			
		when s6 =>
			student_id    <= "0110"; -- 6
			
		when s7 =>
			student_id    <= "0000"; -- 0
			
		when s8 =>
			student_id    <= "0111"; -- 7
			
	end case;
end process;

-- current state output for decoder
process (yfsm)
	begin
		case yfsm is 
			when s0 =>
					current_state <= "0000"; -- 0 
				
			when s1 =>
					current_state <= "0001"; -- 1
				
			when s2 =>
					current_state <= "0010"; -- 2
				
			when s3 =>
					current_state <= "0011"; -- 3

			when s4 =>
					current_state <= "0100"; -- 4
				
			when s5 =>
					current_state <= "0101"; -- 5

			when s6 =>
					current_state <= "0110"; -- 6

			when s7 =>
					current_state <= "0111"; -- 7
				
			when s8 =>
					current_state <= "1000"; -- 8

		end case;
	end process;		
end architecture;