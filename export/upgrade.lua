print("[BOOT] Hold CTRL+T for console.")
shell.run("unmount /fs")
shell.run("mount /fs C:\\Users\\Miles\\Documents\\workspace\\turtle_server\\export")
term.blit("[BOOT] Starting from remote file system...\n", "5555555555555555555555555555555555555555555", "                                           ")
print()
shell.run("/fs/startup")