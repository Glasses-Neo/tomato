{.experimental: "strictFuncs".}
import macros, os, rdstdin, strutils


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
    return readRequiredLineFromStdin prompt
  else: return


proc readLineYOrNFromStdin(prompt: string): bool =
  let ans = readLineFromStdin "[y/n]"&prompt
  result = case ans
  of "y", "Y", "yes", "Yes":
    true
  of "n", "N", "no", "No":
    false
  else:
    readLineYOrNFromStdin prompt


proc askTitle*: string = readRequiredLineFromStdin "title >"


proc askDescription*: string = readLineFromStdin "description > "


proc askIsOneDay*: bool = readLineYOrNFromStdin "Is this one-day task? >"


proc fileExistsAndNotEmpty*(fp: string): bool =
  result = (fileExists fp) and (getFileSize fp) > 0
