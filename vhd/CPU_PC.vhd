library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PKG.all;


entity CPU_PC is
    generic(
        mutant: integer := 0
    );
    Port (
        -- Clock/Reset
        clk    : in  std_logic ;
        rst    : in  std_logic ;

        -- Interface PC to PO
        cmd    : out PO_cmd ;
        status : in  PO_status
    );
end entity;

architecture RTL of CPU_PC is
    -- Rajouter ici les états du graphe de la PC
    type State_type is (
        S_Error,
        S_Init,
        S_Pre_Fetch,
        S_Fetch,
        S_Decode,
        S_LUI,
        S_ADDI,
        S_ADD,
        S_SLL,
        S_SRL,
        S_SRA,
        S_SLLI,
        S_SRLI,
        S_SRAI,
        S_AUIPC,
        S_AND,
        S_OR,
        S_XOR,
        S_ANDI,
        S_ORI,
        S_XORI,
        S_SUB,
        S_BEQ,
        S_SLT
    );

    signal state_d, state_q : State_type;


begin

    FSM_synchrone : process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                state_q <= S_Init;
            else
                state_q <= state_d;
            end if;
        end if;
    end process FSM_synchrone;

    FSM_comb : process (state_q, status)
    begin

        -- Valeurs par défaut de cmd à définir selon les préférences de chacun
        cmd.rst               <= 'U';
        cmd.ALU_op            <= UNDEFINED;
        cmd.LOGICAL_op        <= UNDEFINED;
        cmd.ALU_Y_sel         <= UNDEFINED;

        cmd.SHIFTER_op        <= UNDEFINED;
        cmd.SHIFTER_Y_sel     <= UNDEFINED;

        cmd.RF_we             <= 'U';
        cmd.RF_SIZE_sel       <= UNDEFINED;
        cmd.RF_SIGN_enable    <= 'U';
        cmd.DATA_sel          <= UNDEFINED;

        cmd.PC_we             <= 'U';
        cmd.PC_sel            <= UNDEFINED;

        cmd.PC_X_sel          <= UNDEFINED;
        cmd.PC_Y_sel          <= UNDEFINED;

        cmd.TO_PC_Y_sel       <= UNDEFINED;

        cmd.AD_we             <= 'U';
        cmd.AD_Y_sel          <= UNDEFINED;

        cmd.IR_we             <= 'U';

        cmd.ADDR_sel          <= UNDEFINED;
        cmd.mem_we            <= 'U';
        cmd.mem_ce            <= 'U';

        cmd.cs.CSR_we            <= UNDEFINED;

        cmd.cs.TO_CSR_sel        <= UNDEFINED;
        cmd.cs.CSR_sel           <= UNDEFINED;
        cmd.cs.MEPC_sel          <= UNDEFINED;

        cmd.cs.MSTATUS_mie_set   <= 'U';
        cmd.cs.MSTATUS_mie_reset <= 'U';

        cmd.cs.CSR_WRITE_mode    <= UNDEFINED;

        state_d <= state_q;

        case state_q is
            when S_Error =>
                -- Etat transitoire en cas d'instruction non reconnue
                -- Aucune action
                state_d <= S_Init;

            when S_Init =>
                -- PC <- RESET_VECTOR
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_rstvec;
                state_d <= S_Pre_Fetch;

            when S_Pre_Fetch =>
                -- mem[PC]
                cmd.mem_we   <= '0';
                cmd.mem_ce   <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                state_d      <= S_Fetch;

            when S_Fetch =>
                -- IR <- mem_datain
                cmd.IR_we <= '1';
                -- on ne fait pas l'état decode, incrémentation après coup dans l'état concerné
                if status.IR(6 downto 0) = "0010111" then -- code op auipc
                    state_d <= S_AUIPC;
                elsif (status.IR(6 downto 0) = "1100011" and
                    status.IR(14 downto 12) = "000") then --code op beq
                    state_d <= S_BEQ;
                else
                    state_d <= S_Decode;
                end if;

            when S_Decode =>
                -- On peut aussi utiliser un case, ...
                -- et ne pas le faire juste pour les branchements et auipc
                if status.IR(6 downto 0) = "0110111" then -- code op lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_LUI;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "000") then -- code op addi
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_ADDI;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "001" and
                    status.IR(31 downto 25) = "0000000") then -- code op sll
                    cmd.TO_PC_Y_sel <= TO_Pc_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SLL;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "101" and
                    status.IR(31 downto 25) = "0000000") then -- code op srl
                    cmd.TO_PC_Y_sel <= TO_Pc_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SRL;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "101" and
                    status.IR(31 downto 25) = "0100000") then -- code op sra
                    cmd.TO_PC_Y_sel <= TO_Pc_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SRA;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "001" and
                    status.IR(31 downto 25) = "0000000") then -- code op slli
                    cmd.TO_PC_Y_sel <= TO_Pc_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SLLI;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "101" and
                    status.IR(31 downto 25) = "0000000") then -- code op srli
                    cmd.TO_PC_Y_sel <= TO_Pc_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SRLI;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "101" and
                    status.IR(31 downto 25) = "0100000") then -- code op srai
                    cmd.TO_PC_Y_sel <= TO_Pc_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SRAI;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "000" and
                    status.IR(31 downto 25) = "0000000") then -- code op add
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_ADD;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "000" and
                    status.IR(31 downto 25) = "0100000") then -- code op sub
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SUB;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "111" and
                    status.IR(31 downto 25) = "0000000") then -- code op and
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_AND;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "110" and
                    status.IR(31 downto 25) = "0000000") then -- code op or
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_OR;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "100" and
                    status.IR(31 downto 25) = "0000000") then -- code op xor
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_XOR;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "111") then -- code op andi
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_ANDI;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "110") then -- code op ori
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_ORI;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "100") then -- code op xori
                    -- on incrémente PC comme avec lui
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_XORI;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "010" and
                    status.IR(31 downto 25) = "0000000") then --code op slt
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SLT;
                else
                    state_d <= S_ERROR; -- pour détecter les ratés de décodage
                end if;

                -- Décodage effectif des instructions,
                -- à compléter par vos soins

---------- Instructions avec immediat de type U ----------

            when S_LUI =>
                -- loads the sign-extended 20-bit immediate,imm, into register rd
                -- valide seulement lorsque rd!=x0
                -- li expands into addi rd, x0, imm[21:0].
                -- rd <- ImmU + 0
                cmd.PC_X_sel <= PC_X_cst_x00;
                cmd.PC_Y_sel <= PC_Y_immU;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_pc;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_AUIPC =>
                -- rd <- imm + pc
                cmd.PC_X_sel <= PC_X_pc;
                cmd.PC_Y_sel <= PC_Y_immU;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_pc;
                -- incrémentation de PC
                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                cmd.PC_sel <= PC_from_pc;
                cmd.PC_we <= '1';
                -- lecture mem[PC], fait dans Pre_Fetch
                -- cmd.ADDR_sel <= ADDR_from_pc;
                -- cmd.mem_ce <= '1';
                -- cmd.mem_we <= '0';
                -- next state
                state_d <= S_Pre_Fetch;

            when S_ANDI =>
                -- rd <- imm and rs1
                cmd.LOGICAL_op <= LOGICAL_and;
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_logical;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_ORI =>
                -- rd <- imm or rs1
                cmd.LOGICAL_op <= LOGICAL_or;
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_logical;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_XORI =>
                -- rd <- imm or rs1
                cmd.LOGICAL_op <= LOGICAL_xor;
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_logical;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SLLI =>
                cmd.SHIFTER_op <= SHIFT_ll;
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_shifter;
                --mise à jour PC
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                --prochain état
                state_d <= S_Fetch;

            when S_SRLI =>
                cmd.SHIFTER_op <= SHIFT_rl;
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_shifter;
                --mise à jour PC
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                --prochain état
                state_d <= S_Fetch;

            when S_SRAI =>
                cmd.SHIFTER_op <= SHIFT_ra;
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_shifter;
                --mise à jour PC
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                --prochain état
                state_d <= S_Fetch;

---------- Instructions arithmétiques et logiques ----------

            when S_ADD =>
                -- rd <- rs1 + rs2
                cmd.ALU_op <= ALU_plus;
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_alu;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_ADDI =>
                -- chaine de 20 bits de long en dupliquant le bit 31 de IR
                -- concaténé avec les bits 31 à 20 de IR
                -- ie. valeur 32 bits avec extension de signe de l'immédiat
                -- en complément à 2 de 12 bits IR
                cmd.ALU_op <= ALU_plus;
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_alu;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SUB =>
                -- rd <- rs1 + rs2
                cmd.ALU_op <= ALU_minus;
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_alu;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SLL =>
                cmd.SHIFTER_op <= SHIFT_ll;
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_shifter;
                --mise à jour PC
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                --prochain état
                state_d <= S_Fetch;

            when S_SRL =>
                cmd.SHIFTER_op <= SHIFT_rl;
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_shifter;
                --mise à jour PC
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                --prochain état
                state_d <= S_Fetch;

            when S_SRA =>
                cmd.SHIFTER_op <= SHIFT_ra;
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_shifter;
                --mise à jour PC
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                --prochain état
                state_d <= S_Fetch;

            when S_AND =>
                -- rd <- rs1 and rs2
                cmd.LOGICAL_op <= LOGICAL_and;
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_logical;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_OR =>
                -- rd <- rs1 or rs2
                cmd.LOGICAL_op <= LOGICAL_or;
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_logical;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_XOR =>
                -- rd <- rs1 or rs2
                cmd.LOGICAL_op <= LOGICAL_xor;
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_logical;
                -- lecture mem[PC] comme avec lui
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

---------- Instructions de saut ----------
            when S_BEQ =>
                -- rs1 = rs2 --> pc <- pc + cst
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                -- cmd.RF_we <= '1';
                -- cmd.Data_sel <= DATA_from_slt;
                -- on suit le modèle de auipc
                -- incrémentation de PC
                if status.JCOND then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                -- lecture mem[PC], fait dans Pre_Fetch
                -- cmd.ADDR_sel <= ADDR_from_pc;
                -- cmd.mem_ce <= '1';
                -- cmd.mem_we <= '0';
                -- next state
                state_d <= S_Pre_Fetch;

---------- Instructions de comparaison ----------
            when S_SLT =>
                -- rs1 = rs2 --> pc <- pc + cst
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_slt;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;
                
---------- Instructions de chargement à partir de la mémoire ----------

---------- Instructions de sauvegarde en mémoire ----------

---------- Instructions d'accès aux CSR ----------

            when others => null;
        end case;

    end process FSM_comb;

end architecture;
