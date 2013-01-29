Facter.add(:varnishversion) do
  confine :kernel => :linux
  setcode do
    version = Facter::Util::Resolution.exec('rpm -q --queryformat \'%{VERSION}\' varnish')

    if version =~ /^\d+\.\d/
      version
    else
      nil
    end
  end
end
