####### APP LINK

WEBLINK = "http://localhost:3000/"

### T SHIRT SIZES ###
#	used in : RegistrationController, volunteer_registration action
#	stored in db table: volunteer_requests column: tshirt_size

#	-----------------------------
#	Meaning     Stored as in db
#	-----------------------------
#	S			1
#	M			2
#	L			3
#	XL			4
#	XXL			5

TSHIRTSIZES = {:S => 1, :M => 2, :L => 3, :XL => 4, :XXL => 5}

# EVENT TYPE
TEAM=1
CUSTOM=2
INDIVIDUAL=0