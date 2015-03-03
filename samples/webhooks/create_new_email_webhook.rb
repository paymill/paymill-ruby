Paymill::Webhook.create(
    email: 'webhook@example.com',
    event_types: ['transaction.succeeded', 'transaction.failed'],
    active: false
)
