package WebService::Coinbase;
use Moo;
with 'WebService::Client';

use Crypt::Mac::HMAC qw(hmac hmac_hex);
use Function::Parameters;
use HTTP::Request::Common qw(DELETE GET POST PUT);
use Time::HiRes qw(time);

has api_key => (
    is       => 'ro',
    required => 1,
);

has api_secret => (
    is       => 'ro',
    required => 1,
);

has '+base_url' => (
    is      => 'ro',
    default => 'https://api.coinbase.com/v1',
);

sub BUILD {
    my ($self) = @_;
    $self->ua->default_header(':ACCESS_KEY' => $self->api_key);
}

around req => fun($orig, $self, $req, @rest) {
    my $nonce = time * 1e5;
    my $signature =
        hmac_hex 'SHA256', $self->api_secret, $nonce, $req->uri, $req->content;
    $req->header(':ACCESS_NONCE'     => $nonce);
    $req->header(':ACCESS_SIGNATURE' => $signature);
    return $self->$orig($req, @rest);
};

method get_accounts { $self->get('/accounts') }

method get_account($id) { $self->get("/accounts/$id") }

method create_account(HashRef $data) {
    return $self->post("/accounts", { account => $data });
}

method modify_account($id, HashRef $data) {
    return $self->put("/accounts/$id", { account => $data });
}

method get_account_balance($id) { $self->get("/accounts/$id/balance") }

method get_account_address($id) { $self->get("/accounts/$id/address") }

method create_account_address($id, HashRef $data) {
    return $self->post("/accounts/$id/address", { address => $data });
}

method get_primary_account { $self->get("/accounts/primary") }

method set_primary_account($id) { $self->post("/accounts/$id/primary") }

method delete_account($id) { $self->delete("/accounts/$id") }

method get_addresses { $self->get("/addresses") }

method get_contacts { $self->get('/contacts') }

# ABSTRACT: Coinbase (http://coinbase.com) API bindings

=head1 SYNOPSIS

    my $coin = WebService::Coinbase->new(
        api_key    => 'API_KEY',
        api_secret => 'API_SECRET',
        logger     => Log::Tiny->new('/tmp/coin.log'), # optional
    );
    my $accounts = $coin->get_accounts();

=head1 METHODS

=head2 get_accounts

    get_accounts()

Returns the user's active accounts.

=head2 get_account

    get_account($account_id)

Returns one of the user's active accounts.

=head2 get_primary_account

    get_primary_account()

Returns the user's primary account.

=head2 set_primary_account

    set_primary_account($account_id)

Sets the primary account.

=head2 create_account

    create_account($data)

Creates a new account for the user.

Example:

    my $account = $coin->create_account({ name => "Bling Bling" });

=head2 get_account_balance

    get_account_balance($account_id)

Returns the user's current account balance in BTC.

=head2 get_account_address

    get_account_address($account_id)

Returns the user's current bitcoin receive address.

=head2 create_account_address

    create_account_address($account_id, $data)

Generates a new bitcoin receive address for the user.

Example:

    $coin->create_account_address($account_id, {
        label        => 'college fund',
        callback_url => 'http://foo.com/bar',
    });

=head2 modify_account

    modify_account($account_id, $data)

Modifies an account.

Example:

    $coin->modify_account($acct_id, { name => "Kanye's Account" });

=head2 delete_account

    delete_account($account_id)

Deletes an account.
Only non-primary accounts with zero balance can be deleted.

=cut

1;
