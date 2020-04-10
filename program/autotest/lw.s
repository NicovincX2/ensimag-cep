# TAG = lw

    .text

    li x1, 0x1000
    lw x31, 0(x1)

    # .data
    # test: .word 0xf00ff00f

    # test avec offset positif
    # la x1, tdat
    # lw x31, 0(x1)

    # la x1, tdat
    # lw x31, 4(x1)

    # la x1, tdat
    # lw x31, 8(x1)

    # la x1, tdat
    # lw x31, 12(x1)

    # test avec offset négatif
    # la x1, tdat4
    # lw x31, -12(x1)

    # la x1, tdat4
    # lw x31, -8(x1)

    # la x1, tdat4
    # lw x31, -4(x1)

    # la x1, tdat4
    # lw x31, 0(x1)

    # # test avec base négative
    # la x1, tdat
    # addi x1, x1, -32
    # lw x31, 32(x1)

    # # test avec base non alignée
    # la x1, tdat
    # addi x1, x1, -3
    # lw x31, 7(x1)

    # # test écriture après lw
    # la x1, tdat
    # lw x31, 0(x1)
    # li x31, 2

    # la x1, tdat
    # lw x31, 0(x1)
    # nop
    # li x31, 2

    # max_cycle 300
	# pout_start
    # 00001000
    # pout_end


    # 00ff00ff
    # ff00ff00
    # 0ff00ff0
    # f00ff00f
    # 00ff00ff
    # ff00ff00
    # 0ff00ff0
    # f00ff00f
    # 00ff00ff
    # ff00ff00
    # 00ff00ff
    # 00000002
    # 00ff00ff
    # 00000002