class PolicyHolder:
    def __init__(self, policyholder_id, name, email):
        self.policyholder_id = policyholder_id
        self.name = name
        self.email = email
        self.status = "active"  # "active" or "suspended"
        self.policies = []      # List of Product objects
        self.payments = []      # List of Payment objects

    def suspend(self):
        self.status = "suspended"
        print(f"Policyholder {self.policyholder_id} has been suspended.")

    def reactivate(self):
        self.status = "active"
        print(f"Policyholder {self.policyholder_id} has been reactivated.")

    def add_policy(self, product):
        self.policies.append(product)
        print(f"Product '{product.name}' added to policyholder {self.policyholder_id}.")

    def add_payment(self, payment):
        self.payments.append(payment)

    def display_details(self):
        print("\nPolicyholder Details:")
        print(f"ID: {self.policyholder_id}")
        print(f"Name: {self.name}")
        print(f"Email: {self.email}")
        print(f"Status: {self.status}")
        print("Policies:")
        if self.policies:
            for product in self.policies:
                print(f"  - {product.name} (Status: {product.status})")
        else:
            print("  No policies assigned.")
        print("Payments:")
        if self.payments:
            for payment in self.payments:
                print(f"  - Payment ID: {payment.payment_id}, Amount: {payment.amount}, Status: {payment.status}")
        else:
            print("  No payments made yet.")