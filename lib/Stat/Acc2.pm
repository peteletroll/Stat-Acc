package Stat::Acc2;

use strict;
use warnings;

use Carp;

use Stat::Acc;

our $VERSION = '0.01';

use constant {
	X => 0,
	Y => 1,
	SXY => 2,
};

use overload
	'""' => "stringify";

sub new($) {
	my ($pkg) = @_;
	return bless [ Stat::Acc->new(), Stat::Acc->new(), 0 ], $pkg
}

sub n($) { $_[0][X]->n }

sub x($) { $_[0][X] }

sub y($) { $_[0][Y] }

sub add($@) {
	my $self = shift;
	(@_ & 1) and croak __PACKAGE__, "::add() wants couples";
	while (@_) {
		my ($x, $y) = splice @_, 0, 2;
		$self->x->add($x);
		$self->y->add($y);
		$self->[SXY] += $x * $y;
	}
	$self
}

sub _d($) {
	my ($self) = @_;
	my $s = $self->x->sum;
	$self->n * $self->x->sum_squared - $s * $s
}

sub slope($) {
	my ($self) = @_;
	($self->n * $self->[SXY] - $self->x->sum * $self->y->sum) / $self->_d
}

sub intercept($) {
	my ($self) = @_;
	my $sx = $self->x->sum;
	my $sx2 = $self->x->sum_squared;
	my $sy = $self->y->sum;
	my $sxy = $self->[SXY];
	($sx2 * $sy - $sx * $sxy) / $self->_d
}

sub stringify($) {
	my ($self) = @_;
	my $s = "";
	if ($self->n) {
		$s = $self->n
			. ":"
			. $self->x . "," . $self->y;
	}
	ref($self) . "{$s}"
}

1;

__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Stat::Acc - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Stat::Acc;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Stat::Acc, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.


=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Pietro Cagnoni, E<lt>pietro@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2026 by Pietro Cagnoni

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.40.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
