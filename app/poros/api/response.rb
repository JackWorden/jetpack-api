module API
  class Response
    attr_reader :data, :status

    def initialize(data, status = :ok)
      @data = data
      @status = status
    end
  end
end
