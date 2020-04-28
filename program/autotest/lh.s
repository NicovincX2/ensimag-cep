# TAG = lh

	.text

	# Les tests qui suivent devraient fonctionner
	# test avec offset positif
    la x1, testdata
    lh x31, 0(x1)

    lh x31, 2(x1)

    #la x1, testdata
    #lh x31, 4(x1)

    #la x1, testdata
    #lh x31, 6(x1)

    # test avec offset négatif
    #la x1, testdata4
    #lh x31, -6(x1)

    #la x1, testdata4
    #lh x31, -4(x1)

    #la x1, testdata4
    #lh x31, -2(x1)

    #la x1, testdata4
    #lh x31, 0(x1)

    # test avec base négative
    #la x1, testdata
    #addi x1, x1, -32
    #lh x31, 32(x1)

    # test avec base non alignée
    #la x1, testdata
    #addi x1, x1, -5
    #lh x31, 7(x1)

    # test écriture après lh
    #la x1, testdata
    #lh x31, 0(x1)
    #li x31, 2

    #la x1, testdata
    #lh x31, 0(x1)
    #nop
    #li x31, 2


	# max_cycle 300
	# pout_start
    # ffff00f0
    # 0000000f
    # pout_end

	# 00000ff0
    # fffff00f
    # 000000ff
    # ffffff00
    # 00000ff0
    # fffff00f
    # 000000ff
    # ffffff00
    # 000000ff
    # 00000002
    # 000000ff
    # 00000002

    .data
	testdata: .half 0x00f0, 0x000f
	#testdata1:  .half 0x00ff
	#testdata2:  .half 0xff00
	#testdata3:  .half 0x0ff0
	#testdata4:  .half 0xf00f
