# TAG = sub

    # Groupement 1
    li x1, 0x00000000 
    li x2, 0x00000000
    sub x31, x1, x2

    li x1, 0x00000001
    li x2, 0x00000001
    sub x31, x1, x2

    li x1, 0x00000003
    li x2, 0x00000007
    sub x31, x1, x2

    # Groupement 2
    li x1, 0x00000000 
    li x2, 0xffff8000
    sub x31, x1, x2

    li x1, 0x80000000
    li x2, 0x00000000
    sub x31, x1, x2

    li x1, 0x80000000
    li x2, 0xffff8000
    sub x31, x1, x2

    # Groupement 3
    li x1, 0x00000000 
    li x2, 0x00007fff
    sub x31, x1, x2

    li x1, 0x7fffffff
    li x2, 0x00000000
    sub x31, x1, x2

    li x1, 0x7fffffff
    li x2, 0x00007fff
    sub x31, x1, x2

    # Groupement 4
    li x1, 0x80000000
    li x2, 0x00007fff
    sub x31, x1, x2

    li x1, 0x7fffffff
    li x2, 0xffff8000
    sub x31, x1, x2

    # Groupement 5
    li x1, 0x00000000 
    li x2, 0xffffffff
    sub x31, x1, x2

    li x1, 0xffffffff
    li x2, 0x00000001
    sub x31, x1, x2

    li x1, 0xffffffff
    li x2, 0xffffffff
    sub x31, x1, x2

    # Groupement 6
    li x1, -15
    sub x31, x0, x1

    li x1, 32
    sub x31, x0, x1

    sub x31, zero, zero

    li x1, 16
    li x2, 30
    sub x0, x1, x2  # mv x31, x0

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 300
	# pout_start
    # 00000000
    # 00000000
    # fffffffc
    # 00008000
    # 80000000
    # 80008000
    # ffff8001
    # 7fffffff
    # 7fff8000
    # 7fff8001
    # 80007fff
    # 00000001
    # fffffffe
    # 00000000
    # 0000000f
    # 00000020
    # 00000000
	# pout_end
