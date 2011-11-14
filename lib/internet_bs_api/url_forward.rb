module InternetBsApi
  module Domain
    def add_url_forward(forward_source, forward_target)
      options = {"Source" => forward_source, "Destination" => forward_target}
      connection.post("Domain/UrlForward/Add", options)
    end

    def remove_url_forward
    end

    def update_url_forward
    end

    def list_url_forwards
    end
  end
end
