client = Paymill::Client.create(email: 'client@example.com')
payment = Paymill::Payment.create(token: '098f6bcd4621d373cade4e832627b4f6', client: client)

Paymill::Subscription.create(
    payment: payment,
    client: client,
    name: 'Example Subscription',
    amount: 3000,
    currency: 'EUR',
    interval: '1 week,monday',
    period_of_validity: '2 YEAR',
    start_at: 2.days.from_now
)
