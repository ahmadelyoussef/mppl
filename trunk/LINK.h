// Singly-linked list node
#ifndef LINK_H
#define LINK_H

//#include"xstream.h"
#include <string>
using namespace std;

class Link {
public:
  string element;      // Value for this node
  Link *next;        // Pointer to next node in list
  Link(const string& stringval, Link* nextval =NULL)
    { element = stringval;  next = nextval; }
  Link(Link* nextval =NULL) { next = nextval; } 
};

#endif

