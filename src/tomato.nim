import tomatopkg / [serde, util]

proc add {.cmd.} =
  try:
    withTask:
      t.add newTask(askTitle(), askDescription(), askIsOneDay())
    echo "The task is created successfully."
  except:
    return 1


when isMainModule:
  import cligen
  clCfg.version = "0.1.0"
  dispatchMulti(
    [addCmd, cmdName = "add"]
  )
