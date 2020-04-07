# TAG = andi
    .text

    # Groupement 1
    li x1, 0xff00ff00
    andi x31, x1, 0xffffff0f

    li x1, 0x0ff00ff0
    andi x31, x1, 0x0f0

    li x1, 0x00ff00ff
    andi x31, x1, 0x70f

    li x1, 0xf00ff00f
    andi x31, x1, 0x0f0

    # Groupement 2
    andi x31, zero, 0x0f0

    li x1, 0x00ff00ff
    andi x0, x1, 0x70f  # limitation de x31

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 100
	# pout_start
    # ff00ff00
    # 000000f0
    # 0000000f
    # 00000000
    # 00000000
    # pout_end
