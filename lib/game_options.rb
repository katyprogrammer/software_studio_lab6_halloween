require_relative './monster.rb'
require_relative './monster_cave.rb'

# options
class GameOptions
  attr_reader :options, :monster_caves

  def self.shared_instance
    @instance
  end

  def self.shared_instance=(instance)
    @instance ||= instance
  end

  def initialize(data)
    parse_options(data)
    damaged_lines = data['damaged_lines']
    @monster_caves = data['monsters'].map do |group|
      monsters = group['charaters'].map do |monster|
        Monster.new(monster)
      end
      MonsterCave.new(group.merge('monsters' => monsters, 'damaged_lines' => damaged_lines))
    end
  end

  def random_monsters(num)
    @monster_caves.sample(num.to_i).map do |cave|
      cave.random_monster(@options)
    end
  end

  private

  # rubocop: disable Metrics/AbcSize
  def parse_options(data)
    @options = {
      min_hp: data['hp']['min'],
      max_hp: data['hp']['max'],
      min_dmg: data['dmg']['min'],
      max_dmg: data['dmg']['max'],
      min_armor: data['armor']['min'],
      max_armor: data['armor']['max'],
      min_loot: data['loot']['min'],
      max_loot: data['loot']['max'],
      num_skills: data['num_skills'] || 3,
      num_damaged_lines: data['num_damaged_lines'] || 2
    }
  end
  # rubocop: enable Metrics/AbcSize
end
