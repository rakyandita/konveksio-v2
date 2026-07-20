import os
import glob
import re

directory = "/Users/rakyandita/Documents/-= App Source =-/konveksio-v2/app/lib"
files = glob.glob(directory + "/**/*.dart", recursive=True)

for file in files:
    with open(file, "r") as f:
        content = f.read()
    
    new_content = re.sub(r'prefixIcon: PhosphorIconsRegular\.([a-zA-Z0-9_]+),', r'prefixIcon: Icon(PhosphorIconsRegular.\1),', content)
    
    if new_content != content:
        with open(file, "w") as f:
            f.write(new_content)
        print(f"Updated {file}")
