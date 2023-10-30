library ieee;
use ieee.std_logic_1164.all;

entity Cmsp is		
	port(A,B : in std_logic_vector(2 downto 0);
	     Cmsp: out std_logic);
end Cmsp;

architecture Cmsp of Cmsp is 
begin
 process(A,B)

   variable C1, C2, C3: std_logic;
     begin
	-- formulas 2.6, 2.7, 2.8 and 2.9, respectively --
	C3 := A(0) and B(0);
	C2 := ((A(1) and B(1)) or (A(1) and C3) or (B(1) and C3));
	C1 := ((A(2) and B(2)) or (A(2) and C2) or (B(2) and C2));

	Cmsp <= C1;
 
 end process;
end Cmsp;

