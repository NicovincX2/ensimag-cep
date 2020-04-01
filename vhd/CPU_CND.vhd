library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CND is
    generic (
        mutant      : integer := 0
    );
    port (
        rs1         : in w32;
        alu_y       : in w32;
        IR          : in w32;
        slt         : out std_logic;
        jcond       : out std_logic
    );
end entity;

architecture RTL of CPU_CND is

    signal extension_signe, s_std_logic, z_std_logic : std_logic;
    signal rs1_eds, alu_y_eds, res : unsigned(32 downto 0);

begin

    -- To extend an unsigned value, just stick a zero on the front: ('0' & a)
    -- To extend a signed value, you need to copy the existing sign bit: (b(N-1) & b)
    -- (where N is the length of B, so N = 8 in this case).
    -- The resulting code would be: result <= ('0' & a) + (b(7) & b);

    extension_signe <= (not(IR(12)) and not(IR(6))) or (IR(6) and not(IR(13)));

    rs1_eds <= rs1(31) & rs1 when extension_signe = '1' else '0' & rs1;
    alu_y_eds <= alu_y(31) & alu_y when extension_signe = '1' else '0' & alu_y;
    res <= rs1_eds - alu_y_eds;

    z_std_logic <= '1' when (nand res) else '0';
    s_std_logic <= '1' when (res(32) = '1') else '0';
 
    slt <= s_std_logic;
    jcond <= (not(IR(14)) and (z_std_logic xor IR(12))) or (IR(14) and (s_std_logic xor IR(12)));

end architecture;
