import macros


macro cmd*(theProc: untyped): untyped =
  ## Append `Cmd` to the end of the proc name.
  ## Set the return type to int and the default return value to `0`.
  result = theProc
  result.name = newIdentNode(theProc.name.strVal&"Cmd")
  result[3][0] = newIdentNode"int"
  result[6].add newAssignment(newIdentNode"result", newIntLitNode 0)
