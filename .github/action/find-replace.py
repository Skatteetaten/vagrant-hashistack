import os

filepath = os.path.join(
    str(os.environ.get("GITHUB_WORKSPACE")), str(os.environ.get("FILE_TO_MODIFY"))
)

with open(filepath) as f:
    newText = f.read().replace(os.environ.get("FIND"), os.environ.get("REPLACE"))

with open(filepath, "w") as f:
    f.write(newText)

with open(filepath, "r") as f:
    print(f.read())
