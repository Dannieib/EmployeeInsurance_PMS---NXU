# Please, see bottom of README file for direction.
library(R6)

# Define the PolicyHolder class
PolicyHolder <- R6Class("PolicyHolder",
  public = list(
    policyholder_id = NULL,
    name = NULL,
    email = NULL,
    status = "active",
    policies = NULL,
    payments = NULL,
    
    initialize = function(policyholder_id, name, email) {
      self$policyholder_id <- policyholder_id
      self$name <- name
      self$email <- email
      self$status <- "active"
      self$policies <- list()
      self$payments <- list()
    },
    
    suspend = function() {
      self$status <- "suspended"
      cat(sprintf("Policyholder %s has been suspended.\n", self$policyholder_id))
    },
    
    reactivate = function() {
      self$status <- "active"
      cat(sprintf("Policyholder %s has been reactivated.\n", self$policyholder_id))
    },
    
    add_policy = function(product) {
      self$policies[[length(self$policies) + 1]] <- product
      cat(sprintf("Product '%s' added to policyholder %s.\n", product$name, self$policyholder_id))
    },
    
    add_payment = function(payment) {
      self$payments[[length(self$payments) + 1]] <- payment
    },
    
    display_details = function() {
      cat("\nPolicyholder Details:\n")
      cat(sprintf("ID: %s\n", self$policyholder_id))
      cat(sprintf("Name: %s\n", self$name))
      cat(sprintf("Email: %s\n", self$email))
      cat(sprintf("Status: %s\n", self$status))
      
      cat("Policies:\n")
      if (length(self$policies) > 0) {
        for (product in self$policies) {
          cat(sprintf("  - %s (Status: %s)\n", product$name, product$status))
        }
      } else {
        cat("  No policies assigned.\n")
      }
      
      cat("Payments:\n")
      if (length(self$payments) > 0) {
        for (payment in self$payments) {
          cat(sprintf("  - Payment ID: %s, Amount: %.2f, Status: %s\n", 
                      payment$payment_id, payment$amount, payment$status))
        }
      } else {
        cat("  No payments made yet.\n")
      }
    }
  )
)

# Defining the Product class
Product <- R6Class("Product",
  public = list(
    product_id = NULL,
    name = NULL,
    details = NULL,
    status = "active",  # "active" or "suspended"
    
    initialize = function(product_id, name, details) {
      self$product_id <- product_id
      self$name <- name
      self$details <- details
      self$status <- "active"
    },
    
    update_product = function(name = NULL, details = NULL) {
      if (!is.null(name)) self$name <- name
      if (!is.null(details)) self$details <- details
      cat(sprintf("Product %s updated.\n", self$product_id))
    },
    
    suspend_product = function() {
      self$status <- "suspended"
      cat(sprintf("Product %s has been suspended.\n", self$product_id))
    },
    
    display_product = function() {
      cat("\nProduct Details:\n")
      cat(sprintf("ID: %s\n", self$product_id))
      cat(sprintf("Name: %s\n", self$name))
      cat(sprintf("Details: %s\n", self$details))
      cat(sprintf("Status: %s\n", self$status))
    }
  )
)

# Define the Payment class
Payment <- R6Class("Payment",
  public = list(
    payment_id = NULL,
    policyholder = NULL,
    amount = NULL,
    due_date = NULL,
    payment_date = NULL,
    status = "pending",
    penalty_rate = 0.05,
    
    initialize = function(payment_id, policyholder, amount, due_date) {
      self$payment_id <- payment_id
      self$policyholder <- policyholder
      self$amount <- amount
      self$due_date <- due_date
      self$payment_date <- NULL
      self$status <- "pending"
    },
    
    process_payment = function(payment_date = Sys.Date()) {
      self$payment_date <- payment_date
      if (payment_date > self$due_date) {
        self$status <- "late"
        penalty <- self$apply_penalty()
        cat(sprintf("Payment %s processed late. Penalty of %.2f applied. New amount: %.2f\n", 
                    self$payment_id, penalty, self$amount))
      } else {
        self$status <- "completed"
        cat(sprintf("Payment %s processed on time.\n", self$payment_id))
      }
      # Add the payment to the policyholder's account.
      self$policyholder$add_payment(self)
    },
    
    send_reminder = function() {
      if (self$status == "pending") {
        cat(sprintf("Reminder: Payment %s of amount %.2f is due on %s for policyholder %s.\n",
                    self$payment_id, self$amount, as.character(self$due_date), 
                    self$policyholder$policyholder_id))
      }
    },
    
    apply_penalty = function() {
      penalty_amount <- self$amount * self$penalty_rate
      self$amount <- self$amount + penalty_amount
      return(penalty_amount)
    },
    
    display_payment = function() {
      cat("\nPayment Details:\n")
      cat(sprintf("Payment ID: %s\n", self$payment_id))
      cat(sprintf("Amount: %.2f\n", self$amount))
      cat(sprintf("Due Date: %s\n", as.character(self$due_date)))
      cat(sprintf("Payment Date: %s\n", ifelse(is.null(self$payment_date), "None", as.character(self$payment_date))))
      cat(sprintf("Status: %s\n", self$status))
    }
  )
)

main <- function() {
  # simulate a product creation
  product1 <- Product$new(product_id = 1, name = "Comprehensive Insurance", details = "Full coverage insurance policy")
  
  # simulate policyholders creation -- same as in py
  policyholder1 <- PolicyHolder$new(policyholder_id=101, name="Daniel Ibanga", email="dibanga@nexford.com")
  policyholder2 <- PolicyHolder$new(policyholder_id=102, name="Raphael Doe", email="r.doe@example.com")
  policyholder3 <- PolicyHolder$new(policyholder_id=103, name="Jane Doe", email="janed@example.com")
  policyholder4 <- PolicyHolder$new(policyholder_id=104, name="Pending Joe", email="pending@example.com")
  
  policyholder1$add_policy(product1)
  policyholder2$add_policy(product1)
  policyholder3$add_policy(product1)
  policyholder4$add_policy(product1)
  
  due_date <- Sys.Date() - 2
  
  yesterday <- Sys.Date() - 1
  
  # Create payment simulation for each policyholder
  payment1 <- Payment$new(payment_id = 201, policyholder = policyholder1, amount = 500.00, due_date = due_date)
  payment2 <- Payment$new(payment_id = 202, policyholder = policyholder2, amount = 500.00, due_date = due_date)
  payment3 <- Payment$new(payment_id = 203, policyholder = policyholder3, amount = 500.00, due_date = due_date)
  payment4 <- Payment$new(payment_id = 204, policyholder = policyholder4, amount = 500.00, due_date = due_date)
  
  # Process payments
  payment1$process_payment(payment_date = due_date)
  payment2$process_payment(payment_date = due_date)
  payment3$process_payment(payment_date = Sys.Date() + 10)
  payment4$send_reminder()
  
  # Display details for each policyholder
  cat("\n--- Policyholder 1 Details ---\n")
  policyholder1$display_details()
  
  cat("\n--- Policyholder 2 Details ---\n")
  policyholder2$display_details()
  
  cat("\n--- Policyholder 3 Details ---\n")
  policyholder3$display_details()
  
  cat("\n--- Policyholder 4 Details ---\n")
  policyholder4$display_details()
}

# Run the main here..
main()