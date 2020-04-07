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
    sltiu x31, x1, 0xfffff800

    li x1, 0x80000000
    sltiu x31, x1, 0x000

    li x1, 0x80000000
    sltiu x31, x1, 0xfffff800

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
    sltiu x31, x1, 0xfffff800

    # Groupement 5
    li x1, 0x00000000
    sltiu x31, x1, 0xffffffff

    li x1, 0xffffffff
    sltiu x31, x1, 0x001

    li x1, 0xffffffff
    sltiu x31, x1, 0xffffffff

    # Groupement 6
    sltiu x31, x0, 0xffffffff

    li x1, 0x00ff00ff
    sltiu x0, x1, 0xffffffff  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 00000000
    # 00000000
    # 00000001
    # 00000000
    # 00000000
    # 00000001
    # 00000001
    # 00000001
    # 00000000
    # 00000000
    # 00000001
    # 00000000
    # 00000000
    # 00000001
    # 00000000
    # 00000000
	# pout_end
