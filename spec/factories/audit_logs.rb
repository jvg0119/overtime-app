FactoryGirl.define do
  factory :audit_log do
    user 
    status 0
    start_date (Date.today - 6.days) # the data should be 1 week ago 
    end_date nil # nil for now ## this will be sent on Sunday afternoon or evening
  end
end

