subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
subscription.payment = 'pay_95ba26ba2c613ebb0ca8'
subscription.currency = 'USD'
subscription.interval = '1 month,friday'
subscription.name = 'Changed Subscription'
subscription.trial_end = false
subscription.update

# for limit / unlimit use
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
subscription.unlimit
subscription.limit('12 MONTH')
