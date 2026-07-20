import os
import glob
import re

directory = "/Users/rakyandita/Documents/-= App Source =-/konveksio-v2/app/lib"
files = glob.glob(directory + "/**/*.dart", recursive=True)

for file in files:
    with open(file, "r") as f:
        content = f.read()
    
    new_content = content.replace("AppTheme.radiusXl", "AppTheme.radiusLg")
    
    if new_content != content:
        with open(file, "w") as f:
            f.write(new_content)
        print(f"Updated {file}")
