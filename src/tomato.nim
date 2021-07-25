import tomatopkg / [util, serde]

proc add {.cmd.} =
  try:
    withTask:
      t.add newTask(askTitle(), askDescription())
  except:
    return 1





when isMainModule:
  import cligen
  clCfg.version = "0.1.0"
  dispatchMulti(
    [addCmd, cmdName = "add"]
  )
