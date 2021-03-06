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
        S_BRS,
        S_SLTRS,
        S_SLTIMM,
		S_LOAD1,
        S_LOAD2,
        S_STORE1,
        S_STORE2,
        S_LW,
        S_LB,
        S_LH,
        S_LBU,
        S_LHU,
        S_JAL,
        S_JALR
    );
    -- S_BRS : beq, bge, bgeu, blt, bltu, bne
    -- S_SLTRS : slt, sltu
    -- S_SLTIMM : slti, sltiu
	-- S_LOAD1 : lecture adresse mémoire
	-- S_LOAD2 : chargement registre
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
        cmd.ALU_op            <= UNDEFINED;
        cmd.LOGICAL_op        <= UNDEFINED;
        cmd.ALU_Y_sel         <= UNDEFINED;

        cmd.SHIFTER_op        <= UNDEFINED;
        cmd.SHIFTER_Y_sel     <= UNDEFINED;

        cmd.RF_we             <= '0';
        cmd.RF_SIZE_sel       <= UNDEFINED;
        cmd.RF_SIGN_enable    <= 'U';
        cmd.DATA_sel          <= UNDEFINED;

        cmd.PC_we             <= '0';
        cmd.PC_sel            <= UNDEFINED;

        cmd.PC_X_sel          <= UNDEFINED;
        cmd.PC_Y_sel          <= UNDEFINED;

        cmd.TO_PC_Y_sel       <= UNDEFINED;

        cmd.AD_we             <= '0';
        cmd.AD_Y_sel          <= UNDEFINED;

        cmd.IR_we             <= '0';

        cmd.ADDR_sel          <= UNDEFINED;
        cmd.mem_we            <= '0';
        cmd.mem_ce            <= '0';

        cmd.cs.CSR_we            <= CSR_None;

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
                -- IR <- mem_datain, disponible au prochain état
                cmd.IR_we <= '1';
                -- on ne fait pas l'état decode, incrémentation après coup dans l'état concerné
                --------------------------------------------------------------------------
                -- FIXME: IR n'a pas encore pris sa valeur, comme vous le notez d'ailleurs
                -- dans le commentaire juste au dessus, donc on ne peut pas tester sa valeur
                --------------------------------------------------------------------------
                -- if status.IR(6 downto 0) = "0010111" then -- code op auipc
                --     state_d <= S_AUIPC;
                -- else
                --     state_d <= S_Decode;
                -- end if;
                state_d <= S_Decode;

            when S_Decode =>
                -- On peut aussi utiliser un case, ...
                -- et ne pas le faire juste pour les branchements et auipc
                if status.IR(6 downto 0) = "0010111" then -- code op auipc
                    state_d <= S_AUIPC;
                elsif status.IR(6 downto 0) = "0110111" then -- code op lui
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
                    state_d <= S_SLTRS;
                elsif (status.IR(6 downto 0) = "0110011" and
                    status.IR(14 downto 12) = "011" and
                    status.IR(31 downto 25) = "0000000") then --code op sltu
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SLTRS;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "010") then --code op slti
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SLTIMM;
                elsif (status.IR(6 downto 0) = "0010011" and
                    status.IR(14 downto 12) = "011") then --code op sltiu
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_SLTIMM;
                elsif (status.IR(6 downto 0) = "1100011" and
                    status.IR(14 downto 12) = "000") then --code op beq
                    -- on ne peut pas le mettre dans fetch comme pour auipc
                    -- IR n'est disponible que mtn
                    state_d <= S_BRS;
                elsif (status.IR(6 downto 0) = "1100011" and
                    status.IR(14 downto 12) = "001") then --code op bne
                    -- on ne peut pas le mettre dans fetch comme pour auipc
                    -- IR n'est disponible que mtn
                    state_d <= S_BRS;
                elsif (status.IR(6 downto 0) = "1100011" and
                    status.IR(14 downto 12) = "100") then --code op blt
                    -- on ne peut pas le mettre dans fetch comme pour auipc
                    -- IR n'est disponible que mtn
                    state_d <= S_BRS;
                elsif (status.IR(6 downto 0) = "1100011" and
                    status.IR(14 downto 12) = "101") then --code op bge
                    -- on ne peut pas le mettre dans fetch comme pour auipc
                    -- IR n'est disponible que mtn
                    state_d <= S_BRS;
                elsif (status.IR(6 downto 0) = "1100011" and
                    status.IR(14 downto 12) = "110") then --code op bltu
                    -- on ne peut pas le mettre dans fetch comme pour auipc
                    -- IR n'est disponible que mtn
                    state_d <= S_BRS;
                elsif (status.IR(6 downto 0) = "1100011" and
                    status.IR(14 downto 12) = "111") then --code op bgeu
                    -- on ne peut pas le mettre dans fetch comme pour auipc
                    -- IR n'est disponible que mtn
                    state_d <= S_BRS;
                elsif status.IR(6 downto 0) = "0000011" then -- lw, lb, lbu, lhu
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_LOAD1;
                elsif status.IR(6 downto 0) = "0100011" then -- sw, sb, sh 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                    state_d <= S_STORE1;
                elsif status.IR(6 downto 0) = "1101111" then
                    state_d <= S_JAL;
                elsif status.IR(6 downto 0) = "1100111" then
                    state_d <= S_JALR;
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
            when S_BRS =>
                -- rs1 = rs2 --> pc <- pc + cst
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
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
                -- next state
                state_d <= S_Pre_Fetch;
            
            when S_JAL =>
                cmd.To_PC_Y_sel <= TO_PC_Y_immJ;
                cmd.PC_sel <= PC_from_pc;
                cmd.PC_we <= '1';
                
                cmd.PC_X_sel <= PC_X_pc;
                cmd.PC_Y_sel <= PC_Y_cst_x04;
                cmd.DATA_sel <= DATA_from_pc;
                cmd.RF_we <= '1';
                -- next state
                state_d <= S_Pre_Fetch;
            
            when S_JALR =>
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.ALU_op <= ALU_plus;
                cmd.PC_X_sel <= PC_X_pc;
                cmd.PC_Y_sel <= PC_Y_cst_x04;
                cmd.RF_we <= '1';
                -- lecture mem[pc]
                cmd.PC_sel <= PC_from_alu;
                cmd.PC_we <= '1';
                cmd.DATA_sel <= DATA_from_pc;
                -- next state
                state_d <= S_Pre_Fetch;

---------- Instructions de comparaison ----------
            when S_SLTRS =>
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_slt;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SLTIMM =>
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.RF_we <= '1';
                cmd.Data_sel <= DATA_from_slt;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

---------- Instructions de chargement à partir de la mémoire ----------
            --  At execution time two things happen: 
            -- (1) an address is calculated by adding the base register b with the offset off, 
            -- and (2) data is fetched from memory at that address.
            -- Because it takes time to copy data from memory, it takes two machine cycles 
            -- before the data is available in register $result.
            when S_LOAD1 =>
                cmd.AD_Y_sel <= AD_Y_immI;
                cmd.ad_we <= '1';
                --next state
				state_d <= S_LOAD2;

            when S_LOAD2 =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                if status.IR(14 downto 12) = "000" then
                    state_d <= S_LB;
                elsif status.IR(14 downto 12) = "001" then
                    state_d <= S_LH;
                elsif status.IR(14 downto 12) = "010" then
                    state_d <= S_LW;
                elsif status.IR(14 downto 12) = "100" then
                    state_d <= S_LBU;
                elsif status.IR(14 downto 12) = "101" then
                    state_d <= S_LHU;
                else -- on n'est jamais trop prudent
                    state_d <= S_Error;
                end if;
                    
            when S_LW =>
                --lw rd, imm(rs1)
                cmd.DATA_sel <= DATA_from_mem;
                cmd.RF_we <= '1';
                cmd.RF_SIZE_sel <= RF_SIZE_word;
                cmd.RF_SIGN_enable <= '0';
                --next state
                state_d <= S_Pre_Fetch;
            
            when S_LB =>
                cmd.DATA_sel <= DATA_from_mem;
                cmd.RF_we <= '1';
                cmd.RF_SIZE_sel <= RF_SIZE_byte;
                cmd.RF_SIGN_enable <= '1';
                --next state
                state_d <= S_Pre_Fetch;
                
            when S_LH =>
                cmd.DATA_sel <= DATA_from_mem;
                cmd.RF_we <= '1';
                cmd.RF_SIZE_sel <= RF_SIZE_half;
                cmd.RF_SIGN_enable <= '1';
                --next state
                state_d <= S_Pre_Fetch;
                
            when S_LBU =>
                cmd.DATA_sel <= DATA_from_mem;
                cmd.RF_we <= '1';
                cmd.RF_SIZE_sel <= RF_SIZE_byte;
                cmd.RF_SIGN_enable <= '0';
                --next state
                state_d <= S_Pre_Fetch;
                
            when S_LHU =>
                cmd.DATA_sel <= DATA_from_mem;
                cmd.RF_we <= '1';
                cmd.RF_SIZE_sel <= RF_SIZE_half;
                cmd.RF_SIGN_enable <= '0';
                --next state
                state_d <= S_Pre_Fetch;

---------- Instructions de sauvegarde en mémoire ----------
            when S_STORE1 =>
                cmd.AD_Y_sel <= AD_Y_immS;
                cmd.ad_we <= '1';
                --next state
                state_d <= S_STORE2;

            when S_STORE2 =>
                cmd.ADDR_sel <= ADDR_from_ad;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '1';
                if status.IR(14 downto 12) = "000" then -- sb
                    cmd.RF_SIZE_sel <= RF_SIZE_byte;
                    state_d <= S_Pre_Fetch;
                elsif status.IR(14 downto 12) = "001" then -- sh
                    cmd.RF_SIZE_sel <= RF_SIZE_half;
                    state_d <= S_Pre_Fetch;
                elsif status.IR(14 downto 12) = "010" then --sw
                    cmd.RF_SIZE_sel <= RF_SIZE_word;
                    state_d <= S_Pre_Fetch;
                else
                    state_d <= S_ERROR;
                end if;

---------- Instructions d'accès aux CSR ----------

            when others => null;
        end case;

    end process FSM_comb;

end architecture;
