#ifndef _GRLIST_H_
#define _GRLIST_H_
	
// Used by the mark array
#define UNVISITED 0
#define VISITED 1

//#include "link.h"
#include "LLIST.H"

// Overload for the Edge << operator

class Graph  
{ // Implement adjacency list
private:
  int numVertex, numEdge;     // Number of vertices, edges
  LList** vertex; // List headers
  int* mark;                  // Pointer to mark array
public:
  Graph(int numVert) { // Make graph with numVert vertices
    int i;
    numVertex = numVert;  numEdge = 0;
    mark = new int[numVert]; // Initialize mark array
    for (i=0; i<numVertex; i++) mark[i] = UNVISITED;
    // Create and initialize adjacency lists
    vertex = (LList**) new LList*[numVertex];
    for (i=0; i<numVertex; i++)
      vertex[i] = new LList;
  }

  ~Graph() {       // Destructor
    delete [] mark; // Return dynamically allocated memory
    for (int i=0; i<numVertex; i++) delete  vertex[i];//[]
    delete [] vertex;
  }

  int n() { return numVertex; } // Number of vertices
  int e() { return numEdge; }   // Number of edges

  string first(int v) { // Return first neighbor of v
    string it;
    vertex[v]->setStart();
    if (vertex[v]->getValue(it)) return it;
    else return "null";  // Return n if none
  }

  string next(int v1, int v2) { // Gete v1's neighbor after v2; v1 and v2 are indices in the graph
    string it;
	vertex[v1]->setStart();
    for(int i=0;i<v2;i++)
		vertex[v1]->next();
    if (vertex[v1]->getValue(it)) return it;
    else return"null";  // Return n if none
  }

  // Set edge (v1, v2) to wgt
  void setEdge(int v1, int v2,string it) {
    //Assert(wgt>0, "Illegal weight value");

   for(int i=0;i<v2;i++)
	   vertex[v1]->next();
    numEdge++;
    vertex[v1]->insert(it);
  }

 /* void delEdge(int v1, int v2) { // Delete edge (v1, v2)
    Edge curr;
    vertex[v1]->getValue(curr);
    if (curr.vertex != v2)  // If not already there, search
      for (vertex[v1]->setStart();
           vertex[v1]->getValue(curr); vertex[v1]->next())
        if (curr.vertex >= v2) break;
    if (curr.vertex == v2) {  // If not, then there is none
      vertex[v1]->remove(curr);
      numEdge--;
    }
  }

  int weight(int v1, int v2) { // Return weight of (v1, v2)
    Edge curr;
    vertex[v1]->getValue(curr);
    if (curr.vertex != v2) // If not already there, search
      for (vertex[v1]->setStart();
           vertex[v1]->getValue(curr); vertex[v1]->next())
        if (curr.vertex >= v2) break;
    if (curr.vertex == v2)
      return curr.weight;
    else
      return 0;  // No such edge
  }
*/
  int getMark(int v) { return mark[v]; }
  void setMark(int v, int val) { mark[v] = val; }
void print(  ) 
{
  int i, j;

  cout << "Number of vertices is " << Graph::n() << "\n";
  cout << "Number of edges is " << Graph::e() << "\n";

  cout << "Matrix is:\n";
  for (i=0; i<Graph::n(); i++) 
  {
    for(j=0; j<Graph::n(); j++)
      cout << Graph::next(i, j) << " ";
    cout << "\n";
  }
   }
 
};

//#include "graphutil.cpp"

#endif