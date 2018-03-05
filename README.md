# userfacts

This module contains some custom facts about system users.

# Usage

This module currently creates a fact for each local system user in the *user_<username>_is_present* format. For example, if users "john" and "jane" are present then two facts are created:

* *user_john_is_present:* true
* *user_jane_is_present:* true

For windows users the format is *winuser_<username_is_present*. Note that in Windows these outputs are strings. In your puppet module you must use them something like
this:

    $users = ['john', 'jane']
    
    $users.each | $user | {
    
       if $facts["winuser_${user}_is_present"] != 'true' {
          user { "${user}":
          	   ensure     => present,
          	   name       => $user,
          	   comment    => $user,
          	   groups     => [ 'Users' ],
          	   password   => '************',
          	   managehome => true,
          }
       }
    }

All of these facts automatically resolve to true. They are useful for figuring out on which servers a user is present, especially when there are users not managed by Puppet.

# Dependencies

None

# Operating system support

The facts probably work on any *NIX-like operating systems, and Windows. The only caveat is that the UID range used by the facts on *NIX systems may be Linux-specific (1000-60000).
