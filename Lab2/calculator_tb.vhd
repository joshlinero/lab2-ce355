library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;
-- Additional standard or custom libraries go here

entity calculator_tb is
end entity;

architecture calculator_test of calculator_tb is

    -- Signal declaration for waveform visibility
    signal signal_temp1 : std_logic_vector(1 downto 0);

begin

	process is

		variable temp1 : std_logic_vector(1 downto 0);
		variable my_line : line;
		file infile: text open read_mode is "cal8.in";
		file outfile: text open write_mode is "cal8.out";
		
		begin
			write(my_line, string'("Beginning to test cal8..."));
			writeline(outfile, my_line);
			
			while not (endfile(infile)) loop
				readline(infile, my_line);
				read(my_line, temp1);
				
				signal_temp1 <= temp1;
				
				if temp1(0) /= '0' then
					write(my_line, string'(" not zero "));
					write(my_line, temp1);
					writeline(outfile, my_line);
				end if;
				
			end loop;
			
			write(my_line, string'("Finishing the test for cal8..."));
			writeline(outfile, my_line);
			wait;
		
	end process;
end architecture calculator_test;
