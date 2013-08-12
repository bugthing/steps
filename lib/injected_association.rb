=begin

=end

module InjectedAssociation

  def injected_association( *args )
    args.each do |ass|

      attr_writer "#{ass}_source"
      attr_writer "#{ass}_fetcher"

      define_method "#{ass}_fetcher" do
        fetcher = instance_variable_get("@#{ass}_fetcher")
        fetcher ||= lambda {
          store = instance_variable_get("@#{ass}")
          store ||= []
        }
      end

      define_method "#{ass}_source" do
        source = instance_variable_get("@#{ass}_source")
        source ||= lambda { |*args|
          store = instance_variable_get("@#{ass}")
          h = Hash.new(*args)
          def h.save; return true; end
          h
        }
      end

      define_method "new_#{ass}" do |*args|
        send("#{ass}_source").call(*args).tap do |n|
          self.send("add_#{ass}", n)
        end
      end

      define_method "add_#{ass}" do |addme|
        addme.save
      end

      define_method "#{ass}s" do
        send("#{ass}_fetcher").call
      end

    end
  end

end
