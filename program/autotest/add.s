# TAG = add

    # Tests normaux
    add x31, zero, zero  # no operation
    addi x1, x0, 1
    addi x2, x0, 1
    add x31, x1, x2

    add x31, x0, x0
    addi x1, x0, 5
    addi x2, x0, -5
    add x31, x1, x2

    # Quelques cas limites
    add x31, x0, x0
    addi x1, x0, -2048
    addi x2, x0, 0
    add x31, x1, x2

    add x31, x0, x0
    addi x1, x0, 2046
    addi x2, x0, 1
    add x31, x1, x2

    # On passe en hexa avec lui et d'autres (mais aussi les mêmes...) cas limites
    # Groupement 1
    li x1, 0xffff8000 
    li x2, 0x00000000
    add x31, x1, x2

    li x1, 0x80000000
    li x2, 0x80000000
    add x31, x1, x2

    li x1, 0x7fff8000
    li x2, 0x80000000
    add x31, x1, x2

    # Groupement 2
    li x1, 0x00007fff 
    li x2, 0x00000000
    add x31, x1, x2

    li x1, 0x00000000
    li x2, 0x7fffffff
    add x31, x1, x2

    li x1, 0x00007fff
    li x2, 0x7fffffff
    add x31, x1, x2

    # Groupement 3
    li x1, 0x00007fff 
    li x2, 0x80000000
    add x31, x1, x2

    li x1, 0xffff8000
    li x2, 0x7fffffff
    add x31, x1, x2

    # Groupement 4
    li x1, 0xffffffff 
    li x2, 0x00000000
    add x31, x1, x2

    li x1, 0x00000001
    li x2, 0xffffffff
    add x31, x1, x2

    li x1, 0xffffffff
    li x2, 0xffffffff
    add x31, x1, x2

    # Groupement 5
    li x1, 0x7fffffff 
    li x2, 0x00000001
    add x31, x1, x2

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 300
	# pout_start
    # 00000000
    # 00000002
    # 00000000
    # 00000000
    # 00000000
    # FFFFF800
    # 00000000
    # 000007FF
    # ffff8000
    # 00000000
    # ffff8000
    # 00007fff
    # 7fffffff
    # 80007ffe
    # 80007fff
    # 7fff7fff
    # ffffffff
    # 00000000
    # fffffffe
    # 80000000
	# pout_end
