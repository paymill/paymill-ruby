webhook = Paymill::Webhook.find(active_webhook_id)
webhook.email = 'mail@example.com'
webhook.update()
