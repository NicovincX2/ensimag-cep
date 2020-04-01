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
    signal z, s : boolean;
    signal X_eds, Y_eds, res : unsigned(32 downto 0);

begin

    -- To extend an unsigned value, just stick a zero on the front: ('0' & a)
    -- To extend a signed value, you need to copy the existing sign bit: (b(N-1) & b)
    -- (where N is the length of B, so N = 8 in this case).
    -- The resulting code would be: result <= ('0' & a) + (b(7) & b);

    extension_signe <= (not(IR(12)) and not(IR(6))) or (IR(6) and not(IR(13)));
    -- X_eds <= rs1(31) & rs1 when extension_signe = '1' else '0' & rs1;
    -- Y_eds <= alu_y(31) & alu_y when extension_signe = '1' else '0' & alu_y;
    -- res <= X_eds - Y_eds;
    res <= (rs1(31) & rs1) - (alu_y(31) & alu_y)
    z <= (res = 0);
    s <= (extension_signe = '1' and res(32) = '1') or (extension_signe = '0' and (rs1 < alu_y));
    z_std_logic <= '1' when z else '0';
    s_std_logic <= '1' when s else '0';
    --slt <= '1' when s else '0';
    slt <= s_std_logic;
    jcond <= (not(IR(14)) and (IR(12) xor z_std_logic)) or ((s_std_logic xor IR(12)) and IR(14));

end architecture;
