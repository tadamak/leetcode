# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Float}
def find_median_sorted_arrays(nums1, nums2)
  size = nums1.size + nums2.size
  guard = size / 2
  prev = nil
  current = nil
  i = 0
  j = 0
  while i + j <= guard do
    # puts "prev:#{prev}, current:#{current}, pos:#{i + j}, guard:#{guard}"
    n1 = nums1[i]
    n2 = nums2[j]
    prev = current || 0
    unless n1
      j += 1
      current = n2
      next
    end
    unless n2
      i += 1
      current = n1
      next
    end
    if n1 <= n2
      i += 1
      current = n1
    else
      j += 1
      current = n2
    end
  end
  # puts "  prev:#{prev}, current:#{current}"
  size.even? ? (prev + current) / 2.0 : current.to_f
end

require "rspec/expectations"
include RSpec::Matchers

expect(find_median_sorted_arrays([1, 3], [2])).to eq 2.0
expect(find_median_sorted_arrays([1, 2], [3, 4])).to eq 2.5
expect(find_median_sorted_arrays([0, 0], [0, 0])).to eq 0.0
expect(find_median_sorted_arrays([], [1])).to eq 1.0
expect(find_median_sorted_arrays([2], [])).to eq 2.0
