library ieee;
use ieee.std_logic_1164.all;

entity AccurateAdder is	 
	port( A, B: in std_logic_vector(15 downto 0);
		Cin: in std_logic;
		Cout: out std_logic;
		Sum: out std_logic_vector(15 downto 0));
end AccurateAdder;


architecture AccurateAdder of AccurateAdder is 

	component full_adder is
		port(a, b, cin: in std_logic;
			cout, sum: out std_logic);
	end component;
	
	signal c: std_logic_vector(16 downto 0);
	
begin
	GA: for i in 0 to 15 generate
		GA0: if i = 0 generate	  
			a0: full_adder port map (A(0), B(0), Cin, c(1), Sum(0));		   
		end generate GA0;
		GAI: if i > 0 generate
			ai: full_adder port map(A(i), B(i), c(i), c(i+1), Sum(i));	
		end generate GAI;
	end generate GA;
	Cout <= c(16);
	
end AccurateAdder;	