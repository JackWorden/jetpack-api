module API
  class ErrorResponse < Response
    def initialize(data, status = :internal_server_error)
      super({ errors: data }, status)
    end
  end
end
