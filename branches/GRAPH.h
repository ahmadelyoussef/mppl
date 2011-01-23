#ifndef _GRAPH_H_
#define _GRAPH_H_

/*! \mainpage Mini Parser documentation
 *
 * The Mini Language is the first language that provides both efficiency and simplicity ! It's documentation is very large and you can become an expert programmer in less than 2 weeks or you'll get your money back !!
*
*/

/**\file GRAPH.h
*\brief The graph in which the program will be stored
*
*/


#include <vector>
#include <stack>
#include <string>
#include <iostream>
#include "graphZ.h"
/* \typedef ThegraphZ
*\brief Professor Zaraket's graph typedef'ed into "ThegraphZ" 
*
*/
typedef ProgGraph<string,string> ThegraphZ;
using namespace std;
static string Lit = "Literal";// <! Literal ;
static string Exp = "Expression";
static string Var = "Variable" ;
static string Sta = "Statement";

/*! enum Graph::Status
 * indicates the status of the node visited or not.
 */

enum Status {
NOT_VISITED,
VISITED
};

//forward declaration

/**\class Graph
*\brief Describes the graph that will hold the program
*
*/
/**\class Node
 *\brief Describes a node in the graph
 *
 */
class Node;
/**\class Edge
* \brief An object of this class represents an edge in the graph.
* It contains 2 pointer to nodes and the weight of the edge
*/
class Edge
{
private:
/**\var orgNode
*\brief Origin node of the edge
*/
Node *orgNode;
Node *dstNode;//the destination vertex
unsigned cost;//cost of the edge

public:
/**\function Edge
*\brief Constructor
*/
Edge(Node *firstNode, Node *secNode, unsigned inCost)
{
orgNode = firstNode;
dstNode = secNode;
cost = inCost;
}

/** \function getDstNode
* \brief Returns the destination node attached to the edge
 */

Node* getDstNode()
{
return dstNode;
}
/** \function getOrgNode
* \brief Returns the origin node attached to the edge
*/
	
Node* getOrgNode()
{
return orgNode;
}
	/** \function getCost
	 * \brief Returns edge weight
	 */
unsigned getCost()
{
return cost;
}
};

/**\class Edge
 * \brief An object of this class holds a node of the graph.

 */

class Node
{
public:
string name;
	/*\var name 
	*\	brief node name	  
	 */
	/*\var index 
	 *\brief node index helpful in DFS	  
	 */
int index;
	/*\var found 
	 *\brief In addition to status this node is used for the search function in the graph	  
	 */
bool found;
	/*\var adjNodeList
	 *\brief List of outgoing edges for this vertex
	 */
vector<Edge> adjNodeList;
	/*\var adjNodeList
	 *\brief List of outgoing edges for this vertex
	 */
	
	/*! enum Node::Status
	 * \briefindicates the status of the node visited or not used in dfs
	 */
enum Status status;

	/**\function Node
	 *\brief Constructor: sets node of name
	 *\param ID node name
	 */
Node(string id)
{
name = id;
status = NOT_VISITED;
found=false;
}
	/**\function Node
	 *\brief Default Constructor
	 */
Node()
{name = ""; status = NOT_VISITED; index=0;found=false;}
//do not del the adj nodes here...they will be deleted by graph destructor
~Node()
{
adjNodeList.clear();
}
	
	
	/**\function getType
	 *\brief gives a type used when translating graph 
	 *\return string nodeType
	 */
	
string getType()
	{
		if(name=="Begin" || name=="Declaration"|| name=="Assignment"|| name=="conditionalStatement"|| name=="Loop"||name=="is"|| name=="oris"|| name=="isnot"|| name=="Start" || name=="\"=\"" || name=="End"
		   || name=="greater" || name=="Increment" || name=="IntDecl" ||name=="ArrayDecl" ||name=="PairDecl"||name=="BoolDecl" ||name=="BoolDecl" || name=="int" || name == "boole" || name == "Pair" || name == "Array")
		{ 
			
			return "Statement";
			
		}       
        
		else if (name=="not" || name=="\"_\"" || name=="\"*\""  ||name=="\"+\"" || 
				 name=="\"/\"" ||name=="exp" ||name=="mod"||name=="\"*\"" ||name=="\"-\"" ||name=="lt" ||name=="lte"
				 ||name=="gt" ||name=="gte" ||name=="eq" ||name=="neq" ||name=="gte" ||name=="and" ||name=="or"
				 ||name=="xor" )
		{
			return "Expression";
		}
		
		else if(adjNodeList.size()==0 &&( (atoi(name.c_str()))!=0 || name == "0"))
		{
			return "Literal";
		}	
		
		
		else
		{
			return "Variable";
		}
		
	
	
	
	}
	/**\function SetName
	 *\brief Sets Node Name 
	 *\param nam Node Name
	 */
void SetName(string nam)
{
name = nam;
}
	/**\function copy
	 *\brief copies node 
	 *\param n Node to be copied
	 */
void copy(Node &n)
{
        n.adjNodeList = getAdjNodeList() ;
        n.name = name;
}
	/**\function getStatus
	 *\brief Gets node status 
	 *\return Enum f type Status
	 */
enum Status getStatus()
{
return status;
}
	/**\function getStatus
	 *\brief Sets node status 
	 *\param Enum st type Status 
	 */
void setStatus(enum Status st)
{
status = st;
}
	/**\function getName
	 *\brief Gets node name 
	 *\return a string  ( node name )
	 */
string getName()
{
return name;
}

	/**\function addAdjNode
	 *\brief Attaches a node to another by creating an edge between them and adding it to the graph 
	 *\param adj The destination node
	 *\param cost Weight of edge between the nodes
	 */
	
void addAdjNode(Node *adj, unsigned cost)
{
//create an edge with 'this' as the originating node and adj as the destination node
Edge newEdge(this, adj, cost);
adjNodeList.push_back(newEdge);
}

	/**\function getAdjNodeList
	 *\brief Return the list of edges attached to a given node
	 *\return Vector of Edge
	 *
	 */	
	
vector<Edge>& getAdjNodeList()
{
return adjNodeList;
}

	/**\function visit
	 *\brief sets node Status to Visited
	 */
	
void visit()
{
	status=VISITED;
}
	/**\function visitB
	 *\brief the aspect is attached to visit this function was created to be used when we don't want to act on visit , it does the same thing as visit
	 */
void visitB()
{
	status=VISITED;
}
	
};

class Graph
{
public:
	/*\var nodeList
	 *\brief List of verticies  
	 */
vector<Node*> nodeList;
	/*\var nodeList
	 *\brief Is true if a cycle is found, false otherwise
	 */
	bool foundCycle;
	
	/**\function clearVisited
	 *\brief Sets all nodes status to NOT_VISITED
	 */	

void clearVisited()
{
for(unsigned int i = 0; i < nodeList.size() && !foundCycle ; i++)
{
nodeList[i]->setStatus(NOT_VISITED);
}
}

	/**\function copy
	 *\brief Copies a graph to the graph calling it
	 *\param a the Graph to be copied
	 */	
	void copy( Graph& a)
	{
		
		
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
		a.foundCycle=foundCycle ;
		
		
	}
	
	/**\function clear
	 *\brief As the name states clears the graph of all its nodes
	 */	
void clear()
{

nodeList.clear();
vector<Node*> nodeList;

}

	/**\function addNewNode
	 *\brief Adds a floating node to the graph
	 *\param nNode Node to be added
	 */		
	
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

	/**\function findNodeByName1
	 *\brief searches graph to find node by starting search at node having the specified index 
	 *\param name Node name that should be found
	 *\param index node number where to start the search
	 */		
	
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

	/**\function appendTo
	 *\brief appends the given graph to the one that's calling it without attaching any node of one to the other
	 *\param g Graph to be appended
	 */		
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


	/**\function DFS
	 *\brief The famous recursive depth first search function visits all nodes in the graph exactly once
	 *\param n Node on which to the traversal
	 */

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


