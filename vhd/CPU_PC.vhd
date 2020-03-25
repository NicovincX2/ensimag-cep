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
        S_SUB
    );

    signal state_d, state_q : State_type;
    signal first, last : std_logic_vector(0 to 6);
    signal mid: std_logic_vector(0 to 2);


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
                -- on ne fait pas l'état decode, incrémentation apèrs coup dans l'état concerné
                -- variables des bits de code op
                last <= status.IR(6 downto 0);
                if last = "0010111" then -- code op auipc
                    -- on n'incrémente pas PC
                    state_d <= S_AUIPC;
                else
                    state_d <= S_Decode;
                end if;

            when S_Decode =>
                -- on ne fait pas cet état juste pour les branchements et auipc
                -- variables des bits de code op
                last <= status.IR(6 downto 0);
                mid <= status.IR(14 downto 12);
                first <= status.IR(31 downto 25);
                -- on incrémente PC
                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                cmd.PC_sel <= PC_from_pc;
                cmd.PC_we <= '1';
                case last is
                    when "0110111" =>
                        state_d <= S_LUI;
                    when "0010011" =>
                        case mid is
                            when "000" =>
                                state_d <= S_ADDI;
                            when "001" =>
                                if first = "0000000" then
                                    state_d <= S_SLLI;
                                end if;
                            when "100" =>
                                state_d <= S_XORI;
                            when "101" =>
                                if first = "0000000" then
                                    state_d <= S_SRLI;
                                elsif first = "0100000" then
                                    state_d <= S_SRAI;
                                end if;
                            when "110" =>
                                state_d <= S_ORI;
                            when "111" =>
                                state_d <= S_ANDI;
                    when "0110011" =>
                        case mid is
                            when "000" =>
                                if first = "0000000" then
                                    state_d <= S_ADD;
                                elsif first = "0100000" then
                                    state_d <= S_SUB;
                                end if;
                            when "001" =>
                                if first = "0000000" then
                                    state_d <= S_SLL;
                                end if;
                            when "100" =>
                                if first = "0000000" then
                                    state_d <= S_XOR;
                                end if;
                            when "101" =>
                                if first = "0000000" then
                                    state_d <= S_SRL;
                                elsif first = "0100000" then
                                    state_d <= S_SRA;
                                end if;
                            when "110" =>
                                if first = "0000000" then
                                    state_d <= S_OR;
                                end if;
                            when "111" =>
                                if first = "0000000" then
                                    state_d <= S_AND;
                                end if;
                        end case;
                end case;
                -- on n'a pas changé d'état
                if state_q = S_Decode then
                    state_d <= S_ERROR;
                -- if last = "0110111" then -- code op lui
                --     state_d <= S_LUI;
                -- elsif (last = "0010011" and
                --     mid = "000") then -- code op addi
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_ADDI;
                -- elsif (last = "0110011" and
                --     mid = "001" and
                --     first = "0000000") then -- code op sll
                --     state_d <= S_SLL;
                -- elsif (last = "0110011" and
                --     mid = "101" and
                --     first = "0000000") then -- code op srl
                --     state_d <= S_SRL;
                -- elsif (last = "0110011" and
                --     mid = "101" and
                --     first = "0100000") then -- code op sra
                --     state_d <= S_SRA;
                -- elsif (last = "0010011" and
                --     mid = "001" and
                --     first = "0000000") then -- code op slli
                --     state_d <= S_SLLI;
                -- elsif (last = "0010011" and
                --     mid = "101" and
                --     first = "0000000") then -- code op srli
                --     state_d <= S_SRLI;
                -- elsif (last = "0010011" and
                --     mid = "101" and
                --     first = "0100000") then -- code op srai
                --     state_d <= S_SRAI;
                -- elsif (last = "0110011" and
                --     mid = "000" and
                --     first = "0000000") then -- code op add
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_ADD;
                -- elsif (last = "0110011" and
                --     mid = "000" and
                --     first = "0100000") then -- code op sub
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_SUB;
                -- elsif (last = "0110011" and
                --     mid = "111" and
                --     first = "0000000") then -- code op and
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_AND;
                -- elsif (last = "0110011" and
                --     mid = "110" and
                --     first = "0000000") then -- code op or
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_OR;
                -- elsif (last = "0110011" and
                --     mid = "100" and
                --     first = "0000000") then -- code op xor
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_XOR;
                -- elsif (last = "0010011" and
                --     mid = "111") then -- code op andi
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_ANDI;
                -- elsif (last = "0010011" and
                --     mid = "110") then -- code op ori
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_ORI;
                -- elsif (last = "0010011" and
                --     mid = "100") then -- code op xori
                --     -- on incrémente PC comme avec lui
                --     state_d <= S_XORI;
                -- else
                --     state_d <= S_ERROR; -- pour détecter les ratés de décodage
                -- end if;

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
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
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

---------- Instructions de chargement à partir de la mémoire ----------

---------- Instructions de sauvegarde en mémoire ----------

---------- Instructions d'accès aux CSR ----------

            when others => null;
        end case;

    end process FSM_comb;

end architecture;
