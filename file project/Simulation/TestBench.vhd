library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.math_real.all;
use std.textio.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture tbbrand of tb is
    signal A, B: std_logic_vector(15 downto 0);
    signal Ris_accurate, Ris_approx_8, Ris_approx_5: std_logic_vector(15 downto 0);
    signal Cin, Cout: std_logic;
    
    component AccurateAdder is 
	port( a, b: in std_logic_vector(15 downto 0);
		cin: in std_logic;
		cout: out std_logic;
		sum: out std_logic_vector(15 downto 0));
    end component;

    component ApproxAdder_8 is 
	port( a, b: in std_logic_vector(15 downto 0);
		sum: out std_logic_vector(15 downto 0));
    end component;

    component ApproxAdder_5 is 
	port( a, b: in std_logic_vector(15 downto 0);
		sum: out std_logic_vector(15 downto 0));
     end component;

begin

    U1: AccurateAdder port map( a => A, b => B, cin => Cin, cout => Cout, sum => Ris_accurate);
    U2: ApproxAdder_8 port map( a => A, b => B, sum => Ris_approx_8);
    U3: ApproxAdder_5 port map( a => A, b => B, sum => Ris_approx_5);
    Cin <= '0';
    process
        variable seed1, seed2: integer := 55;
        variable r1, r2 : real;
        constant max: integer := 255;
        constant min: integer := 0;
        variable ia, ib: integer;
        variable vA, vB: std_logic_vector(15 downto 0);

        file ft: text;
        variable l: line;
        
    begin 
        file_open(ft, "C:\intelFPGA\20.1\tesi\file project\Simulation\prova.txt", write_mode); 
       
        for i in 0 to 9999 loop
                        
            uniform(seed1, seed2, r1); 
            ia := integer(round(r1 * real(max-min) + real(min) - 0.5));
            vA := conv_std_logic_vector(ia,16);
            
            uniform(seed1, seed2, r2); 
            ib := integer(round(r2 * real(max-min) + real(min) - 0.5));
            vB := conv_std_logic_vector(ib,16);
            
	    write(l, string'("A: "));
            write(l, integer'image(ia));
            writeline(ft, l);

	    write(l, string'("B: "));
            write(l, integer'image(ib));
            writeline(ft, l);

            A <= vA;
            B <= vB;
                        
            wait for 10 ns;
	    write(l, string'("Ris_accu: "));
            write(l, Ris_accurate);
            writeline(ft, l);
	    write(l, string'("Ris_app8: "));
            write(l, Ris_approx_8);
            writeline(ft, l);
	    write(l, string'("Ris_app5: "));
            write(l, Ris_approx_5);
            writeline(ft, l);
	    writeline(ft, l);

        end loop;
        
        file_close(ft);
        wait;

    end process;
end tbbrand;
