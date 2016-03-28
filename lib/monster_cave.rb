# monster cave
class MonsterCave
  def initialize(opts = {})
    @type = opts['type']
    @monsters = opts['monsters']
    @damaged_lines = opts['damaged_lines']
    @last_words = opts['last_words']
  end

  # rubocop: disable Metrics/AbcSize
  def random_monster(opts = {})
    monster = @monsters.sample
    {
      type: @type,
      name: monster.name,
      hp: rand((opts[:min_hp].to_i)..(opts[:max_hp].to_i)),
      armor: rand((opts[:min_armor].to_i)..(opts[:max_armor].to_i)),
      skills: monster.random_skills(opts[:num_skills], opts[:min_dmg], opts[:max_dmg]),
      damaged: random_damaged_lines(opts[:num_damaged_lines]),
      'last-words' => gen_last_words(opts[:min_loot], opts[:max_loot])
    }
  end
  # rubocop: enable Metrics/AbcSize

  private

  def random_damaged_lines(num)
    @damaged_lines.sample(num)
  end

  def gen_last_words(min_loot, max_loot)
    [
      @last_words.first,
      rand(min_loot..max_loot).to_s,
      @last_words.last
    ].join(' ')
  end
end
