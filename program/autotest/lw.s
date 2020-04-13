#TAG = lw

	.text

	#Offset positif
	
	la x1, ADDR1
	lw x31, 0(x1)

	xor x1, x1, x1
	la x1, ADDR1
	lw x31, 4(x1)

	xor x1, x1, x1
	la x1, ADDR1
	lw x31, 8(x1)

	xor x1, x1, x1
	la x1, ADDR1
	lw x31, 12(x1)

	#Offset négatif
	
	xor x1, x1, x1
	la x1, ADDR1
	lw x31, -4(x1)
	
	xor x1, x1, x1
	la x1, ADDR1
	lw x31, -8(x1)

	xor x1, x1, x1
	la x1, ADDR1
	lw x31, -12(x1)

	###############

	# test avec offset positif
    # la x1, testdata
    # lw x31, 0(x1)

    # la x1, testdata
    # lw x31, 4(x1)

    # la x1, testdata
    # lw x31, 8(x1)

    # la x1, testdata
    # lw x31, 12(x1)

    # test avec offset négatif
    # la x1, testdata4
    # lw x31, -12(x1)

    # la x1, testdata4
    # lw x31, -8(x1)

    # la x1, testdata4
    # lw x31, -4(x1)

    # la x1, testdata4
    # lw x31, 0(x1)

    # # test avec base négative
    # la x1, testdata
    # addi x1, x1, -32
    # lw x31, 32(x1)

    # # test avec base non alignée
    # la x1, testdata
    # addi x1, x1, -3
    # lw x31, 7(x1)

    # # test écriture après lw
    # la x1, testdata
    # lw x31, 0(x1)
    # li x31, 2

    # la x1, testdata
    # lw x31, 0(x1)
    # nop
    # li x31, 2

	# max_cycle 300
	# pout_start
	# F00FF00F
	# F00FF013
	# F00FF017
	# F00FF01B
	# F00FF00B
	# F00FF007
	# F00FF003
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

	.data
	ADDR1: .word 0xF00FF00F
	# testdata:
	# testdata1:  .word 0x00ff00ff
	# testdata2:  .word 0xff00ff00
	# testdata3:  .word 0x0ff00ff0
	# testdata4:  .word 0xf00ff00f


