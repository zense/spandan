class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	validates :student_type, inclusion: { in: ['mtech', 'imtech','alumni'] }
	validates :roll_no, uniqueness: true, presence: true
	validates :name, presence: true
	validates :year_of_joining, inclusion: { in: ['2015','2014','2013','2012','2011','2010','2009','2008','2007','2006','2005','2004','2003','2002','2001','2000','1999']}
end