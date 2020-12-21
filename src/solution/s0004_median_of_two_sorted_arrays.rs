/**
 * [4] Median of Two Sorted Arrays
 *
 * Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.
 * Follow up: The overall run time complexity should be O(log (m+n)).
 *
 * Example 1:
 *
 * Input: nums1 = [1,3], nums2 = [2]
 * Output: 2.00000
 * Explanation: merged array = [1,2,3] and median is 2.
 *
 * Example 2:
 *
 * Input: nums1 = [1,2], nums2 = [3,4]
 * Output: 2.50000
 * Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
 *
 * Example 3:
 *
 * Input: nums1 = [0,0], nums2 = [0,0]
 * Output: 0.00000
 *
 * Example 4:
 *
 * Input: nums1 = [], nums2 = [1]
 * Output: 1.00000
 *
 * Example 5:
 *
 * Input: nums1 = [2], nums2 = []
 * Output: 2.00000
 *
 *
 * Constraints:
 *
 * 	nums1.length == m
 * 	nums2.length == n
 * 	0 <= m <= 1000
 * 	0 <= n <= 1000
 * 	1 <= m + n <= 2000
 * 	-10^6 <= nums1[i], nums2[i] <= 10^6
 *
 */
pub struct Solution {}

// problem: https://leetcode.com/problems/median-of-two-sorted-arrays/
// discuss: https://leetcode.com/problems/median-of-two-sorted-arrays/discuss/?currentPage=1&orderBy=most_votes&query=

// submission codes start here

impl Solution {
    pub fn find_median_sorted_arrays(nums1: Vec<i32>, nums2: Vec<i32>) -> f64 {
        let size: usize = nums1.len() + nums2.len();
        let guard: usize = size / 2;
        let mut prev: i32 = 0;
        let mut current: i32 = 0;
        let mut i: usize = 0;
        let mut j: usize = 0;
        while i + j <= guard {
            let n1 = nums1.get(i);
            let n2 = nums2.get(j);
            prev = current;
            if n1 == None {
                j += 1;
                current = *n2.unwrap();
                continue;
            }
            if n2 == None {
                i += 1;
                current = *n1.unwrap();
                continue;
            }
            if *n1.unwrap() <= *n2.unwrap() {
                i += 1;
                current = *n1.unwrap();
            } else {
                j += 1;
                current = *n2.unwrap();
            }
        }
        if size % 2 == 0 {
            (prev + current) as f64 / 2.0
        } else {
            current as f64
        }
    }
}

// submission codes end

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_4() {
        assert_eq!(
            Solution::find_median_sorted_arrays(vec![1, 3], vec![2]),
            2.0
        );
        assert_eq!(
            Solution::find_median_sorted_arrays(vec![1, 2], vec![3, 4]),
            2.5
        );
        assert_eq!(
            Solution::find_median_sorted_arrays(vec![0, 0], vec![0, 0]),
            0.0
        );
        assert_eq!(Solution::find_median_sorted_arrays(vec![], vec![1]), 1.0);
        assert_eq!(Solution::find_median_sorted_arrays(vec![2], vec![]), 2.0);
    }
}
