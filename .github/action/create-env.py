import os

env_keys = list(dict(os.environ).keys())

out_file = ""

for key in env_keys:
    if key.startswith("ENVKEY_"):
        out_file += key.split("ENVKEY_")[1] + "=" + os.environ.get(key) + "\n"

with open( str(os.environ.get("GITHUB_WORKSPACE")) + "/" + str(os.environ.get("FILE_NAME")), "w") as text_file:
    text_file.write(out_file)
text_file.close()

with open( str(os.environ.get("GITHUB_WORKSPACE")) + "/" + str(os.environ.get("FILE_NAME")), "r") as text_file:
    print(text_file.read())
text_file.close()
