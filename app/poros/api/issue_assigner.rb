module API
  class IssueAssigner
    class << self
      def assign!(team, issue, user)
        raise InvalidAssigneeError unless user_in_team?(team, user)
        issue.update!(assignee: user)
      end

      def unassign!(issue)
        issue.update!(assignee: nil)
      end

      private

      def user_in_team?(team, user)
        team.users.include?(user)
      end
    end
  end
end
