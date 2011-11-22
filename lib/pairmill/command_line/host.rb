require "pairmill/command_line"

module Pairmill
  class CommandLine
    class Host < self
      def run!
        parse!
        Pairmill::Session.host(options)
      end

      def parse!
        opts = parse do |opts|
          opts.banner = "Usage: #{$0} host [-s SESSION_NAME] [-v PAIR[,PAIR[,...]] [-p PAIR[,PAIR[,...]]" +
                        "\n\n" +
                        "At least one PAIR (of any type must be defined). A PAIR is either a Github username or email address." +
                        "\n\n"+
                        "Options:"

          opts.on("-s", "--session-name=SESSION_NAME", "Automatically generated by server if not provided.") do |session_name|
            options[:name] = session_name
          end

          opts.on("-v", "--viewers=PAIRS", Array) do |pairs|
            options[:viewers] = pairs
          end

          opts.on("-p", "--participants=PAIRS", Array) do |pairs|
            options[:participants] = pairs
          end

          opts.on_tail("-h", "--help", "Display this text") do
            puts opts
            exit
          end
        end

        if options[:viewers].to_a.empty? && options[:participants].to_a.empty?
          $stderr.puts "ERROR: At least one PAIR is required...\n\n"
          abort(opts.inspect)
        end
      end
    end
  end
end
