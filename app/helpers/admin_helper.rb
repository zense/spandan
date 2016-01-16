module AdminHelper
  def printPriority(pno)
    event = Event.find(pno)
    return event.name + '( ID: ' + event.id.to_s + ')'
  end

  def tshirt(size)
    if size==1
      return 'S'
    elsif size==2
      return 'M'
    elsif size==3
      return 'L'
    elsif size==4
      return 'XL'
    elsif size==5
      return 'XXL'
    end
  end
end
