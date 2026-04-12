import sys
import re

userIsPresent = 0
error = 0

with open("Dockerfile", "r") as f:
    content = f.read()
    
    for line in content.splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
    
        if line.startswith("FROM") and "latest" in line:
            error = error + 1
            print("[ERROR] latest keyword is forbidden")
        elif line.startswith("FROM") and not ":" in line:
            error = error + 1
            print("[ERROR] choose a specific image version")
        elif line.startswith("USER"):
            if "root" in line:
                print("[ERROR] Strictly forbidden to run as root")
                error = error + 1
            userIsPresent = 1

if not userIsPresent:
    print("[ERROR] Missing user keyword")
    error = error + 1

if error:
    print(error, "error(s) found in the Dockerfile")
    sys.exit(1)

print("[SUCCES] Clean Dockerfile")
