# TAG = addi
    .text

    # addi rd, rs1, imm
    # le registre x0 vaut toujours 0
    # addi zero, zero, 0    # no operation # 00000000
    addi x31, x0, 0     # copy register
    addi x31, zero, -1    # li x31, 0xFFFF
	addi x31, x0, -2048   # li x31, -2048
	addi x31, zero, 2047    # li x31, 0x7F
	# addi x31, zero, 2048    # li x31, 0x800 fail car range -2048 à 2047

    # Groupement 1
    li x1, 0x00000000
    addi x31, x1, 0xfffff800

    li x1, 0x80000000
    addi x31, x1, 0x000

    li x1, 0x80000000
    addi x31, x1, 0xfffff800

    # Groupement 2
    li x1, 0x00000000
    addi x31, x1, 0x7ff

    li x1, 0x7fffffff
    addi x31, x1, 0x000

    li x1, 0x7fffffff
    addi x31, x1, 0x7ff

    # Groupement 3
    li x1, 0x80000000
    addi x31, x1, 0x7ff

    li x1, 0x7fffffff
    addi x31, x1, 0xfffff800

    # Groupement 4
    li x1, 0x00000000
    addi x31, x1, 0xffffffff

    li x1, 0xffffffff
    addi x31, x1, 0x001

    li x1, 0xffffffff
    addi x31, x1, 0xffffffff

    # Groupement 5
    li x1, 0x7fffffff
    addi x31, x1, 0x001

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 100
	# pout_start
    # 00000000
    # FFFFFFFF
    # FFFFF800
    # 000007FF
    # fffff800
    # 80000000
    # 7ffff800
    # 000007ff
    # 7fffffff
    # 800007fe
    # 800007ff
    # 7ffff7ff
    # ffffffff
    # 00000000
    # fffffffe
    # 80000000
	# pout_end
