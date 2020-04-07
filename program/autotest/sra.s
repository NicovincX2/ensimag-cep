# TAG = sra
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x80000000
    li x2, 0
    sra x31, x1, x2

    li x1, 0x80000000
    li x2, 1
    sra x31, x1, x2

    li x1, 0x80000000
    li x2, 7
    sra x31, x1, x2

    li x1, 0x80000000
    li x2, 14
    sra x31, x1, x2

    li x1, 0x80000001
    li x2, 31
    sra x31, x1, x2

    # Groupement 2
    li x1, 0x7fffffff
    li x2, 0
    sra x31, x1, x2

    li x1, 0x7fffffff
    li x2, 1
    sra x31, x1, x2

    li x1, 0x7fffffff
    li x2, 7
    sra x31, x1, x2

    li x1, 0x7fffffff
    li x2, 14
    sra x31, x1, x2

    li x1, 0x7fffffff
    li x2, 31
    sra x31, x1, x2

    # Groupement 3
    li x1, 0x81818181
    li x2, 0
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 1
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 7
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 14
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 31
    sra x31, x1, x2

    # Groupement 4
    li x1, 0x81818181
    li x2, 0xffffffc0
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 0xffffffc1
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 0xffffffc7
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 0xffffffce
    sra x31, x1, x2

    li x1, 0x81818181
    li x2, 0xffffffff
    sra x31, x1, x2

    # Groupement 5
    li x1, 15
    sra x31, x0, x1

    li x1, 32
    sra x31, x1, x0

    sra x31, zero, zero

    li x1, 1024
    li x2, 2048
    sra x0, x1, x2  # mv x31, x0

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
    # 81818181
    # c0c0c0c0
    # ff030303
    # fffe0606
    # ffffffff
    # 00000000
    # 00000020
    # 00000000
	# pout_end
