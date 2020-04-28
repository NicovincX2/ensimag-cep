# TAG = sh

	.text
	
	# Les tests qui suivent sont corrects
	# Offset positif
	la x1, testdata
	li x2, 0x000000aa
	sh x2, 0(x1)
	lh x31, 0(x1)

    la x1, testdata
	li x2, 0xffffaa00
	sh x2, 2(x1)
	lh x31, 2(x1)
	
	la x1, testdata
	li x2, 0xbeef0aa0
	sh x2, 4(x1)
	lw x31, 4(x1)
	
	la x1, testdata
	li x2, 0xffffa00a
	sh x2, 6(x1)
	lh x31, 6(x1)
	
	# Offset négatif
	la x1, testdata8
	li x2, 0x000000aa
	sh x2, -6(x1)
	lh x31, -6(x1)

    la x1, testdata8
	li x2, 0xffffaa00
	sh x2, -4(x1)
	lh x31, -4(x1)
	
	la x1, testdata8
	li x2, 0x00000aa0
	sh x2, -2(x1)
	lh x31, -2(x1)
	
	la x1, testdata8
	li x2, 0xffffa00a
	sh x2, 0(x1)
	lh x31, 0(x1)
	
	# Base négative
	la  x1, testdata9
    li  x2, 0x5678
    addi x4, x1, -32
    sh x2, 32(x4)
    lh x31, 0(x1)
	
	# Base non alignée
	la  x1, testdata9
    li  x2, 0x3098
    addi x1, x1, -3
    sh x2, 7(x1)
    la  x4, testdata10
    lh x31, 0(x4)
	

	# max_cycle 300
	# pout_start
	# 000000aa
    # ffffaa00
    # beef0aa0
    # ffffa00a
    # 000000aa
    # ffffaa00
    # 00000aa0
    # ffffa00a
    # 00005678
    # ffff3098
	# pout_end
    
	.data
	testdata:
    testdata1:  .half 0xbeef
    testdata2:  .half 0xbeef
    testdata3:  .half 0xbeef
    testdata4:  .half 0xbeef
    testdata5:  .half 0xbeef
    testdata6:  .half 0xbeef
    testdata7:  .half 0xbeef
    testdata8:  .half 0xbeef
    testdata9:  .half 0xbeef
    testdata10: .half 0xbeef
