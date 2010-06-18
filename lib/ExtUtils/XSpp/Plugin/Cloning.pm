package ExtUtils::XSpp::Plugin::Cloning;
use strict;
use warnings;

our $VERSION = '0.01';

use Carp ();
use ExtUtils::XSpp ();
use Class::XSAccessor {
  constructor => 'new',
};

=head1 NAME

ExtUtils::XSpp::Plugin::Cloning - An XS++ plugin for controlling cloning on thread creation

=head1 SYNOPSIS

Use it in your XS++ code as follows. No other interface required.

  %module{Your::Module}
  
  %loadplugin{Cloning}
  
  # Objects of this class will just be undef in a cloned interpreter
  class MyThreadSafeClass {
    %PreventCloning;
    ...
  };
  
  # TODO More to come

=head1 DESCRIPTION

C<ExtUtils::XSpp::Plugin::Cloning> is a plugin for C<XS++> (See L<ExtUtils::XSpp>)
for controlling the behavior of a class's objects when the interpreter/thread they
live in is cloned.

=head1 DIRECTIVES

=head2 C<%PreventCloning>

Specify this directive inside your class to prevent objects of the class
from being cloned on thread spawning. They will simply be undefined in the
new interperter/thread.

=cut

sub register_plugin {
  my ($class, $parser) = @_;

  $parser->add_class_tag_plugin(
    plugin => $class->new,
    tag    => '%PreventCloning',
  );
}

sub handle_class_tag {
  my ($self, $class, $tag, %args) = @_;
  warn $tag;
  use Data::Dumper; warn Dumper \%args;
  return 1;
}


1;
__END__

=head1 AUTHOR

Steffen Mueller <smueller@cpan.org>

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
