class InvalidAssigneeError < StandardError
  def to_s
    'Cannot assign issue to users from another team.'
  end
end
