class Product:
    def __init__(self, product_id, name, details):
        self.product_id = product_id
        self.name = name
        self.details = details
        self.status = "active"  # "active" or "suspended"

    def update_product(self, name=None, details=None):
        if name:
            self.name = name
        if details:
            self.details = details
        print(f"Product {self.product_id} updated.")

    def suspend_product(self):
        self.status = "suspended"
        print(f"Product {self.product_id} has been suspended.")

    def display_product(self):
        print("\nProduct Details:")
        print(f"ID: {self.product_id}")
        print(f"Name: {self.name}")
        print(f"Details: {self.details}")
        print(f"Status: {self.status}")