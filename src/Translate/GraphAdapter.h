
#ifndef GRAPHADAPTER_H
#define GRAPHADAPTER_H

#include "GRAPH.h"
#include "graphZ.h"
static string Var = "Variable";
static string Lit = "Literal";
typedef ProgGraph<string,string>  GraphZ;
/**\file GraphAdapter.h
 *\brief Contains the classes that serve as adapters from our Graph to Professor's Zaraket Graph
 *  
 */

/**\class AdaptorZtoG
 
 *\brief has the interface of ProgGraph but implements the functions using Graph logic
 * If one needs to use our graph in the code that one has written all that needs to be done is to declare a variable of type AdaptorZtoG and continue as if he/she was using a ProgGraph
 */
 
class AdaptorZtoG : public ProgGraph<string,string>
{
private:
	
		/**\function TypeToString
		 *\param myType 
		 *\brief Translate from Enum NodeType to String
		 *\return string
		 */
	string TypeToString (NodeType myType )
	{
		if (myType == Variable)
		{
			return"Variable";
		}
		else if (myType == Literal)
		{
			return"Literal";
		}
		else if (myType == Expression)
		{
			return "Expression";
		}
		else 
		{
			return "Statement";
		}
	
	}
	
	/**\function translateProgNode
	 *\param a type ProgNode
	 *\brief Converts from ProgNode to Node by setting node name and node index according to ProgNode's values  
	 *\return Node
	 */
	
	Node* translateProgNode (ProgNode* a)
	{
		
		NodeType myType;
		
		if (myType == Expression)
		{
			Node* b = new Node("Expression");
			b->nodeIndex = a->idx;
			return b;
		}
		if (myType == Statement)
		{
			Node* b = new Node("Statement");
			b->nodeIndex = a->idx;
			return b;
		}
		Node* b = new Node(a->data);
		b->nodeIndex = a->idx;
		return b;
		
	}

	
public:
	/**\var Adapted
	 *\brief Graph that Z functions will use
	 */
	Graph Adapted;
	
	AdaptorZtoG()
	{
	
	
	}
	
	
	/**\function addNode
	 *\param ProgNode
	 *\return ProgNode
	 *\brief translates ProgNode to a node and calls addNewNode returns node if it has been successfully added
	 */
	ProgNode& addNode(ProgNode* node)
	{
		Adapted.addNewNode(translateProgNode (node));
		return *node;
	}
	/**\function addEdge
	 *\param ProgNode from
	 *\param ProgNode to
	 *\param string w
	 *\return ProgNode
	 *\brief Finds Equivalent node in Adapted Graph and adds edge between by calling Graph :: addEdge function
	 */
	ProgEdge & addEdge(ProgNode * from, ProgNode * to, string & w) 
	{
		Node *Origin = Adapted.findNode(translateProgNode(from));
		Node *Destination = Adapted.findNode(translateProgNode(to));
		Adapted.addEdge(Origin,Destination,1);
		if ( Adapted.findNode(translateProgNode(from)) == NULL || Adapted.findNode(translateProgNode(to))==NULL)
		{
			throw NoEdgeExp;
		}
		else
		{
			ProgEdge *returnMe = new ProgEdge (*from,*to,w);
			return *returnMe;
		}
	}
	/**\function removeNode
	 *\param ProgNode
	 *\return ProgNode
	 *\brief Finds ProgNode equivalent Node in Graph and removes it
	 */
	ProgNode* removeNode(ProgNode* node)
	{
		if (Adapted.removeNode(translateProgNode(node)))
		{
			return node;
		}
		else 
			return NULL;
	}
	
	/**\function removeEdge
	 *\param ProgEdge
	 *\return ProgEdge
	 *\brief Finds ProgEdge equivalent Edge in Graph and removes it, it returns the passed edge if it was able to remove and a NULL pointer if it didn't
	 */
	
	ProgEdge* removeEdge (ProgEdge* edge)
	{
		bool foundEdge = false;
		Node *OriginNode = new Node();
		(translateProgNode(&edge->from))->copy(*OriginNode);
		Node *DestNode = new Node();
		(translateProgNode(&edge->to))->copy(*DestNode);
		
		int NumberOfEdges = OriginNode->adjNodeList.size();
		for (int i=0;i < NumberOfEdges;i++) 
		{
			if (OriginNode->adjNodeList[i].getDstNode() == translateProgNode(&edge->to) )
			{
				OriginNode->adjNodeList.erase(OriginNode->adjNodeList.begin() + i);
				foundEdge = true;
			}
		}
		if (foundEdge)
		{
			return edge;
		}
		else 
		{
			return NULL;
		}

		
		
	}
			
};
/**\class ProgNodeFactory
  *\brief Like the name indicates this is the class responsible for the creation of nodes
 */

class ProgNodeFactory
{
	
public:
	
	/**\function NewProgNode
	 *\param Node* n 
	 *\return ProgNode* 
	 *\brief Creates a corresponding subclass of ProgNode instance using a pointer to a Node n 
	 */
	
	static GraphZ::ProgNode *NewProgNode(Node * n)
	{
		if (n->getType() == "Variable")
		{
			
			GraphZ::ProgVar * a = new GraphZ::ProgVar(Var,n->name);
			a->idx = n->nodeIndex;
			return a;
			
		}
		else if (n->getType()=="Literal")
		{
			GraphZ::ProgLit * a = new GraphZ::ProgLit(Lit,n->name);
			a->idx = n->nodeIndex;
			return a;
		}		
		else if (n->getType()=="Expression")
		{
			GraphZ::ProgExpr * a = new GraphZ::ProgExpr(n->name);
			a->idx = n->nodeIndex;
			return a;
		}
		
		else 
		{
			GraphZ::ProgStmt * a = new GraphZ::ProgStmt(n->name);
			a->idx = n->nodeIndex;
			return a;
		}
		
	}

};

/**\class AdaptorGtoZ
 *\brief has the interface of Graph but implements the functions using ProgGraph logic
 * If one needs to use the Z graph in the code that one has written with g graph functions, all that needs to be done is to declare a variable of type AdaptorGtoZ and continue as if he/she was using a ProgGraph
 */

class AdaptorGtoZ : public Graph
{
	private :
	
	/**\function translateProgNode
	 *\param a type ProgNode
	 *\brief Converts from ProgNode to Node by setting node name and node index according to ProgNode's values  
	 *\return Node
	 */
	
	Node* translateProgNode (GraphZ::ProgNode* a)
	{
		
		GraphZ::NodeType myType;
		
		if (myType == GraphZ::Expression)
		{
			Node* b = new Node("Expression");
			b->nodeIndex = a->idx;
			return b;
		}
		if (myType == GraphZ::Statement)
		{
			Node* b = new Node("Statement");
			b->nodeIndex = a->idx;
			return b;
		}
		Node* b = new Node(a->data);
		b->nodeIndex = a->idx;
		return b;
		
	}
	
	

	public :
	
	class MyVisitor 
	{
	
	public:
		bool operator() (GraphZ::ProgNode * node) 
		{
			cout << "node " << node->data << endl;
			return true;
		}
		bool operator() (GraphZ::ProgEdge * edge) 
		{
			cout << "edge " << edge <<  
            " weight " << edge->weight << 
            " from " << edge->from.idx <<
            " to " << edge->to.idx << endl;
			return true;
		}
	};
	
	/**\var ZaGraph
	 *\brief ZGraph that G functions will use
	 */
	
		GraphZ ZaGraph;
		
	/**\function addNewNode
	 *\param node
	 *\brief translates Node to a ProgNode and calls addNode 
	 */
	
	void addNewNode(Node *node)
		{
			GraphZ::ProgNode *addMe;
			addMe = ProgNodeFactory::NewProgNode(node);
			ZaGraph.addNode(addMe);
			cout << " TRIED TO ADD " << endl;
		}
	
	/**\function addEdge
	 *\param from Origin Node
	 *\param to	Destination Node
	 *\param weight int Weight of the edge
	 *\brief Finds Equivalent nodes in ZaGraph  and adds ProgEdge between by calling  zaGraph.addEdge function
	 */

	void addEdge(Node * from, Node* to, int weight)
		{
			string W = "1";
			int fromIndex = from->nodeIndex;
			int toIndex = to->nodeIndex;
			if (ZaGraph.vertices[fromIndex]== NULL)
				throw GraphZ::NullNodeExp;
			if (ZaGraph.vertices[toIndex]==NULL)
				throw GraphZ::NullNodeExp;
			ZaGraph.addEdge(ZaGraph.vertices[fromIndex],ZaGraph.vertices[toIndex],W);
		}
		
	/**\function removeNode
	 *\param myNode Pointer to node to be removed
	 *\return Bool
	 *\brief Finds Node's equivalent ProgNode in ZaGraph and removes it
	 */
	
		bool removeNode( Node *myNode)
		{
			int index= myNode->index;
			if (ZaGraph.vertices[index]== NULL)
				throw GraphZ::NullNodeExp;
			ZaGraph.removeNode(ZaGraph.vertices[index]);
			return true;
		}
	
	/**\function findNodeByName
	 *\param name
	 *\return *Node
	 *\brief Finds Node's equivalent ProgNode in ZaGraph using it's name by using the index value of the nodes and checking in the vector
	 */
	
	
	Node* findNodeByName(string name)
	{
		for(unsigned int i = 0 ; i < ZaGraph.vertices.size() ; i++)
		{
			if(ZaGraph.vertices[i]->data == name)
			{
				return translateProgNode(ZaGraph.vertices[i]);
			}
		}
		return NULL;
	}
	
	/**\function findNodeByName
	 *\param name
	 *\param index numberof times repeated
	 *\return *Node
	 *\brief Finds Node's equivalent ProgNode in ZaGraph using it's name and repetion number (index) by using the index value of the nodes and checking in the vector
	 */
	
	
	Node* findNodeByName1(string name,int &index)
	{
		
		for(unsigned int i = index ; i < ZaGraph.vertices.size() ; i++)
		{
			if(ZaGraph.vertices[i]->data == name)
			{
				return translateProgNode(ZaGraph.vertices[i]);
			}
		}
		return NULL;
	}
	
	/**\function DFS
	 *\param n
	 *\brief traverses the ProgGraph using the DepthFirst class methods and a visitor that outputs node name when it sees a node and outputs origin, destination node and weight of the edges it sees.
	 */
	
	void DFS(Node*n)
	{
		cout << "NUMBER OF NODES : "<< ZaGraph.vertices.size() << endl;
		//if n exists
		MyVisitor LetsVisit;
		GraphZ::DFTraverse<MyVisitor> DepthFirst(LetsVisit,1);
		DepthFirst(ZaGraph);
	}
	
};
#endif