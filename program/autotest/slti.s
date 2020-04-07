# TAG = slti
    .text

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x00000000
    slti x31, x1, 0x000

    li x1, 0x00000001
    slti x31, x1, 0x001

    li x1, 0x00000003
    slti x31, x1, 0x007

    li x1, 0x00000007
    slti x31, x1, 0x003

    # Groupement 2
    li x1, 0x00000000
    slti x31, x1, 0x800

    li x1, 0x80000000
    slti x31, x1, 0x000

    li x1, 0x80000000
    slti x31, x1, 0x800

    # Groupement 3
    li x1, 0x00000000
    slti x31, x1, 0x7ff

    li x1, 0x7fffffff
    slti x31, x1, 0x000

    li x1, 0x7fffffff
    slti x31, x1, 0x7ff

    # Groupement 4
    li x1, 0x80000000
    slti x31, x1, 0x7ff

    li x1, 0x7fffffff
    slti x31, x1, 0x800

    # Groupement 5
    li x1, 0x00000000
    slti x31, x1, 0xfff

    li x1, 0xffffffff
    slti x31, x1, 0x001

    li x1, 0xffffffff
    slti x31, x1, 0xfff

    # Groupement 6
    slti x31, x0, 0xfff

    li x1, 0x00ff00ff
    slti x0, x1, 0xfff  # mv x31, x0

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
