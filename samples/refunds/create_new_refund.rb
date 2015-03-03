transaction = Paymill::Transaction.create(
    token: '098f6bcd4621d373cade4e832627b4f6',
    amount: 4200,
    currency: 'USD'
)

Paymill::Refund.create(
    transaction,
    amount: 4200,
    description: 'Sample Description'
)
