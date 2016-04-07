# == Schema Information
#
# Table name: public.users
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  team_id             :integer
#  uid                 :integer
#  name                :string
#  github_access_token :string
#  github_user_id      :integer
#

class User < ActiveRecord::Base
  belongs_to :team
  has_many :issues
end
