library IEEE; 
use IEEE.std_logic_1164.all; 
use WORK.decoder.all; 
use WORK.calc_const.all;

entity display_calc is 
    port( 
        DIN1           : in std_logic_vector(DIN1_WIDTH - 1 downto 0);
        DIN2           : in std_logic_vector(DIN2_WIDTH - 1 downto 0);
        operation      : in std_logic_vector(OP_WIDTH - 1 downto 0);
        output_display : out std_logic_vector(DOUT_WIDTH / 4 * 7 - 1 downto 0)
    ); 
end entity display_calc; 

architecture structural of display_calc is 
    constant decoder_number : integer := DOUT_WIDTH / 4;

    signal tDIN1      : std_logic_vector(DIN1_WIDTH - 1 downto 0);
    signal tDIN2      : std_logic_vector(DIN2_WIDTH - 1 downto 0);
    signal toperation : std_logic_vector(OP_WIDTH - 1 downto 0);
    signal tDOUT      : std_logic_vector(DOUT_WIDTH - 1 downto 0);
    signal tsign      : std_logic;

    component calculator is
        port(
            DIN1      : in std_logic_vector(DIN1_WIDTH - 1 downto 0);
            DIN2      : in std_logic_vector(DIN2_WIDTH - 1 downto 0);
            operation : in std_logic_vector(OP_WIDTH - 1 downto 0);
            DOUT      : out std_logic_vector(DOUT_WIDTH - 1 downto 0);
            sign      : out std_logic
        );
    end component calculator;

    component leddecoder is
        port(
            data_in      : in std_logic_vector(3 downto 0);
            segments_out : out std_logic_vector(6 downto 0)
        );
    end component leddecoder;

begin
    -- Connect entity inputs to internal signals
    tDIN1 <= DIN1;
    tDIN2 <= DIN2;
    toperation <= operation;

    dut : calculator
        port map(
            DIN1 => tDIN1,
            DIN2 => tDIN2,
            operation => toperation,
            DOUT => tDOUT,
            sign => tsign
        );

    -- Loop over DOUT in groups of 4 bits using a generate statement
    g1: for i in 0 to decoder_number - 1 generate
        nth_display: leddecoder
            port map(
                data_in => tDOUT((i + 1) * 4 - 1 downto i * 4),
                segments_out => output_display((i + 1) * 7 - 1 downto i * 7)
            );
    end generate g1;

end architecture structural;