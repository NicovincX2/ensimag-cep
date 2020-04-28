#TAG = sw

	.text

	lui x1, 0 
	la x2, ADDR1
	sw x1, 4(x2)
	lw x31, 4(x2)

	# Les tests qui suivent sont corrects
	# Offset positif
	la x1, testdata
	li x2, 0x00aa00aa
	sw x2, 0(x1)
	lw x31, 0(x1)

    la x1, testdata
	li x2, 0xaa00aa00
	sw x2, 4(x1)
	lw x31, 4(x1)
	
	la x1, testdata
	li x2, 0x0aa00aa0
	sw x2, 8(x1)
	lw x31, 8(x1)
	
	la x1, testdata
	li x2, 0xa00aa00a
	sw x2, 12(x1)
	lw x31, 12(x1)
	
	# Offset négatif
	la x1, testdata8
	li x2, 0x00aa00aa
	sw x2, -12(x1)
	lw x31, -12(x1)

    la x1, testdata8
	li x2, 0xaa00aa00
	sw x2, -8(x1)
	lw x31, -8(x1)
	
	la x1, testdata8
	li x2, 0x0aa00aa0
	sw x2, -4(x1)
	lw x31, -4(x1)
	
	la x1, testdata8
	li x2, 0xa00aa00a
	sw x2, 0(x1)
	lw x31, 0(x1)
	
	# Base négative
	la  x1, testdata9
    li  x2, 0x12345678
    addi x4, x1, -32
    sw x2, 32(x4)
    lw x31, 0(x1)
	
	# Base non alignée
	la  x1, testdata9
    li  x2, 0x58213098
    addi x1, x1, -3
    sw x2, 7(x1)
    la  x4, testdata10
    lw x31, 0(x4)


	# max_cycle 300
	# pout_start
	# 00000000
	# 00aa00aa
    # aa00aa00
    # 0aa00aa0
    # a00aa00a
    # 00aa00aa
    # aa00aa00
    # 0aa00aa0
    # a00aa00a
    # 12345678
    # 58213098
	# pout_end

	.data
	ADDR1: .word 0xF00FF00F
	testdata:
    testdata1:  .word 0xdeadbeef
    testdata2:  .word 0xdeadbeef
    testdata3:  .word 0xdeadbeef
    testdata4:  .word 0xdeadbeef
    testdata5:  .word 0xdeadbeef
    testdata6:  .word 0xdeadbeef
    testdata7:  .word 0xdeadbeef
    testdata8:  .word 0xdeadbeef
    testdata9:  .word 0xdeadbeef
    testdata10: .word 0xdeadbeef

