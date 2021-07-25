{.experimental: "strictFuncs".}
import macros, rdstdin, strutils, os


macro cmd*(theProc: untyped): untyped =
  ## Append `Cmd` to the end of the proc name.
  ## Set the return type to int and the default return value to `0`.
  result = theProc
  result.name = newIdentNode(theProc.name.strVal&"Cmd")
  result[3][0] = newIdentNode"int"
  result[6].add newAssignment(newIdentNode"result", newIntLitNode 0)


proc readRequiredLineFromStdin(prompt: string): string =
  result = readLineFromStdin "[Required] "&prompt

  if result.isEmptyOrWhitespace:
    echo "title is required."
    result = readRequiredLineFromStdin prompt
  else: return


proc askTitle*: string = readRequiredLineFromStdin "> "

proc askDescription*: string = readLineFromStdin "> "

proc fileExistsAndNotEmpty*(fp: string): bool =
  result = (fileExists fp) and (getFileSize fp) > 0
