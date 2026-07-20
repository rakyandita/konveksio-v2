import os
import re

base_dir = '/Users/rakyandita/Documents/-= App Source =-/konveksio-v2/app/lib/'

# Fix boss_orders_screen.dart
f2 = os.path.join(base_dir, 'features/dashboard/presentation/boss_orders_screen.dart')
with open(f2, 'r') as f:
    c2 = f.read()
c2 = re.sub(r'\bOrder order\b', 'OrderModel order', c2)
with open(f2, 'w') as f:
    f.write(c2)

# Fix boss_order_detail_screen.dart
f3 = os.path.join(base_dir, 'features/dashboard/presentation/boss_order_detail_screen.dart')
with open(f3, 'r') as f:
    c3 = f.read()
c3 = re.sub(r'\bOrder order\b', 'OrderModel order', c3)
with open(f3, 'w') as f:
    f.write(c3)

print("Done")
