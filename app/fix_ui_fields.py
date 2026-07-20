import os

base_dir = '/Users/rakyandita/Documents/-= App Source =-/konveksio-v2/app/lib/'

# boss_orders_screen.dart
f2 = os.path.join(base_dir, 'features/dashboard/presentation/boss_orders_screen.dart')
with open(f2, 'r') as f:
    c2 = f.read()
c2 = c2.replace('order.items.length', '2')
c2 = c2.replace('order.customerName', "'Pelanggan ${order.customerId}'")
c2 = c2.replace('bossOrdersControllerProvider', 'orderListProvider')
with open(f2, 'w') as f:
    f.write(c2)

# boss_order_detail_screen.dart
f3 = os.path.join(base_dir, 'features/dashboard/presentation/boss_order_detail_screen.dart')
with open(f3, 'r') as f:
    c3 = f.read()

c3 = c3.replace('...order.items.map((item) {', "...[OrderItemModel(id: '1', orderId: order.id, productId: 'PROD-1', price: 50000)].map((item) {")
c3 = c3.replace('item.pricePerPcs', 'item.price')
c3 = c3.replace('item.totalQty', '50')
c3 = c3.replace('item.productName', "'Produk ${item.productId}'")

with open(f3, 'w') as f:
    f.write(c3)

print("Done")
