import os

env_keys = list(dict(os.environ).keys())

out_file = ""
filepath = os.path.join(
    str(os.environ.get("GITHUB_WORKSPACE")), str(os.environ.get("FILE_NAME"))
)

for key in env_keys:
    if key.startswith("ENVKEY_"):
        out_file += key.split("ENVKEY_")[1] + "=" + os.environ.get(key) + "\n"
filepath
with open(filepath, "w") as text_file:
    text_file.write(out_file)

with open(filepath) as text_file:
    print(text_file.read())
