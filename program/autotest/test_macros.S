// On essaie de généraliser nos tests


.macro TEST_RR_OP instruction val1 val2
    li  x1, val1
    li  x2, val2
    instruction x31, x1, x2
.endm