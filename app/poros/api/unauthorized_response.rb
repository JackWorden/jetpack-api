module API
  class UnauthorizedResponse < ErrorResponse
    def initialize
      super('Unauthorized request', :unauthorized)
    end
  end
end
