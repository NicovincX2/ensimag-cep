# TAG = lhu

	.text

	# Les tests qui suivent devraient fonctionner
	# test avec offset positif
    la x1, testdata1
    lhu x31, 0(x1)

    la x1, testdata1
    lhu x31, 2(x1)

    # la x1, testdata
    # lhu x31, 4(x1)

    # la x1, testdata
    # lhu x31, 6(x1)

    # test avec offset négatif
    # la x1, testdata4
    # lhu x31, -6(x1)

    # la x1, testdata4
    # lhu x31, -4(x1)

    # la x1, testdata4
    # lhu x31, -2(x1)

    # la x1, testdata4
    # lhu x31, 0(x1)

    # test avec base négative
    la x1, testdata1
    addi x1, x1, -32
    lhu x31, 32(x1)

    # test avec base non alignée
    la x1, testdata1
    addi x1, x1, -5
    lhu x31, 7(x1)

    # test écriture après lw
    la x1, testdata1
    lhu x31, 0(x1)
    li x31, 2

    la x1, testdata1
    lhu x31, 0(x1)
    nop
    li x31, 2


	# max_cycle 300
	# pout_start
    # 000000ff
    # 0000ff00
    # 000000ff
    # 0000ff00
    # 000000ff
    # 00000002
    # 000000ff
    # 00000002
    # pout_end

    # 00000ff0
    # 0000f00f
    # 000000ff
    # 0000ff00
    # 00000ff0
    # 0000f00f

    .data
	testdata1: .half 0x00ff, 0xff00
    testdata2: .half 0x0ff0, 0xf00f
    
    # testdata: 
	# testdata1:  .half 0x00ff
	# testdata2:  .half 0xff00
	# testdata3:  .half 0x0ff0
	# testdata4:  .half 0xf00f
