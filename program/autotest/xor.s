# TAG = xor
    .text

    # Groupement 1
    li x1, 0xff00ff00
    li x2, 0x0f0f0f0f
    xor x31, x1, x2

    li x1, 0x0ff00ff0
    li x2, 0xf0f0f0f0
    xor x31, x1, x2

    li x1, 0x00ff00ff
    li x2, 0x0f0f0f0f
    xor x31, x1, x2

    li x1, 0xf00ff00f
    li x2, 0xf0f0f0f0
    xor x31, x1, x2

    # Groupement 2
    li x1, 0xff00ff00
    xor x31, x1, zero

    li x1, 0x00ff00ff
    xor x31, zero, x1

    xor x31, zero, zero

    li x1, 0x11111111
    li x2, 0x22222222
    xor x0, x1, x2  # limitation de x31

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 100
	# pout_start
    # f00ff00f
    # ff00ff00
    # 0ff00ff0
    # 00ff00ff
    # ff00ff00
    # 00ff00ff
    # 00000000
    # pout_end
