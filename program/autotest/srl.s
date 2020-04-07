# TAG = srl
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x80000000
    li x2, 0
    srl x31, x1, x2

    li x1, 0x80000000
    li x2, 1
    srl x31, x1, x2

    li x1, 0x80000000
    li x2, 7
    srl x31, x1, x2

    li x1, 0x80000000
    li x2, 14
    srl x31, x1, x2

    li x1, 0x80000001
    li x2, 31
    srl x31, x1, x2

    # Groupement 2
    li x1, 0x7fffffff
    li x2, 0
    srl x31, x1, x2

    li x1, 0x7fffffff
    li x2, 1
    srl x31, x1, x2

    li x1, 0x7fffffff
    li x2, 7
    srl x31, x1, x2

    li x1, 0x7fffffff
    li x2, 14
    srl x31, x1, x2

    li x1, 0x7fffffff
    li x2, 31
    srl x31, x1, x2

    # Groupement 3
    li x1, 0x21212121
    li x2, 0
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 1
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 7
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 14
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 31
    srl x31, x1, x2

    # Groupement 4
    li x1, 0x21212121
    li x2, 0xffffffc0
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 0xffffffc1
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 0xffffffc7
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 0xffffffce
    srl x31, x1, x2

    li x1, 0x21212121
    li x2, 0xffffffff
    srl x31, x1, x2

    # Groupement 5
    li x1, 15
    srl x31, x0, x1

    li x1, 32
    srl x31, x1, x0

    srl x31, zero, zero

    li x1, 1024
    li x2, 2048
    srl x0, x1, x2  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 80000000
    # c0000000
    # ff000000
    # fffe0000
    # ffffffff
    # 7fffffff
    # 3fffffff
    # 00ffffff
    # 0001ffff
    # 00000000
    # 81818181
    # c0c0c0c0
    # ff030303
    # fffe0606
    # ffffffff
    # 21212121
    # 10909090
    # 00424242
    # 00008484
    # 00000000
    # 00000000
    # 00000020
    # 00000000
	# pout_end
