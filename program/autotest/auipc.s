# TAG = auipc
	.text

	# auipc.s:6: Error: lui expression not in range 0..1048575 (0..0x000fffff)
	# upper : ne touche pas aux 3 derniers octets
	# 20 bits de poids forts puis 12 bits de 0

	auipc x31, 0          # Test chargement de PC = 0x1000
    auipc x31, 0          # Test chargement de PC = 0x1004
	# auipc x31, 0xfeff7 # 0xfeff7000 + 0x1008 = 0x000fffff
	auipc x31, 0xef459 # 0xef459000 + 0x100c = 0x000f0461

	# max_cycle 50
	# pout_start
	# 00001000
    # 00001004
	# ef45a00c
	# pout_end
	# 000fffff