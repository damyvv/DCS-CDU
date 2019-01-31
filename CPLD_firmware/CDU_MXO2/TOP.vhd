----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:22:28 10/21/2017 
-- Design Name: 
-- Module Name:    TOP - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
    Port (
		spi_clk : in  STD_LOGIC;
		spi_mosi : in  STD_LOGIC;
		spi_miso : out STD_LOGIC;
		spi_ce : in  STD_LOGIC;
		
		dot_clk : out std_logic;
		nde : out std_logic;
		color : out std_logic_vector(7 downto 0);
		
		led : out std_logic_vector(3 downto 0);
		
		btn_col : in STD_LOGIC_VECTOR(7 downto 0);
		btn_row : out STD_LOGIC_VECTOR(8 downto 0);
		
		clk_50 : in std_logic
	 );
end TOP;

architecture Behavioral of TOP is
--component OSCC
	--Port (OSC:OUT STD_LOGIC);
--end component;

signal x_pos : std_logic_vector(8 downto 0);
signal y_pos : std_logic_vector(7 downto 0);
signal x_char : std_logic_vector(3 downto 0);
signal y_char : std_logic_vector(3 downto 0);
signal char_box_ce : std_logic;

signal char_sel : std_logic_vector(6 downto 0);
signal line_sel : std_logic_vector(2 downto 0);
signal char_rom_data : std_logic_vector(4 downto 0);

signal num_x_char : std_logic_vector(4 downto 0);
signal num_y_char : std_logic_vector(3 downto 0);

signal vram_addr : std_logic_vector(8 downto 0);
signal char_write_addr : std_logic_vector(8 downto 0);
signal char_write_enable : std_logic;

signal buttons : std_logic_vector(71 downto 0);

signal spi_data : std_logic_vector(23 downto 0);
signal clk : std_logic;
signal clk_div : unsigned(1 downto 0) := (others => '0');
signal ce : std_logic;

alias spi_char_y : std_logic_vector(7 downto 0)
		is spi_data(23 downto 16);
alias spi_char_x : std_logic_vector(7 downto 0)
		is spi_data(15 downto 8);
alias char_write_sel : std_logic_vector(7 downto 0)
		is spi_data(7 downto 0);

begin

led <= not buttons(3 downto 0);

clk <= clk_div(1);

CLK_DIV_P : process (clk_50)
begin
if (clk_50'event and clk_50 = '1') then
	clk_div <= clk_div + 1;
end if;
end process;

LCD_CTRL : entity work.LCD_CTRL port map(
		clk => clk,
		dot_clk => dot_clk,
		nde => nde,
		x_pos => x_pos,
		y_pos => y_pos
	);
	
CHAR_BOX : entity work.CHAR_BOX port map(
		x_pos => x_pos,
		y_pos => y_pos,
		pix_x_char => x_char,
		pix_y_char => y_char,
		num_x_char => num_x_char,
		num_y_char => num_y_char,
		ce => char_box_ce
	);

CHAR_ROM : entity work.CHAR_ROM port map(
		char_sel => char_sel,
		l_sel => line_sel,
		data => char_rom_data
	);
	
VRAM : entity work.VRAM port map(
		addr_a => char_write_addr,
		data_a => char_write_sel(6 downto 0),
		we_a => char_write_enable,
		addr_b => vram_addr,
		clk => clk,
		q_b => char_sel
	);
	
BTN_CTRL : entity work.BTN_CTRL port map(
		clk => clk,
		btn_col => btn_col,
		btn_row => btn_row,
		buttons => buttons
	);
	
SPI : entity work.SPI_CTRL port map(
		spi_clk => spi_clk,
		spi_mosi => spi_mosi,
		spi_miso => spi_miso,
		spi_ce => spi_ce,
		clk => clk,
		we => char_write_enable,
		in_data => spi_data,
		out_data => buttons
	);

char_write_addr <= spi_char_y(3 downto 0) & spi_char_x(4 downto 0);

line_sel <= y_char(3 downto 1);
vram_addr <= num_y_char & num_x_char;

ce <= char_box_ce and char_rom_data(4 - to_integer(unsigned(x_char(3 downto 1))));

process (ce)
begin
if (ce = '1')
then
	color <= (others => '1');
else
	color <= (others => '0');
end if;
end process;
end Behavioral;

