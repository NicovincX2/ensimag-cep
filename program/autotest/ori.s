# TAG = ori
    .text

    # Groupement 1
    li x1, 0xff00ff00
    ori x31, x1, 0xffffff0f

    li x1, 0x0ff00ff0
    ori x31, x1, 0x0f0

    li x1, 0x00ff00ff
    ori x31, x1, 0x70f

    li x1, 0xf00ff00f
    ori x31, x1, 0x0f0

    # Groupement 2
    ori x31, zero, 0x0f0

    li x1, 0x00ff00ff
    ori x0, x1, 0x70f  # limitation de x31

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 100
	# pout_start
    # ffffff0f
    # 0ff00ff0
    # 00ff07ff
    # f00ff0ff
    # 000000f0
    # pout_end
