# frozen_string_literal:true

# class which gets input
class MyReader
  attr_reader :clubs
  def check_args
    if ARGV.length != 1
      puts 'Args error. The program will close'
      exit
    end
    @clubs = {}
  end

  def fill_clubs_names
    file = File.open(ARGV[0])
    file.each do |line|
      club_row = line.split(',')
      puts "club row |#{club_row}|"
      # TODO improve finding club name (now supposed to score cant be > 9) strip[0..-3].to_sym
      # club_row.each { |club| @clubs[club.strip[0..-3].to_sym] = 0 }
      club_row.map! do |club|
        var = club.strip
        var = var.reverse.sub(' ', '|').reverse
        var.split('|')
      end
      puts "club row final |#{club_row}|\n\n"
    end
    file.close
  end

  def fill_clubs_score
    file = File.open(ARGV[0])
    file.each { |line| find_match_score(line) }
    file.close
  end

  def find_match_score(line)
    arr = prepare_line(line)
    # puts "final arr #{arr} - #{arr.class}"
    arr[0] = arr[0].split('|')
    arr[1] = arr[1].split('|')
    # puts "final arr #{arr} - #{arr.class}"

    # arr = my_line.split(', ')
    # puts "Splitted arr #{arr}"

    if arr[0][1].to_i > arr[1][1].to_i
      # puts "arr [0][0] #{arr[0][0]} = #{@clubs[arr[0][0]]}"
      @clubs[arr[0][0].to_sym] += 3
    elsif arr[0][1].to_i < arr[1][1].to_i
      @clubs[arr[1][0].to_sym] += 3
    else
      # puts " qweqw #{arr[0][0]} #{@clubs[arr[0][0]]}"
      puts "clubs === #{@clubs}"
      puts "first #{arr[0][0]}"
      puts "arr |#{@clubs[arr[0][0].to_sym]}|"
      @clubs[arr[0][0].to_sym] += 1
      @clubs[arr[1][0].to_sym] += 1
    end
    # puts "clubs #{@clubs}"
  end

  def prepare_line(line)
    # puts "line #{line}"
    arr = line.chomp.split(', ')
    # puts "arr[0][-4..-1] |#{arr[0][-4..-1]}|#{arr[0][-4..-1].class}"
    # puts "arr--- #{ arr[0][-4..-1].tr(' ', '|')}"
    # puts "arr[1] #{arr[1]}"
    arr[0][-4..-1] = arr[0][-4..-1].tr(' ', '|')
    arr[1][-4..-1] = arr[1][-4..-1].tr(' ', '|')
    # puts "before split #{arr}"
    # puts "split 0  #{arr[0].split}"
    # puts "split 1  #{arr[1].split}"
    # puts "arr #{arr}"
    arr
  end

  def print
    @clubs.sort_by { |k,v| v }.reverse!
  end

  def initialize
    check_args
    fill_clubs_names
    fill_clubs_score
    print
    # puts @clubs
  end
end

MyReader.new
