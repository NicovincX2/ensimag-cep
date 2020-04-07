# TAG = srai
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x00000000
    srai x31, x1, 0

    li x1, 0x80000000
    srai x31, x1, 1

    li x1, 0x80000000
    srai x31, x1, 7

    li x1, 0x80000000
    srai x31, x1, 14

    li x1, 0x80000001
    srai x31, x1, 31

    # Groupement 2
    li x1, 0x7fffffff
    srai x31, x1, 0

    li x1, 0x7fffffff
    srai x31, x1, 1

    li x1, 0x7fffffff
    srai x31, x1, 7

    li x1, 0x7fffffff
    srai x31, x1, 14

    li x1, 0x7fffffff
    srai x31, x1, 31

    # Groupement 3
    li x1, 0x81818181
    srai x31, x1, 0

    li x1, 0x81818181
    srai x31, x1, 1

    li x1, 0x81818181
    srai x31, x1, 7

    li x1, 0x81818181
    srai x31, x1, 14

    li x1, 0x81818181
    srai x31, x1, 31

    # Groupement 4
    srai x31, x0, 4

    li x1, 33
    srai x0, x1, 10  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 00000000
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
    # 00000000
	# pout_end
