# TAG = auipc
	.text

	# auipc.s:6: Error: lui expression not in range 0..1048575 (0..0x000fffff)

	auipc x31, 0          # Test chargement de PC = 0x1000
    auipc x31, 0          # Test chargement de PC = 0x1004
	auipc x31, 0xfeff7 # 0x000feff7 + 0x1008 = 0x000fffff
	#auipc x31, 0x000ef459 # 0x000ef459 + 0x100c = 0x000F0465

	# max_cycle 50
	# pout_start
	# 00001000
    # 00001004
	# 000fffff
	# pout_end
	# 000f0465