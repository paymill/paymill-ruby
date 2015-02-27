# with subscriptions:
offer = Paymill::Offer.find('offer_40237e20a7d5a231d99b')
offer.delete_with_subscriptions()

# without subscriptions:
offer = Paymill::Offer.find('offer_40237e20a7d5a231d99b')
offer.delete_without_subscriptions()
