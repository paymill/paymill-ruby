#pause:
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
subscription.pause

#play:
subscription = Paymill::Subscription.find('sub_dea86e5c65b2087202e3')
subscription.play
