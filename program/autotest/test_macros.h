// On essaie de généraliser nos tests


#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------

#define TEST_RR_OP(instruction, val1, val2 ) \
    li  x1, val1; \
    li  x2, val2; \
    instruction x3, x1, x2;