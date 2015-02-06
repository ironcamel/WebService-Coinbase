# NAME

WebService::Coinbase - Coinbase (http://coinbase.com) API bindings

# VERSION

version 0.0001

# SYNOPSIS

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

## get\_account\_balance

    get_account_balance($account_id)

Returns the user's current account balance in BTC.

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

# AUTHOR

Naveed Massjouni <naveed@vt.edu>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Naveed Massjouni.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
