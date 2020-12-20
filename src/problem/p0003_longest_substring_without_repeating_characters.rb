require "pry"
require "set"

# @param {String} s
# @return {Integer}
def length_of_longest_substring(s)
  max_length = 0
  str = ""
  s.each_char do |ch|
    if str.include?(ch)
      max_length = [max_length, str.length].max
      str = str[(str.index(ch) + 1)..-1] # 被った文字の初出の次から
    end
    str << ch
  end
  [max_length, str.length].max
end

require "rspec/expectations"
include RSpec::Matchers

expect(length_of_longest_substring("abcabcbb")).to eq 3 # abc
expect(length_of_longest_substring("bbbbb")).to eq 1 # b
expect(length_of_longest_substring("pwwkew")).to eq 3 # wke
expect(length_of_longest_substring("")).to eq 0
expect(length_of_longest_substring(" ")).to eq 1
expect(length_of_longest_substring("dvdf")).to eq 3
expect(length_of_longest_substring("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~ abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~ abcdefghijklmnopqrstuvwxyzABCD")).to eq 95
