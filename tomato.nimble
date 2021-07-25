import tables
# Package

version       = "0.1.0"
author        = "Glasses-Neo"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
namedBin      = {"tomato": "tmt"}.toTable
binDir        = "bin"


# Dependencies

requires "nim >= 1.4.8"
requires "cligen"
