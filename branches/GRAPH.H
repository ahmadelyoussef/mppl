#ifndef _GRAPH_H_
#define _GRAPH_H_


#include <vector>
#include <stack>
#include <string>

#include <iostream>

using namespace std;


//enum for the status of a node
enum Status {
NOT_VISITED,
VISITED
};

//forward declaration
class Node;

//An object of this class represents an edge in the graph.
class Edge
{
private:
Node *orgNode;//the originating vertex
Node *dstNode;//the destination vertex
unsigned cost;//cost of the edge

public:
Edge(Node *firstNode, Node *secNode, unsigned inCost)
{
orgNode = firstNode;
dstNode = secNode;
cost = inCost;
}

Node* getDstNode()
{
return dstNode;
}

Node* getOrgNode()
{
return orgNode;
}

unsigned getCost()
{
return cost;
}
};

//An object of this class holds a vertex of the graph
class Node
{
public:
string name;
int index;
bool found;
vector<Edge> adjNodeList;//list of outgoing edges for this vertex
enum Status status;//used in dfs to mark the node visited


Node(string id)
{
name = id;
status = NOT_VISITED;
found=false;
}
Node()
{name = ""; status = NOT_VISITED; index=0;found=false;}
//do not del the adj nodes here...they will be deleted by graph destructor
~Node()
{
adjNodeList.clear();
}

void SetName(string nam)
{
name = nam;
}

void copy(Node &n)
{
        n.adjNodeList = getAdjNodeList() ;
        n.name = name;
}

enum Status getStatus()
{
return status;
}

void setStatus(enum Status st)
{
status = st;
}

string getName()
{
return name;
}

void addAdjNode(Node *adj, unsigned cost)
{
//create an edge with 'this' as the originating node and adj as the destination node
Edge newEdge(this, adj, cost);
adjNodeList.push_back(newEdge);
}

vector<Edge>& getAdjNodeList()
{
return adjNodeList;
}

//displays all adjacent verticies of this vertex
void visit()
{
/*if(adjNodeList.size()>0)
{Edge edg1 = adjNodeList[0];
cout << name << " -> " << edg1.getDstNode()->getName();}

for(unsigned int i=1 ; i < adjNodeList.size() ; i++)
{
Edge edg = adjNodeList[i];
cout << " -> " << edg.getDstNode()->getName();
}*/
status=VISITED;
}
};

//An object of class graph holds a directed graph
class Graph
{
public:
vector<Node*> nodeList;//list of verticies
bool foundCycle;//true if a cycle is found, false otherwise
int desiredCycSize;

void clearVisited()
{
for(unsigned int i = 0; i < nodeList.size() && !foundCycle ; i++)
{
nodeList[i]->setStatus(NOT_VISITED);
}
}


 void copy( Graph& a)
{
/*

        Node *j,*k,*l;
        j= new Node("");
        k= new Node("");
        l= new Node("");
        (*nodeList[0]).copy(*j);
        (*nodeList[1]).copy(*k);
        (*nodeList[2]).copy(*l);
        a.addNewNode(j);
        a.addNewNode(k);
        a.addNewNode(l);

*/

        Node **(myAr);
        myAr =new Node *[nodeList.size()];
for (unsigned int i=0; i< nodeList.size() ; i++)
{
(myAr[i]) = new Node("");
}
for (unsigned int i=0; i< nodeList.size() ; i++)
{
                (*nodeList[i]).copy(*myAr[i]);
                a.addNewNode(myAr[i]);
}
//displayGraph();

a.foundCycle=foundCycle ;
a.desiredCycSize=desiredCycSize ;

}
void clear()
{
//for(unsigned int i=0 ; i < nodeList.size() ; i++)
//delete nodeList[i];
nodeList.clear();
vector<Node*> nodeList;

}

void addNewNode(Node *nNode)
{
nodeList.push_back(nNode);
}

Node* findNodeByName(string name)
{
for(unsigned int i = 0 ; i < nodeList.size() ; i++)
{
if(nodeList[i]->getName() == name)
return nodeList[i];
}
return NULL;
}

Node* findNodeByName1(string name,int &index)
{

for( int i = index ; i < nodeList.size() ; i++)
if(nodeList[i]->getName() == name && !nodeList[i]->found)
{ index=i+1;  nodeList[i]->found=true;
return nodeList[i];
}
   return NULL;
}


Graph()
{
foundCycle = false;
}

~Graph()
{
//free mem allocated to verticies
for(unsigned int i=0 ; i < nodeList.size() ; i++)
delete nodeList[i];
nodeList.clear();
}

void appendTo( Graph &g )
{
        Node **(myAr);
        myAr =new Node *[nodeList.size()];
        for (unsigned int i=0; i< nodeList.size() ; i++)
        {
        (myAr[i]) = new Node("");
        }
        for (unsigned int i=0; i< nodeList.size() ; i++)
        {
                (*(nodeList[i])).copy(*myAr[i]);
                g.addNewNode(myAr[i]);

        }


}




void DFS(Node*n)
{

n->visit();
for(int i=0;i<n->adjNodeList.size();i++)
{

Edge edg=n->adjNodeList[i];
if( edg.getDstNode()->status==NOT_VISITED)
DFS(edg.getDstNode());

}
}



};



#endif


