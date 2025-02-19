from policyholder import PolicyHolder
from product import Product
from payment import Payment
import datetime


def main():
    # Create a product
    product1 = Product(product_id=1, name="Comprehensive Insurance", details="Full coverage insurance policy")

    # Create two policy-holders - I'd implement faker but let's avoid prolongment
    policyholder1 = PolicyHolder(policyholder_id=101, name="Daniel Ibanga", email="dibanga@nexford.com")
    policyholder2 = PolicyHolder(policyholder_id=102, name="Raphael Doe", email="r.doe@example.com")
    policyholder3 = PolicyHolder(policyholder_id=103, name="Jane Doe", email="janed@example.com")
    policyholder4 = PolicyHolder(policyholder_id=104, name="Pending Joe", email="pending@example.com")

    # Here, I'm Associating the product with each policy-holder
    policyholder1.add_policy(product1)
    policyholder2.add_policy(product1)
    policyholder3.add_policy(product1)
    policyholder4.add_policy(product1)

    # Set a due date for payments
    due_date = datetime.date.today()

    # Create payments for each policyholder
    payment1 = Payment(payment_id=201, policyholder=policyholder1, amount=500.00, due_date=due_date)
    payment2 = Payment(payment_id=202, policyholder=policyholder2, amount=500.00, due_date=due_date)
    payment3 = Payment(payment_id=203, policyholder=policyholder3, amount=500.00, due_date=due_date)
    payment4 = Payment(payment_id=204, policyholder=policyholder4, amount=500.00, due_date=due_date)

    # Process payments
    payment1.process_payment(payment_date=due_date)
    payment2.process_payment(payment_date=due_date)
    payment3.process_payment(payment_date = datetime.date.today() + datetime.timedelta(days=10))
    payment4.send_reminder()

    # Display details of both policyholders
    print("\n--- Policyholder 1 Details ---")
    policyholder1.display_details()

    print("\n--- Policyholder 2 Details ---")
    policyholder2.display_details()

    print("\n--- Policyholder 3 Details ---")
    policyholder3.display_details()

    print("\n--- Policyholder 4 Details ---")
    policyholder4.display_details()

if __name__ == "__main__":
    main()