#ifndef GRAPHZ_H_
#define GRAPHZ_H_
#include <list>
#include <vector>
#include <queue>
#include <stack>
#include <algorithm>

using namespace std;

template <class D, class W> 
class ProgGraph { 
	public:
		class ProgNode;
		class ProgEdge 
			{
				public:
				ProgNode & from;
				ProgNode & to;
				W weight;
				ProgEdge(ProgNode & f, ProgNode & t, W & w) :
				from(f), to(t), weight(w) {}
				ProgEdge(ProgNode * f, ProgNode * t, W & w) :
				from(*f), to(*t), weight(w) {}
			};

	typedef enum {Variable, Literal, Expression, Statement, Last} 
	NodeType;

    typedef enum {NullNodeExp, NullEdgeExp, InconsistentNodeExp, NoEdgeExp,WeirdExp } 
	ExceptionType;

		class ProgNode 
		{ 
			public:
			unsigned int idx;
			unsigned int color;
			D data;
			list<ProgEdge*> edges;
			ProgNode (D& d) : 
            idx(0), color(0), data(d) {};

			virtual NodeType type() const = 0;
			//virtual ProgNode & createNode (D d) const = 0;
			void setIndexInGraph(unsigned int i) 
			{
				idx = i;
			}

			void setVisited(unsigned int bit) 
			{
				color |= 1 << bit;
			}
			void resetVisited(unsigned int bit) 
			{
				color &= (~(1 << bit)); 
			}
			bool isVisited(unsigned int bit)	
			{
				return (color & (1 << bit)) != 0; 
			}
			void resetColor() 
			{
            color = 0; 
			}
		};

    vector<ProgNode*> vertices;
    unsigned int numNullNodes;

    typedef typename vector<ProgNode*>::iterator ProgNodeIter;

    bool compact () 
	{
        if (numNullNodes == 0)
            return true;
        ProgNodeIter it = remove(vertices.begin(), vertices.end(), (ProgNode*)NULL);
        vertices.resize(it - vertices.begin());

        numNullNodes = 0;
        for (int i = 0; i < vertices.size(); i++) 
            vertices[i]->setIndexInGraph(i);
        return true;
	}

    class ProgVar : public ProgNode 
	{ 
		public:
        string name;
        ProgVar(D & d, string & n) : 
		ProgNode(d), name(n) {}
        virtual NodeType type() const {return Variable;}
    };

    class ProgLit : public ProgNode 
	{ 
		public:
		string value;
        ProgLit(D & d, string & v) : 
		ProgNode(d), value(v) {}
        virtual NodeType type() const {return Literal;}
    };

    class ProgExpr : public ProgNode 
	{	
		public:
        ProgExpr (D & d) : ProgNode(d) {}
        virtual NodeType type() const {return Expression;}
    };

    class ProgStmt : public ProgNode 
	{ 
		public:
        ProgStmt (D & d) : ProgNode(d) {}
        virtual NodeType type() const {return Statement;}
    };

    ProgNode & addNode(ProgNode * node) 
	{
        if (node == NULL)
            throw NullNodeExp;
        vertices.push_back(node);
        node->setIndexInGraph(vertices.size() - 1);
        return *node;
    }

    ProgEdge & addEdge(ProgNode * from, ProgNode * to, W & w) 
	{
        if (from == NULL) 
            throw NullNodeExp;
        if (to == NULL) 
            throw NullNodeExp;
		
		ProgEdge * edge = new ProgEdge(from, to, w);
        from->edges.push_back(edge);
        return *edge;
    }

    ProgNode * removeNode(ProgNode * node) 
	{
        if (node == NULL)
            throw NullNodeExp;

        unsigned int idx = node->idx;
        if (vertices[idx] != node )
            throw InconsistentNodeExp;

        vertices[idx] = NULL;
        numNullNodes++;
        return node;
    }

    typedef typename list<ProgEdge*>::iterator ProgEdgeIter;

    ProgEdge * removeEdge(ProgEdge * edge) {
        if (edge == NULL)
            throw NullEdgeExp;
        if (edge->from == NULL)
            throw NullNodeExp;
        if (edge->to == NULL)
            throw NullNodeExp;

        list<ProgEdge*> & edges = edge->from->edges;
        ProgEdgeIter it = find(edges.begin(), edges.end(), edge);
        if (it == edges.end())
            throw NoEdgeExp;

        edges.erase(it);
        return edge;
    }

    void resetColor() {
        for (int i = 0; i < vertices.size(); i++) {
            if (vertices[i] == NULL) continue;
            vertices[i]->resetColor(); 
        }
    }

    void resetVisited(unsigned int color) {
        for (int i = 0; i < vertices.size(); i++) {
            if (vertices[i] == NULL) continue;
            vertices[i]->resetVisited(color); 
        }
    }

    unsigned int size() const {
        return vertices.size() - numNullNodes;
    }

    template <class Visitor>
    class BFTraverse { 
        queue<ProgNode *> q;
        Visitor & visit;
        unsigned int color;
        public:
        BFTraverse(Visitor & v, unsigned int c=0) : visit(v), color(c) {}

        bool operator() (ProgGraph & pg)  {
            for (int i = 0; i < pg.vertices.size(); i++) {
                while (!q.empty()) {
                    ProgNode * node = q.front();
                    q.pop();
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
                            q.push(&edge->to);
                    }
                }
                if (pg.vertices[i] == NULL)
                    continue;
                if (pg.vertices[i]->isVisited(color) )
                    continue;
                q.push(pg.vertices[i]);
            }
        }
    };

    template <class Visitor>
    class DFTraverse { 
        stack<ProgNode *> s;
        Visitor & visit;
        unsigned int color;
        public:
        DFTraverse(Visitor & v, unsigned int c=0) : visit(v), color(c) {}

        bool operator() (ProgGraph & pg)  {
            for (int i = 0; i < pg.vertices.size(); i++) {
                while (!s.empty()) {
                    ProgNode * node = s.top();
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
    };
};

#endif



