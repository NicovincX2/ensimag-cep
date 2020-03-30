# TAG = auipc
	.text

	auipc x31, 0          # Test chargement de PC = 0x1000
    auipc x31, 0          # Test chargement de PC = 0x1004
	auipc x31, 0xabcdef00 # 0xabcdef00 + 0x1008 = 0xabcdff08
	auipc x31, 0xef459000 # 0xef459000 + 0x100c = 0xef45a00c

	# max_cycle 50
	# pout_start
	# 00001000
    # 00001004
	# abcdff08
	# ef45a00c
	# pout_end
