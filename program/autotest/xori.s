# TAG = xori
    .text

    # Groupement 1
    li x1, 0x00ff0f00
    xori x31, x1, 0xffffff0f

    li x1, 0x0ff00ff0
    xori x31, x1, 0x0f0

    li x1, 0x00ff08ff
    xori x31, x1, 0x70f

    li x1, 0xf00ff00f
    xori x31, x1, 0x0f0

    # Groupement 2
    xori x31, zero, 0x0f0

    li x1, 0x00ff00ff
    xori x0, x1, 0x70f  # mv x31, x0

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 100
	# pout_start
    # f00ff00f
    # ff00ff00
    # 0ff00ff0
    # 00ff00ff
    # 000000f0
    # pout_end
