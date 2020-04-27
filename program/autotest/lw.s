#TAG = lw

	.text

	
	# Les tests qui suivent devraient fonctionner mais
	# non à cause d'un mauvaise génération des fichiers .mem
	# test avec offset positif
     la x1, testdata
     lw x31, 0(x1)

     la x1, testdata
     lw x31, 4(x1)

     la x1, testdata
     lw x31, 8(x1)

     la x1, testdata
     lw x31, 12(x1)

     #test avec offset négatif
     la x1, testdata4
     lw x31, -12(x1)

     la x1, testdata4
     lw x31, -8(x1)

     la x1, testdata4
     lw x31, -4(x1)

     la x1, testdata4
     lw x31, 0(x1)


	# max_cycle 300
	# pout_start
	
	# 00ff00ff
    # ff00ff00
    # 0ff00ff0
    # f00ff00f
    # 00ff00ff
    # ff00ff00
    # 0ff00ff0
    # f00ff00f
	# pout_end

	.data
	testdata:
	testdata1:  .word 0x00ff00ff
	testdata2:  .word 0xff00ff00
	testdata3:  .word 0x0ff00ff0
	testdata4:  .word 0xf00ff00f


