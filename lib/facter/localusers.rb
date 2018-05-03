if Facter.value(:kernel) != 'windows'
  require 'etc'

  Etc.passwd do |entry|
    # Normal users have IDs in this range in /etc/login.defs
    if entry.uid >= 1_000 && entry.uid <= 60_000
      Facter.add("user_#{entry.name}_is_present") do
        setcode do
          true
        end
      end
    end
  end
end
