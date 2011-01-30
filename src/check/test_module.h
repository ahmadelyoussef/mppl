#include<iostream>
using namespace std;
#include"GRAPH.h"
#include<fstream>
#include<string>
#include <stdlib.h>
#include <stdio.h>

/*\class test
 *\brief The file containing the assigned values of the variables is read, parsed and stored in an instance of this class
 * It basically contains all the information contained in the file and continues to store and update the values of the variables as the program goes on
 */

class test
{
public:
	/**\var check
	 *\brief Is initially set to false and will become true if the assignments are consistent with the program
	 */
	bool check;
	/**\var mult
	 *\brief Is set to true if node contains * operand
	 */
	bool mult;
	/**\var div
	 *\brief Is set to true if node contains / operand
	 */
	bool div;  
	/**\var sub
	 *\brief Is set to true if node contains - operand
	 */
	bool sub;
	
	/**\var expon
	 *\brief Is set to true if node contains exponential operator
	 */
	bool expon;
	int index_ass;
	bool mod;
	int size;
	int incorrect_value;
	int calculated_value;
	string incorrect_ass;
	bool dont_calculate;
	string variable_input[10];
	int value_input[10];
	string variable_output[10];
	int value_output[10];
	int result[6];
	/**\var variable
	 *\brief The variable that gets assigned	 
	 */
	string variable; 
	/**\var value
	 *\brief Value that gets assigned
	 */
	int value;   
	test() 
	{check=true;
		mult=false;
		div=false;
		dont_calculate=false;
		sub=false;
		expon=false;
		mod=false;
		
		index_ass=0;
		calculated_value=0;
		incorrect_value=0;
		
		for (int i=0;i<6;i++)
			result[i]=0;
		result[2]=1;
		
		for(int i=0;i<10;i++)
		{value_input[i]=0;
			variable_input[i]="";
			value_output[i]=0;
			variable_output[i]="";
		}
		
		incorrect_ass="";
		
		value=0;
		variable="";
	}
	
	
	/**\function constant
	 *\param n pointer to Node 
	 *\brief Indicates if a node contains a constant
	 */
	
	bool constant(Node *n)
	{
		if(atoi(n->name.c_str())!=0 || n->name=="0")
			return true;
		else return false;
	}
	
	/**\function isVar
	 *\param n pointer to Node 
	 *\brief Indicates if a Node contains a variable
	 */
	
	bool isVar(Node *n)
	{
		if(!constant(n) && n->name!="\"*\""  && n->name!="\"+\"" && 
		   n->name!="\"/\"" && n->name!="exp" && n->name!="mod"&& n->name!="\"*\"" && n->name!="\"-\"")
			return true;
		
		else return false;
	}
	
	int exp(int x,int y)
	{
		int temp=1;
		for(int i=0;i<y;i++)
			temp=x*temp;
		
		return temp;
		
	}
	
	/**\function operation
	 *\param n pointer to Node
	 *\return int
	 *\brief Indicates the kind of operation contaned in the node by returning an integer whose value is mapped to the op in the rest of the class
	 */
	
	int operation(Node *n)
	{
		if(n->name=="\"+\"") return 0;
		else if (n->name=="\"-\"")return 1;
		else if (n->name=="\"*\"")return 2;
		else if (n->name=="\"/\"")return 3;
		else if (n->name=="exp")return 4;
		else if (n->name=="mod")return 5;
	}
	
	/**\function set_result
	 *\param n Node Pointer 
	 *\brief Recursive functions that handles node content storage and updating
	 *If the node contains an operator it will check it's children and here it will be faced with one of three situations :
	 *1 - If the child is a constant then it will store it in a hash table to use it later
	 *2 - If the child is a variable then it will look for the value of this variable in the hashtable in which the values extracted from module.txt are stored and it will let the value get updated along with the program
	 *3 - If the child is an operand then it will call itself with the new node as argument
	 */
	
	void set_result(Node *n)
	{
		/**\var op
		 *\brief Contains integer indicating which operation (if any) is stored
		 */
		int op;  
		
		if(constant(n)) {dont_calculate=true;
			value=atoi(n->name.c_str());}
		for(int i=0;i<n->adjNodeList.size();i++)
		{
			Edge edg = n->adjNodeList[i];
			Node * child=edg.getDstNode();
			
			if(constant(child)) 
			{
				op=operation(n);
				if(op==0)
				{result[op]+=atoi(child->name.c_str());
		
				}
				else if(op==2){
					
					result[op]*=atoi(child->name.c_str());
					mult=true;
					
				}
				else if(op==1)
					
				{if(!sub)result[op]=atoi(child->name.c_str());
				else result[op]-=atoi(child->name.c_str());
					sub=true;
				}
				else if(op==3){
					
					if(!div)result[op]=atoi(child->name.c_str());
					
					if(div) result[op]/=atoi(child->name.c_str());
					div=true;
				}
				else if(op==4)
				{
					if(!expon)result[op]=atoi(child->name.c_str());
					
					if(expon) result[op]=exp(result[op],atoi(child->name.c_str()));
					expon=true;
					
				}
				else if(op==5)
				{
					if(!mod)result[op]=atoi(child->name.c_str());
					if(mod)result[op]%=atoi(child->name.c_str());
					mod=true;
				}
			}
			
			

			
			if(isVar(child)) 
			{
				 
				int valueToRead;
				
				if(read_value(child,valueToRead))
				{
					op=operation(n);
					if(op==0)
					{result[op]+=(valueToRead);
					}
					else if(op==2){
						
						
						result[op]*=(valueToRead); 
						
						mult=true;
			
					}
					else if(op==1)
						
					{if(!sub)result[op]=valueToRead;
					else result[op]-=valueToRead;
						sub=true;
					}
					
					else if(op==3){
						
						if(!div)result[op]=(valueToRead);
					
						if(div) result[op]/=(valueToRead);
						div=true;
					}
					else if(op==4)
					{
						if(!expon)result[op]=(valueToRead);
						
						if(expon) result[op]=exp(result[op],valueToRead);
						expon=true;
						
					}
					else if(op==5)
					{
						if(!mod)result[op]=valueToRead;
						if(mod)result[op]%=valueToRead;
						mod=true;
					}
				}
				
			}
			
			
			else { set_result(child);}
		}
	}
	
	/**\function final_result
	  *\return int
	  *\brief computes final result at the top level of the assignment subtree of the graph
	 */
	
	int final_result()
	{
		int final=0;
		if(!mult) result[2]=0;
		for(int i=0;i<6;i++)
			final+=result[i];
		return final;
	}
	/**\function set_test
	 *\brief Enters graph finds an assignment node, then finds the value to be assigned and stores it and calls set result when it gets to the operator
	 */
	void set_test()
	{
		
		Node*ass=structure.findNodeByName1("Assignment",index_ass);
		
		string s;
		
		bool declare=false;
		Edge edg = ass->adjNodeList[0];
		s=edg.getDstNode()->name;
		if(s=="var") 
		{ declare=true;
			variable=ass->adjNodeList[1].getDstNode()->name;
			set_result(ass->adjNodeList[2].getDstNode());
			
			
			
			if(!dont_calculate)     value=final_result();
			set_value(variable,value);
			
			
		} 
		
		else
		{variable=s;
			set_result(ass->adjNodeList[1].getDstNode());
			
			if(!dont_calculate)     value=final_result();
			set_value(variable,value);
		}
		
		for(int i=0;i<size;i++)
			if(variable_output[i]==variable && value_output[i]!=value)
			{check=false;
			
				incorrect_ass=variable; incorrect_value=value_output[i]; calculated_value=value; 
				break;
			}
		
		
		
	}
	
	/**\function read_value
	 *\param n Node to check
	 *\param read_value passed by reference to return in it the value that has been checked
	 *\return bool 
	 *\brief Returns true if node has allready been read and content stored false otherwise
	 */
	
	bool read_value(Node* n,int& read_value)
	{
		
		for(int i=0;i<size;i++)
		{
			if(n->name==variable_input[i])
			{
				read_value=value_input[i];
				return true;
			}
		}
		return false;
	}
	
	void set_value(string s,int value)
	{
		
		for(int i=0;i<size;i++)
			if(s==variable_input[i])
			{value_input[i]=value;
				break;
			}
	}
	
	
	
/**\function read_module
 *\param in file reader
 *\brief Reads varaible constraints to be checked
 */	
	
	void read_module(ifstream &in)
	{
		string s;string s1;
		bool ok=true;
		size=0;
		int count=0;
		while ( true)
		{
			if(ok )in>>s;
			if(s!=":")
			{variable_input[size]=s;
				in>>value_input[size];
				count++;
				size++;
			}
			else 
			{
				
				in>>s1; 
				if(s1!="!")
				{
					
					variable_output[size-count]=s1;   
					in>>value_output[size-count];    
					ok=false; 
					size++;}
				else break;
				
			}
			
		}
	}
	
	/**\function clear
		*\brief Clears Hash table result
	 */	
	
	void clear()
	{

		mult=false;
		div=false;
		expon=false;
		mod=false;
		dont_calculate=false;
		for (int i=0;i<6;i++)
			result[i]=0;
		result[2]=1;
		
	}
	
	
};
