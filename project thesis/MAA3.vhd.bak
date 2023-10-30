library ieee;
use ieee.std_logic_1164.all;

entity MAA3 is
	port(A, B: in std_logic_vector(2 downto 0);
	     Sum_M: out std_logic_vector(2 downto 0);
	     Maa3: out std_logic);
end MAA3;

architecture MAA3 of MAA3 is
begin
 process(A,B)
   variable S, S0, S1, S2, G0, G1: std_logic;
     begin
	-- generation bit --
	G0 := A(0) and B(0);
	G1 := A(1) and B(1);

	-- sum of three bits--
	-- formulas 2.12, 2.13 and 2.14, respectively --
	S0 := A(0) xor B(0);
	S1 := (A(1) xor B(1)) xor G0;
	S2 := (A(2) xor B(2)) xor G1;

	if (S0 > S1) AND (S0 > S2) then S:= S0;
 	elsif (S1 > S0) AND (S1 > S2) then S:= S1;
	else S:= S2;
	end if;

	Maa3 <= A(2) and B(2) and S;
	Sum_M(0) <= S0;
	Sum_M(1) <= S1;
	Sum_M(2) <= S2;
	
 end process;
end MAA3;
