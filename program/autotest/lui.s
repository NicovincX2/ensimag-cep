# TAG = lui
	.text

	lui x31, 0       #Test chargement d'une valeur nulle
	lui x31, 0xfffff #Test chargement d'une valeur maximal sur 20 bits
	lui x31, 0x12345 #Test chargement d'une valeur quelconque

	# D'autres tests
	lui x1, 0xfffff
	sra x31, x1, 1

	lui x1, 0x7ffff
	sra x31, x1, 20

	lui x1, 0x80000
	sra x31, x1, 20

	lui x0, 0x80000  # mv x31, x0

	# max_cycle 50
	# pout_start
	# 00000000
	# FFFFF000
	# 12345000
	# fffff800
	# 000007ff
	# fffff800
	# pout_end
