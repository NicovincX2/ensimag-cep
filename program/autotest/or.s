# TAG = or
    .text

    # Groupement 1
    li x1, 0xff00ff00
    li x2, 0x0f0f0f0f
    or x31, x1, x2

    li x1, 0x0ff00ff0
    li x2, 0xf0f0f0f0
    or x31, x1, x2

    li x1, 0x00ff00ff
    li x2, 0x0f0f0f0f
    or x31, x1, x2

    li x1, 0xf00ff00f
    li x2, 0xf0f0f0f0
    or x31, x1, x2

    # Groupement 2
    li x1, 0xff00ff00
    or x31, x1, zero

    li x1, 0x00ff00ff
    or x31, zero, x1

    or x31, zero, zero

    li x1, 0x11111111
    li x2, 0x22222222
    or x0, x1, x2  # limitation de x31

    # TODO : 
    # source/destination tests
    # tester pour differents nombre de cycles (ce ne sont pas des tests unitaires)

	# max_cycle 100
	# pout_start
    # ff0fff0f
    # fff0fff0
    # 0fff0fff
    # f0fff0ff
    # ff00ff00
    # 00ff00ff
    # 00000000
    # pout_end
