module IBS
  module InternetBsApi
    module Domain
      module UrlForward
        def add(forward_source, forward_target)
          options = {"Source" => forward_source, "Destination" => forward_target}
          connection.post("Domain/UrlForward/Add", options)
        end

        def remove
        end

        def update
        end

        def list
        end
      end
    end
  end
end
