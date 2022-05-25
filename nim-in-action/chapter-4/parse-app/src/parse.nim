import parseopt

for kind, key, val in getOpt():
    case kind
    of cmdArgument:
        echo("Got a command argument: ", key)
    of cmdLongOption, cmdShortOption:
        case key
        of "port": echo("Got port: ", val)
        else: echo("Got another flag --", key, " with value: ", val)
    of cmdEnd: discard
