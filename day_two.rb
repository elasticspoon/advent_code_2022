class DayTwo
  RULES = {
    'A' => { 'X' => 3, 'Y' => 6, 'Z' => 0 },
    'B' => { 'X' => 0, 'Y' => 3, 'Z' => 6 },
    'C' => { 'X' => 6, 'Y' => 0, 'Z' => 3 }
  }.freeze

  MOVES = { 'X' => 1, 'Y' => 2, 'Z' => 3 }.freeze
  RESULTS = { 'X' => 0, 'Y' => 3, 'Z' => 6 }.freeze

  def self.move_score(move)
    MOVES[move]
  end

  def self.result_score(result)
    RESULTS[result]
  end

  def self.outcome_score(opp_move, own_move)
    RULES[opp_move][own_move]
  end

  def self.expected_shape(opp_move, result)
    RULES[opp_move].key(result)
  end

  def self.round_score(opp_move, own_move)
    move_score(own_move) + outcome_score(opp_move, own_move)
  end

  def self.real_round_score(opp_move, result)
    result_score = result_score(result)
    own_move = expected_shape(opp_move, result_score)
    round_score(opp_move, own_move)
  end

  def self.play_game(input)
    input.split("\n").sum do |round|
      opp_move, own_move = round.split
      round_score(opp_move, own_move)
    end
  end

  def self.play_full_game(input)
    input.split("\n").sum do |round|
      opp_move, result = round.split
      real_round_score(opp_move, result)
    end
  end
end

File.open('day_two_input.txt') do |file|
  input = file.read
  puts DayTwo.play_game(input)
  puts DayTwo.play_full_game(input)
end
