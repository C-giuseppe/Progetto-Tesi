library ieee;
use ieee.std_logic_1164.all;

entity FER is 
	port(A,B: in std_logic_vector(1 downto 0);
	     I4, I5: in std_logic;
	     S6, S7: out std_logic);
end FER;

architecture FER of FER is
begin
 process(A,B)
     begin
	-- sum of (m-2) e (m-1) bit --
	-- formulas 2.10 and 2.11, respectively --
	S6 <= A(0) xor B(0);
	S7 <= ((A(1) xor B(1)) xor (A(1) and B(1)));

 end process;
end FER;


