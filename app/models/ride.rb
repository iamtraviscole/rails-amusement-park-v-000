class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if !enough_tickets? && !tall_enough?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif !enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif !tall_enough?
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    else
      start_ride
    end
  end

  def enough_tickets?
    self.user.tickets >= self.attraction.tickets
  end

  def tall_enough?
    self.user.height >= self.attraction.min_height
  end

  def start_ride
    self.user.update(
      tickets: self.user.tickets - self.attraction.tickets,
      nausea: self.user.nausea + self.attraction.nausea_rating,
      happiness: self.user.happiness + self.attraction.happiness_rating
    )
    "Thanks for riding the #{self.attraction.name}!"
  end



end
