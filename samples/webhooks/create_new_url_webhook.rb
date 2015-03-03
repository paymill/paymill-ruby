Paymill::Webhook.create(
    url: 'http://example.com',
    event_types: ['transaction.succeeded', 'transaction.failed']
)
