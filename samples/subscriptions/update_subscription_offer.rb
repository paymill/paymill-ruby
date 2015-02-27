#offer with no refund and unchanged capture date:
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
offer = Offer.create(name: 'Foo', amount: 4990, currency: 'EUR', interval: '2 WEEK')
subscription.update_offer_without_changes(offer)

#offer with refund and unchanged capture date:
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
offer = Offer.create(name: 'Foo', amount: 4990, currency: 'EUR', interval: '2 WEEK')
subscription.update_offer_with_refund(offer)

#offer with refund and capture date:
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
offer = Offer.create(name: 'Foo', amount: 4990, currency: 'EUR', interval: '2 WEEK')
subscription.update_offer_with_refund_and_capture_date(offer)
