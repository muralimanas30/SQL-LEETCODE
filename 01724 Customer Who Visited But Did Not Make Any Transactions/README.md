# 01724 - Customer Who Visited But Did Not Make Any Transactions
    
**Language:** Mysql  
**Runtime:** 1421 ms (Beats 43.16% of users)  
**Memory:** 0B (Beats 100.00% of users)  

## 📝 **LeetCode Problem**
| 🔢 Problem Number | 📌 Title | 🔗 Link |
|------------------|--------------------------|--------------------------|
| 153 | Find Minimum in Rotated Sorted Array | [LeetCode Problem](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/) |

---

## 💡 **Problem Explanation**

Given a sorted array `nums` of unique elements that has been rotated at some unknown pivot index, find the minimum element in the rotated array. For example, the array `[4, 5, 6, 7, 0, 1, 2]` is a rotated version of `[0, 1, 2, 4, 5, 6, 7]`. The task is to find the smallest element in this rotated array efficiently.

**Example:**

Input: `nums = [3,4,5,1,2]`
Output: `1`

Input: `nums = [4,5,6,7,0,1,2]`
Output: `0`

---

## 📊 **Algorithm**

*   Initialize two pointers, `left` and `right`, to the start and end of the array, respectively.
*   Use binary search to find the index of the minimum element.
*   While `left` is less than `right`, calculate the middle index `mid`.
*   If `nums[mid]` is greater than `nums[right]`, the minimum element is in the right half of the array.  So, update `left = mid + 1`.
*   Otherwise, the minimum element is in the left half or is `nums[mid]` itself. Update `right = mid`.
*   When the loop finishes (`left == right`), `nums[left]` will be the minimum element.
*   Return `nums[left]`.

## 🔥 **Code Implementation**

```python
class Solution:
    def findMin(self, nums: List[int]) -> int:
        left, right = 0, len(nums) - 1

        while left < right:
            mid = (left + right) // 2

            if nums[mid] > nums[right]:
                left = mid + 1
            else:
                right = mid

        return nums[left]
```

## 📊 **ASCII Representation**

The problem involves a rotated sorted array, visualized linearly:

```
Array: [4, 5, 6, 7, 0, 1, 2]
```

During binary search, we adjust the `left` and `right` pointers:

```
Initial:
L               R
4  5  6  7  0  1  2

Iteration 1: mid = (0+6)//2 = 3
L        M        R
4  5  6  7  0  1  2
nums[mid] > nums[R] => left = mid + 1

Iteration 2:
           L    R
4  5  6  7  0  1  2
nums[mid] < nums[R] => right = mid

... and so on until L == R
```

## 📊 **WORKING**

Consider `nums = [4, 5, 6, 7, 0, 1, 2]`

1.  Initialize `left = 0`, `right = 6`.

2.  **Iteration 1:**

    *   `mid = (0 + 6) // 2 = 3`
    *   `nums[mid] = nums[3] = 7`, `nums[right] = nums[6] = 2`
    *   Since `nums[mid] > nums[right]`, update `left = mid + 1 = 4`

3.  **Iteration 2:**

    *   `left = 4`, `right = 6`
    *   `mid = (4 + 6) // 2 = 5`
    *   `nums[mid] = nums[5] = 1`, `nums[right] = nums[6] = 2`
    *   Since `nums[mid] < nums[right]`, update `right = mid = 5`

4.  **Iteration 3:**

    *   `left = 4`, `right = 5`
    *   `mid = (4 + 5) // 2 = 4`
    *   `nums[mid] = nums[4] = 0`, `nums[right] = nums[5] = 1`
    *   Since `nums[mid] < nums[right]`, update `right = mid = 4`

5.  Now, `left = 4` and `right = 4`, so the loop terminates.

6.  The minimum element is `nums[left] = nums[4] = 0`.

## 🚀 **Time & Space Complexity**

*   **Time Complexity:** **O(log n)** because we are using binary search to reduce the search space by half in each iteration.

*   **Space Complexity:** **O(1)** as we are using only constant extra space.
    