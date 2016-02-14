(1..50).each do |i| 
	u = User.new(email: 'test' + i.to_s + '1@gmail.com', password: 'thanks123', student_type: 'imtech', year_of_joining: '2013', roll_no: 'imt20130' +  i.to_s, name: 'test' + i.to_s , phone_number:'9886755139')
	u.save!
	u.skip_confirmation!
end
