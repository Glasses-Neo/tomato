import tomatopkg / [util]

proc add {.cmd.} =
  discard


when isMainModule:
  import cligen
  dispatchMulti(
    [addCmd, cmdname = "add"]
  )
