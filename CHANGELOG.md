### v2.0.1
  * allow creating [Checksum](https://github.com/paymill/paymill-ruby/blob/master/lib/paymill/models/checksum.rb#L19) with the parameters __shipping_amount__, __handling_amount__ and __client__
  * fix [issue #23](https://github.com/paymill/paymill-ruby/issues/23) Checksum with Client
  * fix serialisation for arrays [PR #24](https://github.com/paymill/paymill-ruby/pull/24), thanks to [@morgoth](https://github.com/morgoth)

### v2.0.0
* add [PR #21](https://github.com/paymill/paymill-ruby/pull/21) Do not try to cast every value of JSON to integer, thanks to [@morgoth](https://github.com/morgoth)

### v1.0.2
* fix [issue #6](https://github.com/paymill/paymill-ruby/issues/6) Add new parameter mandate_reference
* fix [issue #7](https://github.com/paymill/paymill-ruby/issues/7) ActiveSupport 4.1 requirement
* fix [issue #8](https://github.com/paymill/paymill-ruby/issues/8) No access to iban and bic
* fix [issue #9](https://github.com/paymill/paymill-ruby/issues/9) Add explanation on how to run the spec
* Add Checksum, Address and ShoppingCartItem objects for paypal payments.

### v0.0.1 (unreleased)

-	initial release inspired by [dkd's paymill-ruby](https://github.com/dkd/paymill-ruby) wrapper
