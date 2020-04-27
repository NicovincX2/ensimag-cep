#TAG = lw

	.text

	#Offset positif
	
	la x1, ADDR1
	lw x31, 0(x1)

	lw x31, 4(x1)

	lw x31, 8(x1)

	lw x31, 12(x1)

	#max_cycle 300
	#pout_start
	#F00FF00F
	#DEADBEEF
	#1BADCAFE
	#00BADA55
	#pout_end

	.data
	ADDR1: .word 0xF00FF00F, 0xDEADBEEF, 0x1BADCAFE, 0x00BADA55

