/**
 * Linked List Node
 */
export class ListNode {
  val: number;
  next: ListNode | null;
  
  constructor(val?: number, next?: ListNode | null) {
    this.val = val === undefined ? 0 : val;
    this.next = next === undefined ? null : next;
  }
}

/**
 * Merge Two Sorted Lists - LeetCode #21
 * You are given the heads of two sorted linked lists list1 and list2.
 * Merge the two lists in a one sorted list.
 * 
 * Time Complexity: O(m + n)
 * Space Complexity: O(1)
 */
export function mergeTwoLists(list1: ListNode | null, list2: ListNode | null): ListNode | null {
  const dummy = new ListNode(0);
  let current = dummy;
  
  while (list1 !== null && list2 !== null) {
    if (list1.val <= list2.val) {
      current.next = list1;
      list1 = list1.next;
    } else {
      current.next = list2;
      list2 = list2.next;
    }
    current = current.next;
  }
  
  // Append remaining nodes
  current.next = list1 || list2;
  
  return dummy.next;
}
