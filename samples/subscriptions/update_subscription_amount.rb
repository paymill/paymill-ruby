#amount temporary:
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
subscription.update_amount_once(1234)

#amount permanently:
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
subscription.update_amount_permanently(1234)
