library ieee;
use ieee.std_logic_1164.all;

entity ApproxAdder_8 is	 
	port( A, B: in std_logic_vector(15 downto 0);
		Sum: out std_logic_vector(15 downto 0));
end ApproxAdder_8;


architecture ApproxAdder_8 of ApproxAdder_8 is 
	component Cmsp is
		port(a, b: in std_logic_vector(2 downto 0);
			Cmsp: out std_logic);
	end component;

	component FER is 
		port (a, b: in std_logic_vector(1 downto 0);
			i4, i5: in std_logic;
			s6, s7: out std_logic);
	end component;

	component MAA3 is
		port( a, b: in std_logic_vector(2 downto 0);
		      Sum_M: out std_logic_vector(2 downto 0);
		      Maa3: out std_logic);
	end component;

	component Accurate_Approx_Adder is 
		port ( a, b: in std_logic_vector(7 downto 0);
			cin: in std_logic;
			cout: out std_logic;
			sum: out std_logic_vector(7 downto 0));
	end component;

	signal c, m1, m2, s6, s7, cout: std_logic;
	
	--control signal for the Accurate component --
	signal sumn: std_logic_vector(7 downto 0);
	signal An: std_logic_vector(7 downto 0);
	signal Bn: std_logic_vector(7 downto 0);
	-- control signal for the Cmsp component --
	signal Amc: std_logic_vector(2 downto 0);
	signal Bmc: std_logic_vector(2 downto 0);
	-- control signal for the FER component --
	signal Amf: std_logic_vector(1 downto 0);
	signal Bmf: std_logic_vector(1 downto 0);
	-- control signal for the first MAA3 component --
	signal Summa: std_logic_vector(2 downto 0);
	signal Ama: std_logic_vector(2 downto 0);
	signal Bma: std_logic_vector(2 downto 0);
	-- Control signal for the second MAA3 component --

	signal Summaa: std_logic_vector(2 downto 0);
	signal Amaa: std_logic_vector(2 downto 0);
	signal Bmaa: std_logic_vector(2 downto 0);
		
begin
	-- for the first MAA3 block, take bits from position 0 to 2 --
	-- for the second MAA3 block, take bits from position 3 to 5 --
	-- por Fer, take the first 2 bits LSP (position 6 and 7) --
	-- for CMSP, take the first 3 bits LSP(position 5, 6, 7) --
	-- for Accurate, take bits from position 8 to 15 --
	process (A, B) is
		variable j : integer;
		variable h : integer;
	begin
	j := 0;
	h := 0;
	for i in 0 to 15 loop
		if i < 3 then
			Ama(i) <= A(i);
			Bma(i) <= B(i);
		elsif i < 6 then
			Amaa(h) <= A(i);
			Bmaa(h) <= B(i);
			h := h+1;
			if i = 5 then
				Amc(j) <= A(i);
				Bma(j) <= B(i);
				h:= 0;
				j:= j + 1;
			end if;
		elsif i < 8 then
			Amf(h) <= A(i);
			Bmf(h) <= B(i);
			h:= h+1;
			
			Amc(j) <= A(i);
			Bmc(j) <= B(i);
			j:= j +1;
		elsif i >= 8 then
			if i = 8 then
 				h:=0;
			end if;
			An(h) <= A(i);
			Bn(h) <= B(i);
			h:= h + 1;
		end if;
	end loop;
	end process;

	P_MAA3_1 : MAA3 port map(Ama, Bma, Summa, m1);
	P_Maa3_2 : MAA3 port map(Amaa, Bmaa, Summaa, m2);
	P_FER: FER port map(Amf, Bmf, '0', '1', s6, s7);
	P_Cmsp: Cmsp port map(Amc, Bmc, c);
	P_Accurate_Approx_Adder: Accurate_Approx_Adder port map( An, Bn, c, cout, sumn);
	
	Sum(0) <= Summa(0);
	Sum(1) <= Summa(1);
	Sum(2) <= Summa(2);
	Sum(3) <= Summaa(0);
	Sum(4) <= Summaa(1);
	Sum(5) <= Summaa(2);
	Sum(6) <= s6;
	Sum(7) <= s7;
	Sum(8) <= sumn(0);
	Sum(9) <= sumn(1);
	Sum(10) <= sumn(2);
	Sum(11) <= sumn(3);
	Sum(12) <= sumn(4);
	Sum(13) <= sumn(5);
	Sum(14) <= sumn(6);
	Sum(15) <= sumn(7);

end ApproxAdder_8;
