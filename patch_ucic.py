import os
import re

directory = "/Users/rakyandita/Documents/-= App Source =-/konveksio-v2/docs/system_logics"

for i in range(9):
    filename = f"sys_uc_00{i}.md"
    filepath = os.path.join(directory, filename)
    if not os.path.exists(filepath):
        continue
        
    with open(filepath, "r") as f:
        content = f.read()

    # Check if already patched (has 8 sections)
    if "## 6. Data Mapping" in content:
        continue

    # Rename existing sections
    content = content.replace("## 3. Sequence Diagram", "## 4. Sequence Diagram")
    content = content.replace("## 4. API Contract", "## 5. API Contract")
    content = content.replace("## 5. Error Handling", "## 8. Error Handling")
    
    # Insert Related Entities before Sequence Diagram
    insert_3 = "## 3. Related Entities\n- `profiles`\n- `tasks` (tambahkan entitas yang relevan)\n\n"
    content = content.replace("## 4. Sequence Diagram", insert_3 + "## 4. Sequence Diagram")
    
    # Insert Data Mapping & Validation before Error Handling
    insert_6_7 = "## 6. Data Mapping (UI ↔ API ↔ DB)\n| UI Field | API Field | DB Column | Data Type | Notes |\n|----------|-----------|-----------|-----------|-------|\n| Field | field | column | text | - |\n\n## 7. Validation Rules\n- Wajib diisi sesuai aturan field.\n\n"
    content = content.replace("## 8. Error Handling", insert_6_7 + "## 8. Error Handling")
    
    with open(filepath, "w") as f:
        f.write(content)
        
    print(f"Patched {filename}")

print("Done patching.")
