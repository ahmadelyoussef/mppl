class Translator 
{

	/* *\class Translator
	 *\brief Contains functions that are used in the translation from one graph type to another
	 */
	typedef ProgGraph<string,string> GraphZ;
	public :
	string Var;
	string W;
	string Lit;
	bool isRootG;
	
	GraphZ graphZ;
	Graph ourGraph;
	Translator()
	{
	Lit = "Literal";
	Var = "Variable";
	W="a";
/* *\var isRootG
 *\brief Used in the traversal to know that node is root
 * All nodes are destination nodes except the root node. isRootG is there to avoid creating some nodes twice and create root node only in the beginning
*/
	isRootG = true;
	/**\typedef GraphZ
	 *\brief Defining a ProgGraph<string,string> as GraphZ
	 
	 */
		
	
	}
	/**\file Translator.h
	 *\brief Contains the Translator functions that convert a graph of our format to the supplied one  
	 */
	
	/**\function translateNode 
	 *\brief Translate node from Node to ProgNode
	 *\param Node to be translated
	 *\return Resulting ProgNode
	 */
	GraphZ::ProgNode * translateNode(Node * n)
	{
		if (n->getType() == "Variable")
		{
			
			GraphZ::ProgVar * a = new GraphZ::ProgVar(n->name,Var);
			a->idx = n->nodeIndex; 
			return a;
			
		}
		else if (n->getType()=="Literal")
		{
			GraphZ::ProgLit * a = new GraphZ::ProgLit(n->name,Lit);
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
	/**\function traverseNTranslate 
	 *\brief Traverses the Graph and translates it to a ProgGraph and stores it in graphZ
	 *\param Root Node on which to start the traversal
	 *Note that this function ins called after dfs in main which is why it checks if the node has status VISITED to see if it has not been visited
	 */
	 void traverseNTranslate (Node* n )
	{
		n->visitB();
		if (isRootG)
		{
			graphZ.addNode(translateNode (n)); 
			isRootG = false;
		}
	    for(int i=0;i<n->adjNodeList.size();i++)
		{
			Edge edg=n->adjNodeList[i];
			if( edg.getDstNode()->status==VISITED)
			{
				
				//cout << "i =   " << i << endl;
				graphZ.addNode(translateNode(edg.getDstNode())); // Translate destination node and add it to graph
				cout << "Edge From " << n->name << " to " << edg.getDstNode()->name << endl;
				graphZ.addEdge(translateNode(n),translateNode(edg.getDstNode()),Var);
				
				traverseNTranslate(edg.getDstNode());
			}                         
		}
		
	}
	/**\function translatetoZ 
	 *\brief Calls traverseNTranslate and stores graphZ into the passed GraphZ argument
	 *\param a Graph to translate
	 *\param b GraphZ in which the resulting graph will be stored.
	 */
	void translatetoZ (Graph &a , GraphZ &b)
	{
		
		traverseNTranslate(a.nodeList[0]);
		b=graphZ; // Copy constructor of GraphZ
	}
	
	/**\function translateProgNode
	 *\brief Translates a ProgNode from GraphZ into a Node f
	 *\param a pointer to ProgNode to translate
	 *\return A pointer to equivalent Node
	 */
static Node* translateProgNode(GraphZ::ProgNode* a)
	{
		
			Node* b = new Node(a->data);
			b->nodeIndex = a->idx;
			return b;
	
	}
	/**\class VisitAndTranslate
	 *\brief Translates a ProgGraph to a Graph in a very simple way.

*/
	class ZaConverter { public:
		Graph Converted;
		
		
		bool operator() (GraphZ::ProgNode * node) 
		{
			if (node->idx == 0)
			{
			Converted.addNewNode(translateProgNode(node));
				
			}
				return true;
		}
		bool operator() (GraphZ::ProgEdge * edge) 
		{
			
			Converted.addNewNode(translateProgNode(&(edge->to)));
			translateProgNode(&(edge->from))->addAdjNode(translateProgNode(&(edge->to)),1);
			
			return true;
		}
	};
	
void ConvertZ(GraphZ& ConvertMe, Graph &FreshGraph )
	{
		ZaConverter UltraConversion;
		GraphZ::DFTraverse<ZaConverter> DepthFirst(UltraConversion,1);
		DepthFirst(ConvertMe);
		FreshGraph=UltraConversion.Converted;
	}
	
	
		

	
};
