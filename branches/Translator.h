namespace Translator 
{
	/* *\namespace Translator
	 *\brief Contains functions that are used in the translation from one graph type to another
	 */
	string Var = "Variable";
	string W="a";
/* *\var isRoot
 *\brief Used in the traversal to know that node is root
 * All nodes are destination nodes except the root node. isRoot is there to avoid creating some nodes twice and create root node only in the beginning
*/
	bool isRoot = true;
	/**\typedef GraphZ
	 *\brief Defining a ProgGraph<string,string> as GraphZ
	 
	 */
	typedef ProgGraph<string,string> GraphZ;
	GraphZ graphZ;
	Graph ourGraph;
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
			
			GraphZ::ProgVar * a = new GraphZ::ProgVar(Var,n->name);
			return a;
			
		}
		else if (n->getType()=="Literal")
		{
			GraphZ::ProgLit * a = new GraphZ::ProgLit(Lit,n->name);
			return a;
		}
		else if (n->getType()=="Expression")
		{
			GraphZ::ProgExpr * a = new GraphZ::ProgExpr(n->name);
			return a;
		}
		
		else 
		{
			GraphZ::ProgStmt * a = new GraphZ::ProgStmt(n->name);
			return a;
		}
		
	}
	/**\function traverseNTranslate 
	 *\brief Traverses the Graph and translates it to a ProgGraph and stores it in graphZ
	 *\param Root Node on which to start the traversal
	 */
	 void traverseNTranslate (Node* n )
	{
		n->visitB();
		if (isRoot)
		{
			graphZ.addNode(translateNode (n)); 
			isRoot = false;
		}
	    for(int i=0;i<n->adjNodeList.size();i++)
		{
			Edge edg=n->adjNodeList[i];
			if( edg.getDstNode()->status==NOT_VISITED)
			{
				graphZ.addNode(translateNode(edg.getDstNode())); // Translate destination node and add it to graph 
				graphZ.addEdge(translateNode(n),translateNode(edg.getDstNode()),n->name);		//Translate origin and destination node to give them as arguments to addEdge and create an edge between them
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
Node* translateProgNode (GraphZ::ProgNode* a)
	{
		GraphZ::NodeType myType = a->type();
		if (myType == GraphZ::Variable)
		{
			Node* b = new Node("Variable");
			return b;
		}
		else if (myType == GraphZ::Literal)
		{
			Node* b = new Node("Literal");
			return b;
		}
		else if (myType == GraphZ::Expression)
		{
			Node* b = new Node("Expression");
			return b;
		}
		else 
		{
			Node* b = new Node("Statement");
			return b;
		}

	
	}
	/**\function translateZ
	 *\brief Translates GraphZ to  Graph
	 *\param a pointer to ProgNode to translate
	 *\return A pointer to equivalent Node

	
	bool translateZ (ProgGraph & pg)  {
		for (int i = 0; i < pg.vertices.size(); i++) {
			while (!s.empty()) {
				ProgNode * node = s.top();
				
					ourGraph.addNewNode(translateProgNode(node)); // translate node and add to Graph;
				
				s.pop();
				if (!visit(node))
					return true;
				node->setVisited(color);
				
				list<ProgEdge*> & edges = node->edges;
				ProgEdgeIter it = edges.begin();
				for (; it != edges.end(); it++) {
					ProgEdge * edge = *it;
					if (!visit(edge))
						return true;
					if (!edge->to.isVisited(color))
						s.push(&edge->to);
				}
			}
			if (pg.vertices[i] == NULL)
				continue;
			if (pg.vertices[i]->isVisited(color) )
				continue;
			s.push(pg.vertices[i]);
		}
	}
	
		 */
	
}
