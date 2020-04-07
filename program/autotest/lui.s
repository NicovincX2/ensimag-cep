# TAG = lui
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
	lui x31, 0xfffff #Test chargement d'une valeur maximal sur 20 bits
	# sra x31, x31, 1
	lui x31, 0x12345 #Test chargement d'une valeur quelconque

	# D'autres tests
	lui x31, 0x0007ffff
	# sra x31, x31, 20

	lui x31, 0x00080000
	# sra x31, x31, 20

	lui x0, 0x80000  # à mv dans x31

	# max_cycle 50
	# pout_start
	# 00000000
	# FFFFF000
	# 12345000
	# 000007ff
	# fffff800
	# pout_end
