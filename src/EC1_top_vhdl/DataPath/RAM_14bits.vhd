library ieee;
use ieee.std_logic_1164.all;

package ram_pkg is
    function clogb2 (depth: in natural) return integer;
end ram_pkg;

package body ram_pkg is

function clogb2( depth : natural) return integer is
variable temp    : integer := depth;
variable ret_val : integer := 0;
begin
    while temp > 1 loop
        ret_val := ret_val + 1;
        temp    := temp / 2;
    end loop;
    return ret_val;
end function;

end package body ram_pkg;

library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ram_pkg.all;
USE std.textio.all;

entity xilinx_single_port_ram_no_change is
generic (
    RAM_WIDTH : integer := 14;                      -- Specify RAM data width
    RAM_DEPTH : integer := 292;                     -- Specify RAM depth (number of entries)
    INIT_FILE : string := "RAM_INIT.dat"            -- Specify name/location of RAM initialization file if using one (leave blank if not)
    );

port (
        addra : in std_logic_vector((clogb2(RAM_DEPTH)-1) downto 0);     -- Address bus, width determined from RAM_DEPTH
        dina  : in std_logic_vector(RAM_WIDTH-1 downto 0);		  -- RAM input data
        clka  : in std_logic;                       			  -- Clock
        wea   : in std_logic;                       			  -- Write enable
        douta : out std_logic_vector(RAM_WIDTH-1 downto 0)   			  -- RAM output data
    );

end xilinx_single_port_ram_no_change;

architecture rtl of xilinx_single_port_ram_no_change is

constant C_RAM_WIDTH : integer := RAM_WIDTH;
constant C_RAM_DEPTH : integer := RAM_DEPTH;
constant C_INIT_FILE : string := INIT_FILE;

signal douta_reg : std_logic_vector(C_RAM_WIDTH-1 downto 0) := (others => '0');
type ram_type is array (C_RAM_DEPTH-1 downto 0) of std_logic_vector (C_RAM_WIDTH-1 downto 0);          -- 2D Array Declaration for RAM signal
signal ram_data : std_logic_vector(C_RAM_WIDTH-1 downto 0) ;

-- The folowing code either initializes the memory values to a specified file or to all zeros to match hardware

function initramfromfile (ramfilename : in string) return ram_type is
file ramfile	: text is in ramfilename;
variable ramfileline : line;
variable ram_name	: ram_type;
variable bitvec : bit_vector(C_RAM_WIDTH-1 downto 0);
begin
    for i in ram_type'range loop
        readline (ramfile, ramfileline);
        read (ramfileline, bitvec);
        ram_name(i) := to_stdlogicvector(bitvec);
    end loop;
    return ram_name;
end function;

function init_from_file_or_zeroes(ramfile : string) return ram_type is
begin
    if ramfile = "RAM_INIT.dat" then
        return InitRamFromFile("RAM_INIT.dat") ;
    else
        return (others => (others => '0'));
    end if;
end;
-- Following code defines RAM

signal ram_name : ram_type := init_from_file_or_zeroes(C_INIT_FILE);
begin
process(clka)
begin
    if(clka'event and clka = '1') then
            if(wea = '1') then
                ram_name(to_integer(unsigned(addra))) <= dina;
            else
                ram_data <= ram_name(to_integer(unsigned(addra)));
            end if;
    end if;
end process;

end rtl;


						
						