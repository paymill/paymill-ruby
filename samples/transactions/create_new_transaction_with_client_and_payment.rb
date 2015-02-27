client = Paymill::Client.create(email: 'mail@example.com')
payment = Paymill::Payment.create(
    token: '098f6bcd4621d373cade4e832627b4f6',
    client: client
)

Paymill::Transaction.create(
    payment: payment,
    client: client,
    amount: 4200,
    currency: 'EUR'
)
