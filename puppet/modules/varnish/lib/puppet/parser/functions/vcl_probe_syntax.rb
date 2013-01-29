module Puppet::Parser::Functions
    newfunction(:vcl_probe_syntax, :doc => <<-'EOS') do |args|
        Test the syntax of threshold and window values within a VCL backend{.probe{}}

        Essentially a parody of Varnish's own source code:
        https://github.com/varnish/Varnish-Cache/blob/2.1/lib/libvcl/vcc_backend.c#L372-402

        Usage:

            vcl_probe_syntax(probe_threshold, probe_window)
        EOS

        begin
            threshold = Integer(args[0])
            window = Integer(args[1])
        rescue ArgumentError
            raise Puppet::ParseError, "probe_threshold or probe_window should be an integer"
        end

        if threshold != 0 or window != 0
            if threshold == 0 and window != 0
                raise Puppet::ParseError, "Must specify probe_threshold with probe_window"
            elsif threshold != 0 and window == 0
                if threshold > 64
                    raise Puppet::ParseError, "probe_threshold must be 64 or less"
                end
            elsif window > 64
                raise Puppet::ParseError, "probe_window must be 64 or less"
            end
            if threshold > window
                raise Puppet::ParseError, "probe_threshold must not be greater than probe_window"
            end
        end
    end
end
