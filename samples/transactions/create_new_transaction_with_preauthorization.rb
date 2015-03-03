preauthorization = Paymill::Preauthorization.create(
    token: '098f6bcd4621d373cade4e832627b4f6',
    amount: 4200,
    currency: 'EUR'
)
transaction = Transaction.create(
    preauthorization: preauthorization,
    amount: 4200,
    currency: 'EUR'
)
