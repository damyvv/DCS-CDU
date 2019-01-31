--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:01:21 10/26/2017
-- Design Name:   
-- Module Name:   D:/Xilinx/Projects/CDU/SPI_TB.vhd
-- Project Name:  CDU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SPI_CTRL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY SPI_TB IS
END SPI_TB;
 
ARCHITECTURE behavior OF SPI_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SPI_CTRL
    PORT(
         spi_clk : IN  std_logic;
         spi_mosi : IN  std_logic;
         spi_ce : IN  std_logic;
         clk : IN  std_logic;
         char_x : OUT  std_logic_vector(7 downto 0);
         char_y : OUT  std_logic_vector(7 downto 0);
         char_sel : OUT  std_logic_vector(7 downto 0);
         we : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal spi_clk : std_logic := '0';
   signal spi_mosi : std_logic := '0';
   signal spi_ce : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal char_x : std_logic_vector(7 downto 0);
   signal char_y : std_logic_vector(7 downto 0);
   signal char_sel : std_logic_vector(7 downto 0);
   signal we : std_logic;

   -- Clock period definitions
   constant spi_clk_period : time := 32 ns;
   constant clk_period : time := 10 ns;
 
	constant x : integer := 2;
	constant y : integer := 2;
	constant char : integer := 1;
	constant data : std_logic_vector(23 downto 0) := std_logic_vector(to_unsigned(y, 8)) & std_logic_vector(to_unsigned(x, 8)) & std_logic_vector(to_unsigned(char, 8));
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SPI_CTRL PORT MAP (
          spi_clk => spi_clk,
          spi_mosi => spi_mosi,
          spi_ce => spi_ce,
          clk => clk,
          char_x => char_x,
          char_y => char_y,
          char_sel => char_sel,
          we => we
        );
 
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		spi_ce <= '1';
		spi_clk <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		spi_ce <= '0';
		wait for spi_clk_period / 2;
		
		for I in 23 downto 0 loop
			spi_mosi <= data(I);
			wait for spi_clk_period / 2;
			spi_clk <= '1';
			wait for spi_clk_period / 2;
			spi_clk <= '0';
		end loop;
		
		wait for spi_clk_period / 2;
		spi_ce <= '1';

      wait;
   end process;

END;
