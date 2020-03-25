# TAG = auipc
	.text

	auipc x31, 0       #Test chargement d'une valeur nulle PC = 0x1000
    auipc x31, 0       #Test chargement de PC = 0x1004
	auipc x31, 5 #Test chargement d'une valeur maximal sur 20 bits PC = 0x1008

	# max_cycle 50
	# pout_start
	# 00001000
    # 00001004
    # 00001009
	# pout_end
