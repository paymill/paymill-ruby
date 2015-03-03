offer = Paymill::Offer.find('offer_40237e20a7d5a231d99b')

offer.name = 'Extended Special'
offer.interval = '1 MONTH'
offer.currency = 'USD'
offer.amount = '3333'

offer.update( update_subscriptions: true )
