#!/usr/local/bin/ruby -w

# == Synopsis
# word_count: Counts the number of words in a file
#
# == Usage
# word_count [options] -- file_path
#
# -h, --help:
#    show help
#
# -m n, --min n:
#    minimum of n letters in the word (default is 2)
#
# file_path: the file path of the file to read the words from.

# The WordCount class calculates unique and word counts in
# a file.
class WordCount

  # The minimum number of letters which make a word.
  MIN = 2

  attr_reader :file, :title, :min, :count, :word_hash

  # Creates a new WordCount object for the given file name
  # and minimum word length.
  def initialize(file, min = 1)
    @file = file
    @min = min <= 0 ? MIN : min
    @count = 0
    @title = nil
    @word_hash = Hash.new(0)
  end

  # Parses the file.
  def parse
    re = /\w{#{@min},}/
    File.open(@file, "r") do |file|
      while line = file.gets
        line.strip!
        if line.length > 0
          @title = line unless @title
          words = line.scan(re)
          @count += words.length
          words.each { |word| @word_hash[word] += 1 }
        end
      end
    end
    self
  end

  # The unique word count
  def unique_count
    @word_hash.length
  end
  
  # Returns the count summary.
  def to_s
    "File: #{@file} title: '#{@title}' min: #{@min} total: #{@count} unique: #{unique_count}"
  end
end

# Run the application.
if __FILE__ == $PROGRAM_NAME # aka $0

  require 'getoptlong'
  require 'rdoc/usage'

  min = WordCount::MIN
  path = nil
  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--min', '-m', GetoptLong::REQUIRED_ARGUMENT ]
  )
  opts.each do |opt, arg|
    case opt
      when '--help'
        RDoc.usage
        exit 0
      when '--min'
        min = arg.to_i
    end
  end

  if ARGV.length != 1
    puts "Missing file_path argument (try --help)"
    exit(-1)
  end
  path = ARGV.shift
  unless File.exists?(path) && File.file?(path) && File.readable?(path)
    puts "File path #{path} doesn't exist, isn't a file, or can't be read"
    exit(-1)
  end

  puts WordCount.new(path, min).parse.to_s
  exit 0

end