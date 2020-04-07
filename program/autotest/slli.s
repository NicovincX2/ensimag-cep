# TAG = slli
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x00000001
    li x2, 0
    slli x31, x1, x2

    li x1, 0x00000001
    li x2, 1
    slli x31, x1, x2

    li x1, 0x00000001
    li x2, 7
    slli x31, x1, x2

    li x1, 0x00000001
    li x2, 14
    slli x31, x1, x2

    li x1, 0x00000001
    li x2, 31
    slli x31, x1, x2

    # Groupement 2
    li x1, 0xffffffff
    li x2, 0
    slli x31, x1, x2

    li x1, 0xffffffff
    li x2, 1
    slli x31, x1, x2

    li x1, 0xffffffff
    li x2, 7
    slli x31, x1, x2

    li x1, 0xffffffff
    li x2, 14
    slli x31, x1, x2

    li x1, 0xffffffff
    li x2, 31
    slli x31, x1, x2

    # Groupement 3
    li x1, 0x21212121
    li x2, 0
    slli x31, x1, x2

    li x1, 0x21212121
    li x2, 1
    slli x31, x1, x2

    li x1, 0x21212121
    li x2, 7
    slli x31, x1, x2

    li x1, 0x21212121
    li x2, 14
    slli x31, x1, x2

    li x1, 0x21212121
    li x2, 31
    slli x31, x1, x2

    # Groupement 4
    li x1, 15
    slli x31, x0, x1

    li x1, 1024
    li x2, 2048
    slli x0, x1, x2  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 00000001
    # 00000002
    # 00000080
    # 00004000
    # 80000000
    # ffffffff
    # fffffffe
    # ffffff80
    # ffffc000
    # 80000000
    # 21212121
    # 42424242
    # 90909080
    # 48484000
    # 80000000
    # 00000000
	# pout_end
