class User
  attr_reader :fullname, :gravatar, :email, :github_profile, :cohort_id,
              :dbc_student_id
  
  def initialize(user_attributes)
    user_attributes = HashWithIndifferentAccess.new(user_attributes)
    @fullname = user_attributes['name']
    @gravatar = user_attributes['gravatar']
    @email = user_attributes['email']
    @github_profile = find(user_attributes['id']).profile[:github]
    @cohort_id = find(user_attributes['id']).cohort_id
    @dbc_student_id = user_attributes['id']
  end 

  def find(id)
    raise "WAT" if id.nil?
    DBC::User.find(id)
  end
end 
