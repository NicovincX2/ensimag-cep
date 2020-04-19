#TAG = sb

	.text
	
	# Les tests qui suivent sont corrects mais ne fonctionnent
	# pas à cause d'un problème de génération du fichier .mem
	# Offset positif
	# la x1, testdata
	# li x2, 0xffffffaa
	# sb x2, 0(x1)
	# lb x31, 0(x1)

    # la x1, testdata
	# li x2, 0xffffffaa
	# sb x2, 1(x1)
	# lb x31, 1(x1)
	
	# la x1, testdata
	# li x2, 0xffffffa0
	# sb x2, 2(x1)
	# lb x31, 2(x1)
	
	# la x1, testdata
	# li x2, 0x0000000a
	# sb x2, 3(x1)
	# lb x31, 3(x1)
	
	# Offset négatif
	# la x1, testdata8
	# li x2, 0xffffffaa
	# sb x2, -3(x1)
	# lb x31, -3(x1)

    # la x1, testdata8
	# li x2, 0x00000000
	# sb x2, -2(x1)
	# lb x31, -2(x1)
	
	# la x1, testdata8
	# li x2, 0xffffffa0
	# sb x2, -1(x1)
	# lb x31, -1(x1)
	
	# la x1, testdata8
	# li x2, 0x0000000a
	# sb x2, 0(x1)
	# lb x31, 0(x1)
	
	# Base négative
	# la  x1, testdata9
    # li  x2, 0x12345678
    # addi x4, x1, -32
    # sb x2, 32(x4)
    # lb x31, 0(x1)
	
	# Base non alignée
	# la  x1, testdata9
    # li  x2, 0x00003098
    # addi x1, x1, -6
    # sb x2, 7(x1)
    # la  x4, testdata10
    # lb x31, 0(x4)
	

	# max_cycle 300
	# pout_start
	# pout_end
	
	# ffffffaa
    # 00000000
    # ffffffa0
    # 0000000a
    # ffffffaa
    # 00000000
    # ffffffa0
    # 0000000a
    # 00000078
    # ffffff98
    
	.data
	testdata:
    testdata1:  .byte 0xef
    testdata2:  .byte 0xef
    testdata3:  .byte 0xef
    testdata4:  .byte 0xef
    testdata5:  .byte 0xef
    testdata6:  .byte 0xef
    testdata7:  .byte 0xef
    testdata8:  .byte 0xef
    testdata9:  .byte 0xef
    testdata10: .byte 0xef
