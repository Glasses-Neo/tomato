{.experimental: "strictFuncs".}

import os, streams, json
import util

let tomatoPath = getHomeDir() / ".tomato.json"

type
  Task = ref object of RootObj
    title, description: string
    isDone: bool


proc newTask*(title, description: string): Task =
  result = Task(
    title: title,
    description: description,
    isDone: false
  )


# template makeTaskConstructor(task: typedesc[Task]) =
#   proc `"new"task`(title, description: string): task =
#     result = task(
#       title: title,
#       description: description,
#       isDone: false
#     )

# makeTaskConstructor DailyTask
# makeTaskConstructor OneDayTask

# func newTask*(title, description: string, oneDay = true): Task =
#   result = block:
#     if oneDay:
#       newOneDayTask(title, description)
#     else:
#       newDailyTask(title, description)



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
