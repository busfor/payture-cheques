# Payture::Cheques

Обертка к API отправки чеков, предоставляемому компанией Payture.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'payture-cheques'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install payture-cheques

## Usage

Создание клиента:
```ruby
    client = Payture::Cheques.client(
      host: 'sandbox3.payture.com',
      merchant_id: 'MyMerchantId',
      password: 'MyPassword',
    )
```

отправка чека:
```ruby

    cheque = JSON.parse('{
             "Message":"test",
             "Type":1,
             "Positions":[
                {
                   "Quantity":1.000,
                   "Price":111.45,
                   "Tax":1,
                   "Text":"Булка"
                }
             ],
             "CheckClose":{
                "Payments":[
                   {
                      "Type":1,
                      "Amount":123.45
                   }
                ],
                "TaxationSystem":1
             },
             "CustomerContact":"nikita.popovsky@payture.com"
          }
       ')

        response = client.create(
          cheque_id: 'chequeid-1234',
          inn: 7710140679,
          content: cheque
        )

        response.success
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/payture-cheques.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
