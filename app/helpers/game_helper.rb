module GameHelper
  def printp(pno,data)
    name =""
    if(data==1)
        name=Team.find(pno)
    else
        name=User.find(pno)
      end
    return name.name 
  end
end
