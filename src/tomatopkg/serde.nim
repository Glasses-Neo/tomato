{.experimental: "strictFuncs".}
import json, os
import util


let tomatoPath = getHomeDir() / ".tomato.json"


type
  Task = ref object of RootObj
    title, description: string
    isOneDay, isDone: bool


proc newTask*(title, description: string, isOneDay: bool): Task =
  result = Task(
    title: title,
    description: description,
    isOneDay: isOneDay,
    isDone: false
  )


proc save(tasks: seq[Task]) =
  let f = open(tomatoPath, fmWrite)
  defer: close f
  f.write $(%tasks).pretty


proc loadFromFile: JsonNode = parseFile tomatoPath


proc loadTasks*: seq[Task] =
  if fileExistsAndNotEmpty tomatoPath:
    result = loadFromFile().to seq[Task]
  else:
    open(tomatoPath, fmReadWrite).close


template withTask*(body: untyped) =
  block:
    var t {.inject.} = loadTasks()
    body
    save t
