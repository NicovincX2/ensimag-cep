# TAG = auipc
	.text

	auipc x31, 0       #Test chargement d'une valeur nulle PC = 0x1000
	#auipc x31, 0xfffff #Test chargement d'une valeur maximal sur 20 bits PC = 0x1388
	#auipc x31, 0x12345 #Test chargement d'une valeur quelconque PC = 0x138c

	# max_cycle 50
	# pout_start
	# 00001000
	# pout_end
    # 00001388
	# 12345000
