payment = Paymill::Payment.create(token: '098f6bcd4621d373cade4e832627b4f6')
transaction = Paymill::Transaction.create(
    payment: payment,
    amount: 4200,
    currency: 'EUR',
    description: 'Test Transaction'
)
