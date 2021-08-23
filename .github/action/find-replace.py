#! /usr/bin/env python2
import os

filepath = os.path.join(
    str(os.environ.get("GITHUB_WORKSPACE")), str(os.environ.get("FILE_TO_MODIFY"))
)

with open(filepath) as f:
    newText = f.read().replace(
        str(os.environ.get("FIND")), str(os.environ.get("REPLACE"))
    )

with open(filepath, "w") as f:
    f.write(newText)

with open(filepath, "r") as f:
    print(f.read())
