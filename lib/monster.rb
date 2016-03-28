# monster
class Monster
  attr_reader :name
  
  def initialize(opts = {})
    @name = opts['name']
    @skills = opts['skills']
  end

  def random_skills(num, min_dmg, max_dmg)
    num_skills = num.to_i
    return [] unless num_skills > 0
    damage_range = min_dmg..max_dmg
    @skills.sample(num_skills).map do |skill|
      {
        message: skill,
        damage: rand(damage_range)
      }
    end
  end
end
