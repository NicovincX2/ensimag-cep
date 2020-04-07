# TAG = slli
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x00000001
    slli x31, x1, 0

    li x1, 0x00000001
    slli x31, x1, 1

    li x1, 0x00000001
    slli x31, x1, 7

    li x1, 0x00000001
    slli x31, x1, 14

    li x1, 0x00000001
    slli x31, x1, 31

    # Groupement 2
    li x1, 0xffffffff
    slli x31, x1, 0

    li x1, 0xffffffff
    slli x31, x1, 1

    li x1, 0xffffffff
    slli x31, x1, 7

    li x1, 0xffffffff
    slli x31, x1, 14

    li x1, 0xffffffff
    slli x31, x1, 31

    # Groupement 3
    li x1, 0x21212121
    slli x31, x1, 0

    li x1, 0x21212121
    slli x31, x1, 1

    li x1, 0x21212121
    slli x31, x1, 7

    li x1, 0x21212121
    slli x31, x1, 14

    li x1, 0x21212121
    slli x31, x1, 31

    # Groupement 4
    slli x31, x0, 15

    li x1, 1024
    slli x0, x1, 2048  # mv x31, x0

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
