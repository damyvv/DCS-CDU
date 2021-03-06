library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity CHAR_ROM is
	port(
		char_sel : in std_logic_vector(6 downto 0);
		l_sel : in std_logic_vector(2 downto 0);
		data : out std_logic_vector(4 downto 0)
	);
end;

architecture behavior of CHAR_ROM is
type char_type is array(0 to 6) of std_logic_vector(4 downto 0);
type data_type is array(0 to 127) of char_type;
signal rom_data : data_type := (
	-- Space
	(	('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- 0
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '1', '1'),
		('1', '0', '1', '0', '1'),
		('1', '1', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- 1
	(	('0', '0', '1', '0', '0'),
		('0', '1', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '1', '1', '0')),
	-- 2
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '1')),
	-- 3
	(	('1', '1', '1', '1', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '1', '0'),
		('0', '0', '1', '1', '0'),
		('0', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- 4
	(	('0', '0', '0', '1', '0'),
		('0', '0', '1', '1', '0'),
		('0', '1', '0', '1', '0'),
		('1', '0', '0', '1', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '0', '1', '0'),
		('0', '0', '0', '1', '0')),
	-- 5
	(	('1', '1', '1', '1', '1'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '0'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- 6
	(	('0', '0', '1', '1', '1'),
		('0', '1', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- 7
	(	('1', '1', '1', '1', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0')),
	-- 8
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- 9
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('1', '1', '1', '1', '0')),
	-- A
	(	('0', '0', '1', '0', '0'),
		('0', '1', '0', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '1', '1', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1')),
	-- B
	(	('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '1', '1', '0')),
	-- C
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- D
	(	('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '1', '1', '0')),
	-- E
	(	('1', '1', '1', '1', '1'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '1')),
	-- F
	(	('1', '1', '1', '1', '1'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0')),
	-- G
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '1', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '1')),
	-- H
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '1', '1', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1')),
	-- I
	(	('0', '1', '1', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '1', '1', '0')),
	-- J
	(	('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- K
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '1', '0'),
		('1', '0', '1', '0', '0'),
		('1', '1', '0', '0', '0'),
		('1', '0', '1', '0', '0'),
		('1', '0', '0', '1', '0'),
		('1', '0', '0', '0', '1')),
	-- L
	(	('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '1')),
	-- M
	(	('1', '0', '0', '0', '1'),
		('1', '1', '0', '1', '1'),
		('1', '0', '1', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1')),
	-- N
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '0', '0', '1'),
		('1', '0', '1', '0', '1'),
		('1', '0', '0', '1', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1')),
	-- O
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- P
	(	('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0')),
	-- Q
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0'),
		('0', '0', '0', '0', '1')),
	-- R
	(	('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '1', '1', '0'),
		('1', '0', '1', '0', '0'),
		('1', '0', '0', '1', '0'),
		('1', '0', '0', '0', '1')),
	-- S
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '0'),
		('0', '1', '1', '1', '0'),
		('0', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- T
	(	('1', '1', '1', '1', '1'),
		('1', '0', '1', '0', '1'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0')),
	-- U
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0')),
	-- V
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '0', '1', '0'),
		('0', '1', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0')),
	-- W
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '1', '0', '1'),
		('1', '0', '1', '0', '1'),
		('1', '0', '1', '0', '1'),
		('0', '1', '0', '1', '0')),
	-- X
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1')),
	-- Y
	(	('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0')),
	-- Z
	(	('1', '1', '1', '1', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '1')),
	-- -
	(	('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- .
	(	('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0')),
	-- /
	(	('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- (
	(	('0', '0', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '0', '0'),
		('0', '1', '0', '0', '0'),
		('0', '1', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '1', '0')),
	-- )
	(	('0', '1', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '1', '0'),
		('0', '0', '0', '1', '0'),
		('0', '0', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '0', '0')),
	-- *
	(	('0', '0', '0', '0', '0'),
		('0', '1', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '1', '0'),
		('0', '0', '0', '0', '0')),
	-- �
	(	('0', '1', '1', '1', '0'),
		('0', '1', '0', '1', '0'),
		('0', '1', '1', '1', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- :
	(	('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- =
	(	('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '0', '0', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '0', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- vertical double arrow
	(	('0', '0', '1', '0', '0'),
		('0', '1', '1', '1', '0'),
		('1', '0', '1', '0', '1'),
		('0', '0', '1', '0', '0'),
		('1', '0', '1', '0', '1'),
		('0', '1', '1', '1', '0'),
		('0', '0', '1', '0', '0')),
	-- [
	(	('1', '1', '1', '1', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '0', '0', '0', '0'),
		('1', '1', '1', '1', '0')),
	-- ]
	(	('0', '1', '1', '1', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '0', '0', '0', '1'),
		('0', '1', '1', '1', '1')),
	-- []
	(	('1', '1', '0', '1', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '0', '0', '0', '1'),
		('1', '1', '0', '1', '1')),
	-- Cursor
	(	('1', '1', '1', '1', '1'),
		('1', '1', '1', '1', '1'),
		('1', '1', '1', '1', '1'),
		('1', '1', '1', '1', '1'),
		('1', '1', '1', '1', '1'),
		('1', '1', '1', '1', '1'),
		('1', '1', '1', '1', '1')),
	-- ->
	(	('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '1', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- <-
	(	('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '1', '0', '0', '0'),
		('1', '1', '1', '1', '1'),
		('0', '1', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- dotted circle
	(	('0', '0', '0', '0', '0'),
		('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('1', '0', '1', '0', '1'),
		('1', '0', '0', '0', '1'),
		('0', '1', '1', '1', '0'),
		('0', '0', '0', '0', '0')),
	-- ?
	(	('0', '1', '1', '1', '0'),
		('1', '0', '0', '0', '1'),
		('0', '0', '0', '1', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0')),
	-- +/- plus-minus
	(	('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('1', '1', '1', '1', '1')),
	-- +
	(	('0', '0', '0', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('1', '1', '1', '1', '1'),
		('0', '0', '1', '0', '0'),
		('0', '0', '1', '0', '0'),
		('0', '0', '0', '0', '0')),
	-- unknown
	others => (
		('1', '0', '1', '0', '1'),
		('0', '1', '0', '1', '0'),
		('1', '0', '1', '0', '1'),
		('0', '1', '0', '1', '0'),
		('1', '0', '1', '0', '1'),
		('0', '1', '0', '1', '0'),
		('1', '0', '1', '0', '1')
	));
begin

process(char_sel, l_sel)
variable char : char_type;
begin
	char := rom_data(to_integer(unsigned(char_sel)));
	data <= char(to_integer(unsigned(l_sel)));
end process;

end;