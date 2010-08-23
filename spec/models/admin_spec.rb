require 'spec_helper'

describe Admin do
  it { should allow_mass_assignment_of :email, :password, :password_confirmation, :remember_me }
end
