# == Schema Information
#
# Table name: public.users
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  team_id        :integer
#  uid            :integer
#  name           :string           not null
#  github_user_id :integer          not null
#

class User < ActiveRecord::Base
  belongs_to :team
  has_many :issues
end
