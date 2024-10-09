library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

use work.calc_const.all;  -- Import constants for data widths

entity calculator_tb2 is
end entity;

architecture calculator_test2 of calculator_tb2 is
    -- Signal declarations (remain in the architecture declaration area)
    signal DIN1      : std_logic_vector(DIN1_WIDTH - 1 downto 0);
    signal DIN2      : std_logic_vector(DIN2_WIDTH - 1 downto 0);
    signal operation : std_logic_vector(OP_WIDTH - 1 downto 0);
    signal DOUT      : std_logic_vector(DOUT_WIDTH - 1 downto 0);
    signal sign      : std_logic;

    -- File handling declaration
    file infile : text open read_mode is "cal8.in";
    file outfile : text open write_mode is "cal8.out";

begin
    -- Test process (variables must be declared here)
    process
        -- Variable declarations (inside the process block)
        variable my_line : line;
        variable input_din1 : integer;
        variable input_din2 : integer;
        variable input_operation : character;
        variable output_result : integer;
        variable output_sign : string(1 to 1);

    begin
        -- Write the starting message to the output file
        write(my_line, string'("Starting the calculator test..."));
        writeline(outfile, my_line);

        -- Loop through the input file

		  while not endfile(infile) loop
		  
				 -- Read DIN1
				 readline(infile, my_line);
				 read(my_line, input_din1);
			
				 -- Read DIN2
				 readline(infile, my_line);
				 read(my_line, input_din2);
			
				 -- Read operation
				 readline(infile, my_line);
				 read(my_line, input_operation);
			
				 -- Debugging: Log the read values to the output file to verify correctness
				 write(my_line, string'("Read values: DIN1=" & integer'image(input_din1) &
											 ", DIN2=" & integer'image(input_din2) &
											 ", Operation=" & character'image(input_operation)));
				 writeline(outfile, my_line);
			
				 -- Apply values to the calculator inputs
				 DIN1 <= std_logic_vector(to_signed(input_din1, DIN1_WIDTH));
				 DIN2 <= std_logic_vector(to_signed(input_din2, DIN2_WIDTH));
			
				 -- Map the character operation to the corresponding binary code
				 if input_operation = '+' then
					  operation <= "00";  -- Addition
				 elsif input_operation = '-' then
					  operation <= "01";  -- Subtraction
				 elsif input_operation = '*' then
					  operation <= "10";  -- Multiplication
				 else
					  operation <= "11";  -- Default or invalid operation
				 end if;
			
				 -- Wait for the operation to complete (simulate clock delay)
				 wait for 10 ns;
			
				 -- Convert output to integer for writing to the output file
				 output_result := to_integer(signed(DOUT));
			
				 -- Determine the sign of the output based on the sign signal
				 if sign = '1' then 
					  output_sign := "+";  
				 else 
					  output_sign := "-";  
				 end if;
			
				 -- Write the results to the output file
				 write(my_line, string'("DIN1=" & integer'image(input_din1) &
											 ", DIN2=" & integer'image(input_din2) &
											 ", Operation=" & character'image(input_operation) &
											 " => Result=" & integer'image(output_result) &
											 ", Sign=" & output_sign));
				 writeline(outfile, my_line);
			end loop;


        -- Write the ending message to the output file
        write(my_line, string'("Calculator test complete."));
        writeline(outfile, my_line);

        -- Stop the simulation
        wait;
    end process;
end architecture calculator_test2;

