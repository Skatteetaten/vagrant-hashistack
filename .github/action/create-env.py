import os
from uuid import uuid4

out_file = ""
filepath = os.path.join(
    str(os.environ.get("GITHUB_WORKSPACE")), str(os.environ.get("FILE_NAME"))
)

for key in os.environ.keys():
    if key.startswith("ENVKEY_"):
        if key.endswith("master_token") and os.environ.get(key) == 'random':
            out_file += key.split("ENVKEY_")[1] + "=" + uuid4().hex + "\n"
        else:
            out_file += key.split("ENVKEY_")[1] + "=" + os.environ.get(key) + "\n"

with open(filepath, "w") as text_file:
    text_file.write(out_file)

with open(filepath) as text_file:
    print(text_file.read())
