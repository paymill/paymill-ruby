payment = Paymill::Payment.create(token: '098f6bcd4621d373cade4e832627b4f6')

Paymill::Preauthorization.create(
    payment: payment.id,
    amount: 4200,
    currency: 'EUR',
    description: 'description example'
)
