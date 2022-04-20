# Test calculations of CURP

## Problem of MPI

I found how to avoid the problems. Use `util/load_curp_ims`.

## Disk access speed.

Which is the bottle neck ?

- Read time
- Write time
- Both of them

We already know that it is not matter at FLOW. This is unique problem at IMS because the disk access speed is too low.

