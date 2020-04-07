# TAG = sltiu
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x00000000
    sltiu x31, x1, 0x000

    li x1, 0x00000001
    sltiu x31, x1, 0x001

    li x1, 0x00000003
    sltiu x31, x1, 0x007

    li x1, 0x00000007
    sltiu x31, x1, 0x003

    # Groupement 2
    li x1, 0x00000000
    sltiu x31, x1, 0x00000800

    li x1, 0x80000000
    sltiu x31, x1, 0x000

    li x1, 0x80000000
    sltiu x31, x1, 0x00000800

    # Groupement 3
    li x1, 0x00000000
    sltiu x31, x1, 0x7ff

    li x1, 0x7fffffff
    sltiu x31, x1, 0x000

    li x1, 0x7fffffff
    sltiu x31, x1, 0x7ff

    # Groupement 4
    li x1, 0x80000000
    sltiu x31, x1, 0x7ff

    li x1, 0x7fffffff
    sltiu x31, x1, 0x00000800

    # Groupement 5
    li x1, 0x00000000
    sltiu x31, x1, 0x00000fff

    li x1, 0xffffffff
    sltiu x31, x1, 0x001

    li x1, 0xffffffff
    sltiu x31, x1, 0x00000fff

    # Groupement 6
    sltiu x31, x0, 0x00000fff

    li x1, 0x00ff00ff
    sltiu x0, x1, 0x00000fff  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 00000000
    # 00000000
    # 00000001
    # 00000000
    # 00000001
    # 00000000
    # 00000001
    # 00000001
    # 00000000
    # 00000000
    # 00000000
    # 00000001
    # 00000001
    # 00000000
    # 00000000
    # 00000000
	# pout_end
