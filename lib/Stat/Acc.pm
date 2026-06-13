package Stat::Acc;

use strict;
use warnings;

our $VERSION = '0.01';

use overload
	'""' => "stringify";

sub new($) {
	my ($pkg) = @_;
	return bless {
		n => 0,
		min => undef,
		max => undef,
		s => 0,
		s2 => 0,
	}, $pkg
}

sub n($) { $_[0]{n} }

sub min($) { $_[0]{min} }

sub max($) { $_[0]{max} }

sub add($@) {
	my $self = shift;
	foreach my $x (@_) {
		$x += 0;
		my $n = $self->{n}++;
		$self->{s} += $x;
		$self->{s2} += $x * $x;
		(!$n || $self->{min} > $x) and $self->{min} = $x;
		(!$n || $self->{max} < $x) and $self->{max} = $x;
	}
	$self
}

sub avg($) {
	my ($self) = @_;
	my $n = $self->n;
	$n or return undef;
	$self->{s} / $n
}

sub dev($) {
	my ($self) = @_;
	my $n = $self->{n};
	$n or return undef;
	my $s = $self->{s};
	my $s2 = $self->{s2};
	sqrt(($s2 - $s * $s / $n) / $n)
}

sub _str($) {
	my ($x) = @_;
	defined $x ? sprintf("%1.3f", 0 + $x) : "undef"
}

sub stringify($) {
	my ($self) = @_;
	my $s = "";
	if ($self->n) {
		$s = $self->n
			. ":"
			. "[" . _str($self->min) . "," . _str($self->max) . "]"
			. ":"
			. _str($self->avg) . "\x{b1}" . _str($self->dev) 
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
