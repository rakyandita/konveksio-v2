import os

pages = {
    "005": "spk-form",
    "006": "smart-assign",
    "009": "inbox-karyawan",
    "010": "tasks",
    "011": "task-detail",
    "012": "spk-viewer",
    "013": "handover-form",
    "015": "owner-branch-context",
    "018": "master-employees",
    "019": "master-employees-detail",
    "020": "master-products",
    "021": "master-customers",
    "024": "finance-kasbon",
    "025": "finance-salary",
    "026": "karyawan-kasbon",
    "027": "karyawan-salary",
    "028": "pipeline"
}

directory = "/Users/rakyandita/Documents/-= App Source =-/konveksio-v2/prototype"

html_template = """<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PAGE-{page_id} - Konveksio</title>
  <link rel="stylesheet" href="css/tokens.css">
  <link rel="stylesheet" href="css/base.css">
  <link rel="stylesheet" href="css/components.css">
  <script src="https://unpkg.com/@phosphor-icons/web"></script>
  <style>
    .boilerplate-container {{
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      background: var(--color-background);
      text-align: center;
      padding: var(--space-xl);
    }}
  </style>
</head>
<body>
  <div class="boilerplate-container">
    <i class="ph ph-wrench" style="font-size: 48px; color: var(--color-primary); margin-bottom: 16px;"></i>
    <h1>PAGE-{page_id}</h1>
    <p class="text-muted">Boilerplate for {page_name}</p>
    
    <!-- PT-06 Fix: Offline & Error state placeholders -->
    <div class="offline-indicator" style="display: none; background: var(--color-destructive); color: white; padding: 8px; margin-top: 16px; border-radius: 4px;">
      <i class="ph ph-wifi-x"></i> Anda sedang offline
    </div>
    <div class="error-state" style="display: none; background: #FEE2E2; color: #DC2626; padding: 8px; margin-top: 16px; border-radius: 4px;">
      <i class="ph ph-warning"></i> Terjadi kesalahan sistem
    </div>
  </div>
</body>
</html>
"""

for page_id, page_name in pages.items():
    filename = f"page-{page_id}-{page_name}.html"
    filepath = os.path.join(directory, filename)
    with open(filepath, "w") as f:
        f.write(html_template.format(page_id=page_id, page_name=page_name))
    print(f"Created {filename}")

print("Done generating boilerplate pages.")
