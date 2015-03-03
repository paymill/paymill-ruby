payment = Paymill::Payment.create(token: '098f6bcd4621d373cade4e832627b4f6')
offer = Paymill::Offer.create(
    amount: 4200,
    currency: 'EUR',
    interval: '1 MONTH',
    name: 'Nerd Special',
    trial_period_days: 30
)

Paymill::Subscription.create(
    payment: payment,
    offer: offer,
    amount: 3000,
    currency: 'EUR',
    interval: '1 week, monday',
    name: 'Example Subscription',
    period_of_validity: '2 YEAR',
    start_at: 2.days.from_now
)
