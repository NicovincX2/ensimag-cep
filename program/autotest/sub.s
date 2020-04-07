# TAG = sub

    # Groupement 1
    li x1, 0xffff8000 
    li x2, 0x00000000
    sub x31, x1, x2

    li x1, 0x80000000
    li x2, 0x80000000
    sub x31, x1, x2

    li x1, 0x7fff8000
    li x2, 0x80000000
    sub x31, x1, x2

    # Groupement 2
    li x1, 0x00007fff 
    li x2, 0x00000000
    sub x31, x1, x2

    li x1, 0x00000000
    li x2, 0x7fffffff
    sub x31, x1, x2

    li x1, 0x00007fff
    li x2, 0x7fffffff
    sub x31, x1, x2

    # Groupement 3
    li x1, 0x00007fff 
    li x2, 0x80000000
    sub x31, x1, x2

    li x1, 0xffff8000
    li x2, 0x7fffffff
    sub x31, x1, x2

    # Groupement 4
    li x1, 0xffffffff 
    li x2, 0x00000000
    sub x31, x1, x2

    li x1, 0x00000001
    li x2, 0xffffffff
    sub x31, x1, x2

    li x1, 0xffffffff
    li x2, 0xffffffff
    sub x31, x1, x2

    # Groupement 5
    li x1, 0x7fffffff 
    li x2, 0x00000001
    sub x31, x1, x2

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
