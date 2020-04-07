// On essaie de généraliser nos tests

#ifndef __test_macros_h__
#define __test_macros_h__

#define RVTEST_RV32U \
  .macro init; \
  .endm

// Tests for an instruction with register-register operands

#define TEST_RR_OP(instruction, val1, val2) \
    li  x1, val1; \
    li  x2, val2; \
    instruction x31, x1, x2;

#endif