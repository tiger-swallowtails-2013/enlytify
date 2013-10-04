class User
  attr_reader :fullname, :gravatar, :email, :github_profile, :cohort_id, :dbc_student_id
  
  def initialize(user_attributes)
    @fullname = user_attributes['name']
    @gravatar = user_attributes['gravatar']
    @email = user_attributes['email']
    @github_profile = DBC::User.find(user_attributes['id']).profile[:github]
    @cohort_id = DBC::User.find(user_attributes['id']).cohort_id
    @dbc_student_id = user_attributes['id']
  end 

  def find(id)
    DBC::User.find(id)
  end 

  def find_cohort(cohort_id)
    DBC::Cohort.find(cohort_id)
  end

  def list_cohort_names(cohort_id)
    cohort_students = find_cohort(cohort_id).students.map do |student| 
      student.name
    end
    cohort_students
  end
end 
