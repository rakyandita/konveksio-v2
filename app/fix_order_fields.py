import os

base_dir = '/Users/rakyandita/Documents/-= App Source =-/konveksio-v2/app/lib/'

def fix_file(filepath):
    with open(filepath, 'r') as f:
        c = f.read()

    # Field renames
    c = c.replace('deadlineDate', 'targetDate')
    c = c.replace('totalPrice', 'totalAmount')
    c = c.replace('createdAt', 'orderDate')
    
    # Enums
    c = c.replace('OrderStatus.running', "'running'")
    c = c.replace('OrderStatus.completed', "'completed'")
    c = c.replace('OrderStatus.draft', "'draft'")
    c = c.replace('OrderStatus.cancelled', "'cancelled'")
    
    # Type of status in _buildStatusBadge
    c = c.replace('Widget _buildStatusBadge(OrderStatus status)', 'Widget _buildStatusBadge(String status)')
    c = c.replace('case OrderStatus.draft:', "case 'draft':")
    c = c.replace('case OrderStatus.running:', "case 'running':")
    c = c.replace('case OrderStatus.completed:', "case 'completed':")
    c = c.replace('case OrderStatus.cancelled:', "case 'cancelled':")

    # Order instantiation dummy
    c = c.replace('isActive: true,', 'orderNumber: \'ORD-${index+1}\',')
    
    # boss_orders_screen specific
    c = c.replace('order.items.length', '2')
    c = c.replace('order.customerName', "'Pelanggan ${order.customerId}'")
    
    # Formatters might complain about nullable dates
    c = c.replace('order.targetDate)', 'order.targetDate ?? DateTime.now())')
    c = c.replace('order.orderDate)', 'order.orderDate ?? DateTime.now())')
    c = c.replace('order.targetDate.difference', '(order.targetDate ?? DateTime.now()).difference')

    with open(filepath, 'w') as f:
        f.write(c)

fix_file(os.path.join(base_dir, 'features/dashboard/presentation/boss_orders_screen.dart'))
fix_file(os.path.join(base_dir, 'features/dashboard/presentation/boss_order_detail_screen.dart'))

print("Done")
