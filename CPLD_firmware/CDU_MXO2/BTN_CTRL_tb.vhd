
-- VHDL Test Bench Created from source file BTN_CTRL.vhd -- Sun May 06 14:53:30 2018

--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Lattice recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "source->import"
-- menu in the ispLEVER Project Navigator to import the testbench.
-- Then edit the user defined section below, adding code to generate the 
-- stimulus for your design.
-- 3) VHDL simulations will produce errors if there are Lattice FPGA library 
-- elements in your design that require the instantiation of GSR, PUR, and
-- TSALL and they are not present in the testbench. For more information see
-- the How To section of online help.  
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT BTN_CTRL
	PORT(
		clk : IN std_logic;
		btn_col : IN std_logic_vector(7 downto 0);          
		btn_row : OUT std_logic_vector(8 downto 0);
		buttons : OUT std_logic_vector(71 downto 0)
		);
	END COMPONENT;

	SIGNAL clk :  std_logic;
	SIGNAL btn_col :  std_logic_vector(7 downto 0);
	SIGNAL btn_row :  std_logic_vector(8 downto 0);
	SIGNAL buttons :  std_logic_vector(71 downto 0);

BEGIN

-- Please check and add your generic clause manually
	uut: BTN_CTRL PORT MAP(
		clk => clk,
		btn_col => btn_col,
		btn_row => btn_row,
		buttons => buttons
	);

	clock : PROCESS
	BEGIN
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		wait for 1 ns;
	END PROCESS;

-- *** Test Bench - User Defined Section ***
	tb : PROCESS
	BEGIN
		btn_col <= X"01";
		wait for 1024 ns;
		btn_col <= X"AA";
		wait for 2048 ns;
		btn_col <= X"20";
		wait for 2048 ns;
		btn_col <= X"70";
		wait for 2048 ns;
		btn_col <= X"27";
	
		wait;
	END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
