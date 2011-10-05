require 'pathname'
require 'word_count'

# Add a method to our existing class
class WordCount

  attr_accessor :url
  
  # Return the count for a specific word
  def word_count(word)
    (count = @word_hash[word]) ? count : 0
  end
end

# Holds the result of a word search
class Result

  attr_reader :url, :title, :count
    
  def initialize(wc, count)
    @url = wc.url
    @title = wc.title
    @count = count
  end

  # Compare two results for ordering
  def <=>(other)
    return @title <=> other.title if @count == other.count
    other.count <=> @count
  end
end

# The search engine
class SearchEngine

  attr_reader :files

  def initialize(path, remove, add)
    @files = []
    path = Pathname.new(path)
    path.each_entry do |file|
      file = path + file
      if file.file? && file.readable?
        url = file.to_s
        wc = WordCount.new(url, WordCount::MIN)
        wc.parse
        wc.url = url.index(remove) == 0 ? add + url[remove.length..-1] : url
        @files << wc
      end
    end
  end

  # Return an array of the matching results
  def search(word)
    results = []
    if word.length > 0
      @files.each do |wc|
        count = wc.word_count(word)
        results << Result.new(wc, count) if count > 0
      end
    end
    results.sort
  end
end