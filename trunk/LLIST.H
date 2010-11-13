// This is the file to include in your code if you want access to the
// complete LList template class

// First, get the declaration for the base list class

//	#include "list.h"

#ifndef _LLIST_H_
#define _LLIST_H_

#include "Link.h"
#include <iostream>

using namespace std;
// Linked list implementation

class LList {
private:
  Link* head;       // Pointer to list header
  Link* tail;       // Pointer to last elem in list 
  Link* fence;      // Last element on left side
  int leftcnt;            // Size of left partition
  int rightcnt;           // Size of right partition
  void init() {           // Intialization routine
    fence = tail = head = new Link;
    leftcnt = rightcnt = 0;
  }
  void removeall() {   // Return link nodes to free store
    while(head != NULL) {
      fence = head;
      head = head->next;
      delete fence;
    }
  }
public:
  LList() { init(); }
  ~LList() { removeall(); }  // Destructor
  void clear() { removeall(); init(); }
  void setStart()
    { fence = head; rightcnt += leftcnt; leftcnt = 0; }
  void setEnd()
    { fence = tail; leftcnt += rightcnt; rightcnt = 0; }

  void next() {
    if (fence != tail) // Don't move fence if right empty
      { fence = fence->next; rightcnt--; leftcnt++; }
  }
  int leftLength() const  { return leftcnt; }
  int rightLength() const { return rightcnt; }

  bool getValue(string& it) const {
    if(rightLength() == 0) return false;
    it = fence->next->element;
    return true;
  }




bool insert(const string& item) {
  fence->next = new Link(item, fence->next);  
  if (tail == fence) tail = fence->next;  // New tail or shifting tail
  rightcnt++;
  return true;
}


bool append(const string& item) {
  tail = tail->next = new Link(item, NULL);
  rightcnt++;
  return true;
}

// Remove and return first Elem in right partition
 bool remove(string& it) {
  if (fence->next == NULL) return false; // Empty right
  it = fence->next->element;       // Remember value
  Link* ltemp = fence->next; // Remember link node
  fence->next = ltemp->next;       // Remove from list
   if (tail == ltemp) tail = fence; // Reset tail shifting to the left after removing the element 
  delete ltemp;                    // Reclaim space
  rightcnt--;
  return true;
}

// Move fence one step left; no change if left is empty
void prev() {
  Link* temp = head;
  if (fence == head) return; // No previous Elem
  while (temp->next!=fence) temp=temp->next;
  fence = temp;
  leftcnt--; rightcnt++;
}

// Set the size of left partition to pos
bool setPos(int pos) {
  if ((pos < 0) || (pos > rightcnt+leftcnt)) return false;
  fence = head;
  for(int i=0; i<pos; i++) fence = fence->next;
  return true;
}

void print() const {
  Link* temp = head;
  cout << "< ";
  while (temp != fence) {
    cout << temp->next->element << " ";
    temp = temp->next;
  }
  cout << "| ";
  while (temp->next != NULL) {
    cout << temp->next->element << " ";
    temp = temp->next;
  }
  cout << ">\n";
}
};

#endif