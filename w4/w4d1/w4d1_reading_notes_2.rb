## Design Patterns ##

# Delegation #
# models for building an app to manage a clinic

class Office < ActiveRecord::Base
  belongs_to :doctor
end

class Doctor < ActiveRecord::Base
  has_one :office
  has_many :patients
end

class Patient < ActiveRecord::Base
  belongs_to :doctor
end

# When documenting a patient's appointments we want to ensure we track which office and doctor the patient will be visiting
# A view of this might look something like this

<%= @patient.doctor.name %>
<%= @patient.doctor.specialty %>
<%= @patient.doctor.office.number %>
<%= @patient.doctor.office.address %>

# you should only talk to your neighbors/only use one dot (Law of Demeter)
# => the HTML above is loaded with LoD violations

# One design pattern to overcome LoD violations is to use delegation
# => write getters like this:
class Patient < ActiveRecord::Base
  belongs_to :doctor

  def doctor_name
    doctor.name
  end
end

# this allows us to access the doctors name via the patient like this:
# <%= @patient.doctor_name %>

# how to use the delegate method so that we don't have to write these setters by hand?
# =>  add a woof method to an owner so that owner.woof calls the woof method of their dog
class Owner < ActiveRecord::Base
  has_one :dog
  delegate :woof, to: :dog
end

class Dog < ActiveRecord::Base
  belongs_to :owner

  def woof
    puts "woof"
  end
end


# Chaning the models from above to remove LoD violations
# We can use the :prefix => true option to sensibly prefix our methods

class Office < ActiveRecord::Base
  belongs_to :doctor
end

class Doctor < ActiveRecord::Base
  has_one  :office
  has_many :patients
  delegate :number,
           :address,
           to: :office,
           prefix: true
end

class Patient < ActiveRecord::Base
  belongs_to :doctor
  delegate   :name,
             :specialty,
             :office_number,
             :office_address,
             to: :doctor,
             prefix: true
end

# We can now use our delegate methods in our view.

<%= @patient.doctor_name %>
<%= @patient.doctor_specialty %>
<%= @patient.doctor_office_number %>
<%= @patient.doctor_office_address %>
