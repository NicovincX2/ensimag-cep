# TAG = srli
    .text

    # Toujours plus de tests...
    # Pour avoir les résultats avec $1 en hexa et $2 le nombre décimal
    # printf '%x\n' $((($1 & (((1 << 31) << 1) - 1)) >> $2))
    # dans une fonction bash c'est d'enfer
    # Groupement 1
    li x1, 0x80000000
    srli x31, x1, 0

    li x1, 0x80000000
    srli x31, x1, 1

    li x1, 0x80000000
    srli x31, x1, 7

    li x1, 0x80000000
    srli x31, x1, 14

    li x1, 0x80000001
    srli x31, x1, 31

    # Groupement 2
    li x1, 0xffffffff
    srli x31, x1, 0

    li x1, 0xffffffff
    srli x31, x1, 1

    li x1, 0xffffffff
    srli x31, x1, 7

    li x1, 0xffffffff
    srli x31, x1, 14

    li x1, 0xffffffff
    srli x31, x1, 31

    # # Groupement 3
    # li x1, 0x21212121
    # srli x31, x1, 0

    # li x1, 0x21212121
    # srli x31, x1, 1

    # li x1, 0x21212121
    # srli x31, x1, 7

    # li x1, 0x21212121
    # srli x31, x1, 14

    # li x1, 0x21212121
    # srli x31, x1, 31

    # # Groupement 4
    # srli x31, x0, 4

    # li x1, 33
    # srli x0, x1, 10  # mv x31, x0

	# max_cycle 300
	# pout_start
    # 80000000
    # 40000000
    # 01000000
    # 00020000
    # 00000001
    # ffffffff
    # 7fffffff
    # 01ffffff
    # 0003ffff
    # 00000001
    # 21212121
    # 10909090
    # 00424242
    # 00008484
    # 00000000
	# pout_end

    # 21212121
    # 10909090
    # 00424242
    # 00008484
    # 00000000
    # 00000000
