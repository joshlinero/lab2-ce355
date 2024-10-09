library IEEE;
use IEEE.std_logic_1164.all; 
--Additional standard or custom libraries go here
use WORK.decoder.all; 
use WORK.calc_const.all;

use IEEE.numeric_std.all;

entity calculator is
    port(
	 
        -- Inputs
        DIN1      : in std_logic_vector(DIN1_WIDTH - 1 downto 0);
        DIN2      : in std_logic_vector(DIN2_WIDTH - 1 downto 0);
        operation : in std_logic_vector(OP_WIDTH - 1 downto 0);
        
        -- Outputs
        DOUT      : out std_logic_vector(DOUT_WIDTH - 1 downto 0);
        sign      : out std_logic
		  
    );
end entity calculator;

architecture behavioral of calculator is 
--Signals and components go here 
	signal result : signed(DOUT_WIDTH - 1 downto 0);
	signal add, sub, mult : signed(DOUT_WIDTH - 1 downto 0);
	signal sign_temp : std_logic;

begin 
--Behavioral design goes here 
		
	add <= to_signed(to_integer(signed(DIN1)) + to_integer(signed(DIN2)), DOUT_WIDTH);
	sub <= to_signed(to_integer(signed(DIN1)) - to_integer(signed(DIN2)), DOUT_WIDTH);
	mult <= to_signed(to_integer(signed(DIN1)) * to_integer(signed(DIN2)), DOUT_WIDTH);
	
	with operation select
		result <= add when "00",  
					 sub when "01",  
					 mult when "10", 
				--  '0' when "11"; 
					 (others => '0') when others;   -- had to look this up because '0' not declared for type SIGNED                         
		
	calc: PROCESS (result)
	begin
		
		sign_temp <= result(DOUT_WIDTH - 1);
	
		if sign_temp = '1' then
			DOUT <= std_logic_vector(abs(result));
		else 
			DOUT <= std_logic_vector(result);
		
		end if;
		
	end PROCESS calc;
	sign <= sign_temp;

end architecture behavioral; 