#TAG = lbu

	.text

	# Les tests qui suivent devraient fonctionner
	# test avec offset positif
    # la x1, testdata
    # lbu x31, 0(x1)

    # la x1, testdata
    # lbu x31, 1(x1)

    # la x1, testdata
    # lbu x31, 2(x1)

    # la x1, testdata
    # lbu x31, 3(x1)

    # test avec offset négatif
    # la x1, testdata4
    # lbu x31, -3(x1)

    # la x1, testdata4
    # lbu x31, -2(x1)

    # la x1, testdata4
    # lbu x31, -1(x1)

    # la x1, testdata4
    # lbu x31, 0(x1)

    # # test avec base négative
    # la x1, testdata
    # addi x1, x1, -32
    # lbu x31, 32(x1)

    # # test avec base non alignée
    # la x1, testdata
    # addi x1, x1, -6
    # lbu x31, 7(x1)

    # # test écriture après lw
    # la x1, testdata
    # lbu x31, 0(x1)
    # li x31, 2

    # la x1, testdata
    # lbu x31, 0(x1)
    # nop
    # li x31, 2


	# max_cycle 300
	# pout_start
	# pout_end
	
	# 000000ff
    # 00000000
    # 000000f0
    # 0000000f
    # 000000ff
    # 00000000
    # 000000f0
    # 0000000f
    # 000000ff
    # 00000000
    # 000000ff
    # 00000002
    # 000000ff
    # 00000002

    .data
	testdata:
	testdata1:  .byte 0xff
	testdata2:  .byte 0x00
	testdata3:  .byte 0xf0
	testdata4:  .byte 0x0f
