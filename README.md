# VoxCaml #

A project to follow along with [Let's Make a Voxel Engine][letsmakeavoxelengine] and to learn OCaml project practices. 

Currently, voxcaml.ml is just the triangle example from the [tsdl][tsdl] for GL3. Will change as progress is made.
[letsmakeavoxelengine]: https://sites.google.com/site/letsmakeavoxelengine "Let's Make a Voxel Engine" 



-------------------------------------------------------------------------------

## Dependencies ##

- [`result`][result] - 1.1 - result compat lib by janestreet

- [`tsdl`][tgls] - 0.9.0 - SDL Binding by dbuenzli

- [`tgls`][tgls] - 0.8.3 - GL Binding by dbuenzli

Available on opam
[result]: https://github.com/janestreet/result "janestreet/result"
[tgls]: https://github.com/dbuenzli/tgls "dbuenzli/tgls"
[tsdl]: https://github.com/dbuenzli/tsdl "dbuenzli/tsdl"

-------------------------------------------------------------------------------

## Setup ##

Uses OASIS for building; oasis-setup.sh is just a call to `oasis setup -setup-update dynamic` but may later change to be more than that (??).

-------------------------------------------------------------------------------

## License ##

BSD-3-Clause
```
Copyright (c) 2016, David A Holland
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

