# frozen_string_literal:true

# class which realize soccer logic
class SoccerLogic
  def initialize
    @clubs = {}
    main
  end

  def main
    check_args
    fill_clubs_names
    fill_clubs_score
    sort!
    print
  end

  private

  def check_args
    return if ARGV.length == 1

    puts 'Args error. The program will close'
    exit
  end

  def fill_clubs_names
    File.foreach(ARGV[0]) do |line|
      row = line.split(',')
      row.map! do |club|
        var = club.strip
        var = var.reverse.sub(' ', '|').reverse
        current_club = var.split('|')
        @clubs[current_club[0].to_sym] = 0
      end
    end
  end

  def fill_clubs_score
    file = File.open(ARGV[0])
    file.each { |line| find_match_score(line) }
    file.close
  end

  def find_match_score(line)
    arr = prepare_line(line)
    arr.map! { |sub_array| sub_array.split('|') } # [ ["Lions", "3"], ["Snakes", "3"] ]

    if arr[0][1].to_i > arr[1][1].to_i
      change_score(arr[0][0], 3)
    elsif arr[0][1].to_i < arr[1][1].to_i
      change_score(arr[1][0], 3)
    else
      change_score(arr[0][0], 1)
      change_score(arr[1][0], 1)
    end
  end

  def change_score(arr, points)
    @clubs[arr.to_sym] += points
  end

  def prepare_line(line)
    arr = line.chomp.split(', ')
    arr[0][-4..-1] = arr[0][-4..-1].tr(' ', '|')
    arr[1][-4..-1] = arr[1][-4..-1].tr(' ', '|')
    arr
  end

  def sort!
    @clubs = @clubs.sort_by { |_, v| v }.reverse
  end

  def print
    row_number = 1
    @clubs.each do |line|
      item = line[1] == 1 ? 'pt' : 'pts'

      puts "#{row_number}. #{line[0]}, #{line[1]} #{item}"
      row_number += 1
    end
  end
end

SoccerLogic.new
