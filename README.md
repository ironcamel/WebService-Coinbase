# NAME

WebService::Coinbase - Coinbase (http://coinbase.com) API bindings

# VERSION

version 0.0101

# SYNOPSIS

    use WebService::Coinbase;

    my $coin = WebService::Coinbase->new(
        api_key    => 'API_KEY',
        api_secret => 'API_SECRET',
        logger     => Log::Tiny->new('/tmp/coin.log'), # optional
    );
    my $accounts = $coin->get_accounts();

# METHODS

## get\_accounts

    get_accounts()

Returns the user's active accounts.

## get\_account

    get_account($account_id)

Returns one of the user's active accounts.

## get\_primary\_account

    get_primary_account()

Returns the user's primary account.

## set\_primary\_account

    set_primary_account($account_id)

Sets the primary account.

## create\_account

    create_account($data)

Creates a new account for the user.

Example:

    my $account = $coin->create_account({ name => "Bling Bling" });

## get\_balance

    get_balance()

Returns the user's current balance.

## get\_account\_balance

    get_account_balance($account_id)

Returns the current balance for the given account.

## get\_account\_address

    get_account_address($account_id)

Returns the user's current bitcoin receive address.

## create\_account\_address

    create_account_address($account_id, $data)

Generates a new bitcoin receive address for the user.

Example:

    $coin->create_account_address($account_id, {
        label        => 'college fund',
        callback_url => 'http://foo.com/bar',
    });

## modify\_account

    modify_account($account_id, $data)

Modifies an account.

Example:

    $coin->modify_account($acct_id, { name => "Kanye's Account" });

## delete\_account

    delete_account($account_id)

Deletes an account.
Only non-primary accounts with zero balance can be deleted.

## get\_addresses

    get_addresses()

Returns the bitcoin addresses a user has associated with their account.

## get\_address

    get_address($id_or_address)

Returns the bitcoin address object for the given id or address.

## get\_contacts

    get_contacts()

Returns contacts the user has previously sent to or received from.

## get\_transactions

    get_transactions()

Returns the user's transactions sorted by created\_at in descending order.

## get\_transaction

    get_transaction($transaction_id)

Returns the transaction for the given id.

## send\_money

    send_money($data)

Send money to an email or bitcoin address.

Example:

    $coin->send_money({
        to       => $email_or_bitcoin_address,
        amount   => '1.23',
        notes    => 'Here is your money',
    });

## transfer\_money

    transfer_money($data)

Transfer bitcoin between accounts.

## request\_money

    request_money($data)

Request money from an email.

## resend\_request

    resend_request($transaction_id)

Resend a money request.

## complete\_request

    complete_request($transaction_id)

Lets the recipient of a money request complete the request by sending money to
the user who requested the money.
This can only be completed by the user to whom the request was made,
not the user who sent the request.

## cancel\_request

    cancel_request($transaction_id)

Cancel a money request.

## get\_buy\_price

    get_buy_price()
    get_buy_price(query => { qty => 1 })

## get\_sell\_price

    get_sell_price()
    get_sell_price(query => { qty => 1 })

## get\_spot\_price

    get_spot_price()
    get_spot_price(query => { currency  => 'CAD' })

# AUTHOR

Naveed Massjouni <naveed@vt.edu>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Naveed Massjouni.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
