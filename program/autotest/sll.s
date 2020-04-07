# TAG = sll
    .text

    # sll rd, rs1, rs2
    # le registre x0 vaut toujours 0

    addi x1, x0, 0
    addi x2, x0, 0
    sll x31, x1, x2

    addi x1, x0, 0
    addi x2, x0, 5
    sll x31, x1, x2

    addi x1, x0, 2
    addi x2, x0, 5
    sll x31, x1, x2

    addi x1, x0, -4
    addi x2, x0, 3
    sll x31, x1, x2

    # Toujours plus de tests...
    # Groupement 1
    li x1, 0x00000001
    li x2, 0
    sll x31, x1, x2

    li x1, 0x00000001
    li x2, 1
    sll x31, x1, x2

    li x1, 0x00000001
    li x2, 7
    sll x31, x1, x2

    li x1, 0x00000001
    li x2, 14
    sll x31, x1, x2

    li x1, 0x00000001
    li x2, 31
    sll x31, x1, x2

    # Groupement 2
    li x1, 0xffffffff
    li x2, 0
    sll x31, x1, x2

    li x1, 0xffffffff
    li x2, 1
    sll x31, x1, x2

    li x1, 0xffffffff
    li x2, 7
    sll x31, x1, x2

    li x1, 0xffffffff
    li x2, 14
    sll x31, x1, x2

    li x1, 0xffffffff
    li x2, 31
    sll x31, x1, x2

    # Groupement 3
    li x1, 0x21212121
    li x2, 0
    sll x31, x1, x2

    li x1, 0x21212121
    li x2, 1
    sll x31, x1, x2

    li x1, 0x21212121
    li x2, 7
    sll x31, x1, x2

    li x1, 0x21212121
    li x2, 14
    sll x31, x1, x2

    li x1, 0x21212121
    li x2, 31
    sll x31, x1, x2

    # Groupement 4
    li x1, 0x21212121
    li x2, 0xffffffc0
    sll x31, x1, x2

    li x1, 0x21212121
    li x2, 0xffffffc1
    sll x31, x1, x2

    li x1, 0x21212121
    li x2, 0xffffffc7
    sll x31, x1, x2

    li x1, 0x21212121
    li x2, 0xffffffce
    sll x31, x1, x2

    # Groupement 5
    li x1, 15
    sll x31, x0, x1

    li x1, 32
    sll x31, x1, x0

    sll x31, zero, zero

    li x1, 1024
    li x2, 2048
    sll x0, x1, x2  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 00000000
    # 00000000
    # 00000040
    # FFFFFFE0
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
    # 21212121
    # 42424242
    # 90909080
    # 48484000
    # 00000000
    # 00000020
    # 00000000
	# pout_end
