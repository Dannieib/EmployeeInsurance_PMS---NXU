import datetime

class Payment:
    penalty_rate = 0.05  # 5% penalty for late payments

    def __init__(self, payment_id, policyholder, amount, due_date, status="pending"):
        self.payment_id = payment_id
        self.policyholder = policyholder
        self.amount = amount
        self.due_date = due_date
        self.payment_date = None
        self.status = "pending"

    def process_payment(self, payment_date=None):
        if payment_date is None:
            payment_date = datetime.date.today()
        self.payment_date = payment_date
        if payment_date > self.due_date:
            self.status = "late"
            penalty = self.apply_penalty()
            print(f"Payment {self.payment_id} processed late. Penalty of {penalty:.2f} applied. New amount: {self.amount:.2f}")
        else:
            self.status = "completed"
            print(f"Payment {self.payment_id} processed on time.")
        # Record the payment in the policyholder's account if not already recorded
        if self not in self.policyholder.payments:
            self.policyholder.add_payment(self)

    def send_reminder(self):
        if self.status == "pending":
            print(f"Reminder: Payment {self.payment_id} of amount {self.amount} is due on {self.due_date} for policyholder {self.policyholder.policyholder_id}.")

    def apply_penalty(self):
        # Apply a 5% penalty for late payment
        penalty_amount = self.amount * Payment.penalty_rate
        self.amount += penalty_amount
        return penalty_amount

    def display_payment(self):
        print("\nPayment Details:")
        print(f"Payment ID: {self.payment_id}")
        print(f"Amount: {self.amount}")
        print(f"Due Date: {self.due_date}")
        print(f"Payment Date: {self.payment_date}")
        print(f"Status: {self.status}")