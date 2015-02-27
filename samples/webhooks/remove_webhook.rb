webhook = Paymill::Webhook.find(active_webhook_id)
webhook.delete()
