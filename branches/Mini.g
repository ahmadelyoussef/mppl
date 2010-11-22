grammar Mini;

options {
  language = C;
  
}
@preincludes
{
#include"GRAPH.H"
#include <iostream>
#include<string>
using namespace std;

}



@members{  	Graph declarations;
		Graph intDecl;
		Graph arrayDecl;
		Graph pairDecl;
		Graph boolDecl;
		Graph Loop;
		Graph exp;
		Graph ass;
		Graph cond;
		Graph vect;
		Graph Paire;
		Graph structure;
		bool hidden=false;
		}
				
	
	
pStructure : 'Begin'{Node* Begin=new Node("Begin");  structure.addNewNode(Begin);} 
(s1=statement
{
if($s1.node=="Declaration"){
declarations.appendTo(structure);
declarations.clear();
(structure.findNodeByName("Begin"))->addAdjNode(structure.findNodeByName($s1.node),1);
}
if($s1.node=="Assignment"){

ass.appendTo(structure);ass.clear();

(structure.findNodeByName("Begin"))->addAdjNode(structure.findNodeByName("Assignment"),1);
//else
//(structure.findNodeByName("Begin"))->addAdjNode(structure.findNodeByName("Declaration"),1);

}
if($s1.node=="Conditional"){

cond.appendTo(structure);  cond.clear();
(structure.findNodeByName("Begin"))->addAdjNode(structure.findNodeByName("conditionalStatement"),1);
}
if($s1.node=="Loop"){
Loop.appendTo(structure); Loop.clear();
(structure.findNodeByName("Begin"))->addAdjNode(structure.findNodeByName($s1.node),1);
}

}
)* 'end' {structure.displayGraph();  cout<<endl<<"Program ends"<<endl;};

conditionalStatement returns [string result, string s]
@init {
cond.clear();
Node* Con= new Node ("conditionalStatement");
cond.addNewNode(Con);
Node* is = new Node ("is");
cond.addNewNode(is);
Con->addAdjNode(is,1);

}
	: 'is' {hidden=false;}
	'(' 
	(e1=expression) 
	{
	
	Node* Condition = new Node($e1.node);
	cond.addNewNode(Condition);
	Con->addAdjNode(Condition,1);
	exp.appendTo(cond);
	//cond.displayGraph();
	exp.clear();
	}

	
	
	')'
					  
						  
	'do' '['
	(s1=statement
	{
	if ($s1.node =="Declaration")
	{
	Node* stak = new Node ($s1.node);
        cond.addNewNode ( stak);
        Con->addAdjNode(stak,1);
        declarations.appendTo(cond);
        declarations.clear();
       
	}
	else if ($s1.node == "Assignment")
	{
	Node* staka = new Node ($s1.node);
        cond.addNewNode ( staka);
        Con->addAdjNode(staka,1);
        ass.appendTo(cond);
        ass.clear(); 
        	
	}
	else if ($s1.node == "Loop" )
	{
	Node* stakala = new Node($s1.node);
	cond.addNewNode (stakala);
	Con->addAdjNode(stakala,1);
	Loop.appendTo(cond);
	Loop.clear();
	//cond.displayGraph();
	}
	else if ($s1.node == "Conditional")
	{
	cout << " No nested ifs use a boolean to simulate " << endl;
	
	}
	
		
	}
	
	
	)+
        ']'	 (
        'oris' 
	e2=expression
	{
	
   Node* oris = new Node ("oris");
   cond.addNewNode(oris);
    Con->addAdjNode(oris,1);
	Node* e = new Node($e2.node);
	cond.addNewNode(e);
	Con->addAdjNode(e,1);
	exp.appendTo(cond);
	//cond.displayGraph();
	
	exp.clear();
	}
			
	 'do' '['
	(s2=statement
	{
	if ($s2.node =="Declaration")
	{
	Node* stak = new Node ($s2.node);
        cond.addNewNode ( stak);
        Con->addAdjNode(stak,1);
        declarations.appendTo(cond);
        declarations.clear();
       
	}
	else if ($s2.node == "Assignment")
	{
	Node* staka = new Node ($s2.node);
        cond.addNewNode ( staka);
        Con->addAdjNode(staka,1);
        ass.appendTo(cond);
        ass.clear(); 
        	
	}
	
	else if ($s2.node == "Loop")
	{
	Node* stakal = new Node ($s2.node);
	cond.addNewNode(stakal);
	Con->addAdjNode(stakal,1);
	Loop.appendTo(cond);
	Loop.clear();
	
	}
	else if ($s2.node == "Conditional")
	{
	cout << " No nested ifs use a boolean to simulate " << endl;
	}	
		}
	)+

	 ']'
	 )*
	  (
	  'isnot'{Node* isnot = new Node ("isnot"); cond.addNewNode(isnot); Con->addAdjNode(isnot,1);}
	  {
	  
	  
	  }
	  'do' '[' 
	  (s3=statement
	  {
	  if ($s3.node =="Declaration")
	{
	Node* stak = new Node ($s3.node);
        cond.addNewNode ( stak);
        Con->addAdjNode(stak,1);
        declarations.appendTo(cond);
        declarations.clear();
	cond.displayGraph();}
	else if ($s3.node == "Assignment")
	{
	Node* staka = new Node ($s3.node);
        cond.addNewNode ( staka);
        Con->addAdjNode(staka,1);
        ass.appendTo(cond);
        ass.clear();
	
	}
	else if ($s3.node == "Loop" )
	{
	Node* stakala = new Node($s3.node);
	cond.addNewNode (stakala);
	Con->addAdjNode(stakala,1);
	Loop.appendTo(cond);
	Loop.clear();
	}
	else if ($s1.node == "Conditional")
	{
	cout << " No nested ifs use a boolean to simulate " << endl;
	}
	  
	  }
	  
	  )*
	  ']'
	  )*{} ;

loopStatement 
@init 
{
Node* loopy = new Node ("Loop");
Node* start = new Node ("Start");
Node* equal = new Node ("=");
Node* end = new Node ("End");
Node* lt = new Node ("lt");
Node* inc = new Node ("Increment");
Loop.addNewNode(loopy);
Loop.addNewNode(start);
Loop.addNewNode(end);
Loop.addNewNode(inc);
Loop.addNewNode(equal);
Loop.addNewNode(lt);
loopy->addAdjNode(start,1);
loopy->addAdjNode(end,1);
loopy->addAdjNode(inc,1);
start->addAdjNode(equal,1);
end->addAdjNode(lt,1);

//Loop.displayGraph();

}:
'loop'


 '(' i1=identifier 
 {
 Node* ione = new Node ($i1.result);
 Loop.addNewNode(ione);
 equal-> addAdjNode(ione,1);
 lt->addAdjNode(ione,1);

 }
 
 
 ':' ( (n1=expression) 
 {
 Node* nOne = new Node ($n1.node);
 Loop.addNewNode(nOne);
 equal->addAdjNode(nOne,1);
// Loop.displayGraph();
 }
 
  ) '->'  
  (n2= expression
  
  {
   Node* nTwo = new Node ($n2.node);
   Loop.addNewNode(nTwo);
   lt-> addAdjNode(nTwo,1);

  
  }
   
   
    ) ',' 
 ('+' 
 {
 Node* plus = new Node ("+");
 Loop.addNewNode(plus);
 inc->addAdjNode(plus,1);
 //Loop.displayGraph();
 
 }
 
 | 
 '*'
 {
  Node* times = new Node ("*");
 Loop.addNewNode(times);
  inc->addAdjNode(times,1);
// Loop.displayGraph();
 
 }
 
  ) 
  ( n3=expression 
  {
  Node* nThree = new Node ($n3.node);
  Loop.addNewNode ( nThree);
  inc-> addAdjNode(nThree,1);
  //Loop.displayGraph();
  }
  
 
  
  )  ')'

'do' '['
              ((s1=statement
              {
              if ($s1.node == "Declaration")
          {
                 	Node* sta = new Node ($s1.node);
                 	Loop.addNewNode ( sta);
                 	loopy->addAdjNode(sta,1);
                 	declarations.appendTo(Loop);
                // 	Loop.displayGraph();
                 	declarations.clear();
                 	//sta->addAdjNode(Loop.findNodeByName("Declaration"),1);
                 	
                 	declarations.clear();
           }
           else if ($s1.node == "Assignment")
           {		Node* sta = new Node ($s1.node);
                 	Loop.addNewNode ( sta);
                 	loopy->addAdjNode(sta,1);
                 	ass.appendTo(Loop);
                 	ass.clear();
                 	//sta->addAdjNode(Loop.findNodeByName("Assignment"),1);
           
           }  
           else if ($s1.node == "Conditional")
           {
           Node* sta = new Node ($s1.node);
           Loop.addNewNode( sta);
           loopy->addAdjNode(sta,1);
           cond.appendTo(Loop);
           cond.clear();
           }    	
           else if ($s1.node == "Loop")
           {
           cout << " Nested Loops ! Tsk Tsk Tsk ! STOP ! " << endl;
           }      	
              
              
              }
              
              )
              

               )+  ']' ;


statement returns [string node,string s]
	:declaration {$node ="Declaration";}
	| assignment{$node = $assignment.node;}
	| conditionalStatement{$node = "Conditional";}
	|loopStatement {$node= "Loop";}
	 
	;

declruleTrial


	:	loopStatement {};

declaration @init 
{
 Node* decl = new Node ("Declaration") ;
 declarations.addNewNode(decl);
}: (

intDeclaration {
intDecl.appendTo(declarations); 
(declarations.findNodeByName("Declaration"))->addAdjNode(declarations.findNodeByName("IntDecl"),1);
intDecl.clear();
}


| 
arrayDeclaration
{
arrayDecl.appendTo(declarations);
(declarations.findNodeByName("Declaration"))->addAdjNode(declarations.findNodeByName("ArrayDecl"),1);
arrayDecl.clear();
}

| 
pairDeclaration
{

pairDecl.appendTo(declarations);
(declarations.findNodeByName("Declaration"))->addAdjNode(declarations.findNodeByName("PairDecl"),1);
pairDecl.clear();

}

|	
booleanDeclaration 
{
boolDecl.appendTo(declarations);
(declarations.findNodeByName("Declaration"))->addAdjNode(declarations.findNodeByName("BoolDecl"),1);
boolDecl.clear();
}
	

); // Distinction has been made between declaration and assignment to avoid writing [] or () after variable name if variable is to be assigned directly

intDeclaration 
@init 
{
	Node* IntD = new Node ("IntDecl");
	intDecl.addNewNode(IntD);

} :
 'var' (i1=identifier)
{
Node* id = new Node ($i1.result);
intDecl.addNewNode(id);
IntD->addAdjNode(id,1);


}
 
 (',' i2=identifier 
 {
 Node* id = new Node ($i2.result);
 intDecl.addNewNode(id);
 IntD->addAdjNode(id,1);

 
 }
 
 )*
  ';'
  
   ;
arrayDeclaration

@init
{
	Node* ArrayD = new Node ("ArrayDecl");
	arrayDecl.addNewNode(ArrayD);
}
:

'var'(i1=identifier '['']'
{
Node* id = new Node ($i1.result);
arrayDecl.addNewNode(id);
ArrayD->addAdjNode(id,1);
}
)(',' i2=identifier '['']'
{
Node* id = new Node ($i2.result);
arrayDecl.addNewNode(id);
ArrayD->addAdjNode(id,1);
}
 )* ';'
 
 
 ;
 
 
 
pairDeclaration 
@init
{
	Node* PairD = new Node ("PairDecl");
	pairDecl.addNewNode(PairD);

}

: 'var' 
(i1=identifier '{''}'
{
Node* id = new Node ($i1.result);
pairDecl.addNewNode(id);
PairD->addAdjNode(id,1);
}
)
(',' i2= identifier '{''}'
{
Node* id = new Node ($i2.result);
pairDecl.addNewNode(id);
PairD->addAdjNode(id,1);

}
 )* ';';
booleanDeclaration 
@init
{
	Node* BoolD = new Node ("BoolDecl");
	boolDecl.addNewNode(BoolD);
}

: 'var' '(' i1=identifier ')'
{

Node* id = new Node ($i1.result);
boolDecl.addNewNode(id);
BoolD->addAdjNode(id,1);

}


 (',' '(' i2=identifier ')'
 {
 Node* id = new Node ($i2.result);
boolDecl.addNewNode(id);
BoolD->addAdjNode(id,1);
 }
 )* ';';
 
 
 
 
 
 
 
 
term returns [string node,string s]:
     myid{
	 
	 $s.assign($myid.result);                  // This strange reassignment was done to remove the occuring of some errors(segmentation core)

	 $node.assign($s);
	 } 
     | '(' expression')'  {
	$s.assign($expression.node);
	 $node.assign($s);
	  }
	  
	  |
      value  {
     $s.assign($value.result);
	 $node.assign($s);
	 }
    
      
      ; 	  
	  //*****************************************************************************************
	  //*****************************************************************************************
	  //*****************************************************************************************
 
 negation returns[string node,string s] @init{bool negation=false;int count=0;}:

('not'{  negation=true;  count++;}
            )* term{
				  $s.assign( $term.node);    // This strange reassignment was done to remove the occuring of some errors
	              $node.assign($s);          //node=term.node
				  if(negation)
				  { for(int i=1;i<=count;i++)
                   {
				   Node* neg=new Node("not");
				   exp.addNewNode(neg);
				   Node* a=new Node($node);
				   exp.addNewNode(a);
				   (*neg).addAdjNode(a,1);
				   $node="not";
				 
				   }
				 
				  }
				  
		 }
		 
;
 
 
 
 
 
  //*****************************************************************************************
	  //*****************************************************************************************
	  //*****************************************************************************************
 
unary returns[string node,string s] @init{bool positive=true; int count=0;}:
('+'|'-'{    count++;
             positive=false;})* negation{
				  $s.assign( $negation.node);    // This strange reassignment was done to remove the occuring of some errors
	              $node.assign($s);
				  if(!positive)
				  {
				   for(int i=1;i<=count;i++)
                   {
				   Node* unary=new Node("-");
				   exp.addNewNode(unary);
				   Node* a=new Node($node);
				   exp.addNewNode(a);
				   (*unary).addAdjNode(a,1);
				   $node="-";
				   }
			}
		 }
;

//*****************************************************************************************
	  //*****************************************************************************************
	  //*****************************************************************************************
mult returns[string node,string s]@init{ bool mul=true,div=true,ex=true,mod=true;Node* expon=new Node("tothe");Node* divide=new Node("/");Node* mult=new Node("*");Node* modulo=new Node("mod");}:  //;int c_m=1,c_d=1,c_e=1,c_mod=1;}:
	op1=unary 
	
	{$s.assign( $op1.node);
	 $node.assign($s);              //$node=$op1.node
		
    }
 
	('*' op2=unary
	{
	
	if(mul){
	
    exp.addNewNode(mult);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*mult).addAdjNode(b,1);
	(*mult).addAdjNode(c,1);
	$node="*";
	mul=false;
		}
	
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*mult).addAdjNode(b,1);
	}
	}
	
	| '/' op2=unary
	{
	
	if(div){
	
    exp.addNewNode(divide);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*divide).addAdjNode(b,1);
	(*divide).addAdjNode(c,1);
	$node="/";
	div=false;
		}
	
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*divide).addAdjNode(b,1);
	}
	}
	| 'tothe' op2=unary
	{
	
	if(ex){
	
    exp.addNewNode(expon);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*expon).addAdjNode(b,1);
	(*expon).addAdjNode(c,1);
	$node="tothe";
	ex=false;
		}
	
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*expon).addAdjNode(b,1);
	}
	}
	
	
	| 'mod' op2=unary
	{
	
	if(mod){
	
    exp.addNewNode(modulo);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*modulo).addAdjNode(b,1);
	(*modulo).addAdjNode(c,1);
	$node="mod";
	mod=false;
		}
	
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*modulo).addAdjNode(b,1);
	}
	}
	
)*

;


 //*****************************************************************************************
 //*****************************************************************************************
 //*****************************************************************************************


addmult returns [string node,string s]   @init{bool add=true,sub=true;Node* ad=new Node("+");Node* substrat=new Node("-");}://;int c_na=1,c_ns=1;int temp_a=0;int temp_s=0;int replace_a=0,replace_s=0;}:   
    op1=mult{
	$s.assign( $op1.node);
	$node.assign($s);
	//cout<<"op1_m"<<endl;
	//cout<<$node<<endl;	
	
    }
('+'op2=mult{                   
    if(add){
	
	exp.addNewNode(ad);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*ad).addAdjNode(b,1);
	(*ad).addAdjNode(c,1);
	$node="+";
	add=false;
				   
				   }
else{

    Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*ad).addAdjNode(b,1);}
				   }
				   
	
| '-' op2=mult
{                   
    if(sub){
	
	exp.addNewNode(substrat);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*substrat).addAdjNode(b,1);
	(*substrat).addAdjNode(c,1);
	$node="-";
	sub=false;
				   
				   }
else{

    Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*substrat).addAdjNode(b,1);}
				   }
				)*
;
//*****************************************************************************************
//*****************************************************************************************
//*****************************************************************************************



comparision  returns [string node,string s]   @init{bool lt=true,lte=true,gt=true,eq=true,neq=true,gte=true;Node* greater_e=new Node("gte");Node* less_e=new Node("lte");Node* nequal=new Node("neq");Node* equal=new Node("eq");Node* less=new Node("lt");Node* greater=new Node("gt");}://lte,gte=true;int c_lt=1,c_gt=1,c_eq=1,c_neq=1,c_lte=1,c_gte=1;int temp_lt=0;int temp_gt=0,temp_eq=0,temp_neq=0,temp_lte=0,temp_gte=0;int replace_lt=0,replace_gt=0,replace_lte,replace_gte,replace_eq,replace_neq=0;} : 
	  op1=addmult 
	  { 
	  	$s.assign( $op1.node);
	    $node.assign($s);
	     
	  }
	  (
	  'lt' op2=addmult 
	  {
	  if(lt){
	exp.addNewNode(less);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*less).addAdjNode(b,1);
	(*less).addAdjNode(c,1);
	$node="lt";
	less=false;
	}
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*less).addAdjNode(b,1);
	}
	  }
	 
	 | 
	'gt' op2=addmult 
	  {
	  if(gt){
	exp.addNewNode(greater);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*greater).addAdjNode(b,1);
	(*greater).addAdjNode(c,1);
	$node="gt";
	gt=false;
	}
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*greater).addAdjNode(b,1);
	}
	  }
	  
	  |
	  
	  'eq' op2=addmult 
	  {
	  if(eq){
	exp.addNewNode(equal);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*equal).addAdjNode(b,1);
	(*equal).addAdjNode(c,1);
	$node="eq";
	eq=false;
	}
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*equal).addAdjNode(b,1);
	}
	  }
	  |
	  
	  'neq' op2=addmult 
	  {
	  if(neq){
	exp.addNewNode(nequal);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*nequal).addAdjNode(b,1);
	(*nequal).addAdjNode(c,1);
	$node="neq";
	neq=false;
	}
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*nequal).addAdjNode(b,1);
	}
	  }
	  |
	  
	  
	  'lte' op2=addmult 
	  {
	  if(lte){
	exp.addNewNode(less_e);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*less_e).addAdjNode(b,1);
	(*less_e).addAdjNode(c,1);
	$node="lte";
	lte=false;
	}
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*less_e).addAdjNode(b,1);
	}
	  }
	  
	  |
	  
	  'gte' op2=addmult 
	  {
	  if(gte){
	exp.addNewNode(greater_e);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*greater_e).addAdjNode(b,1);
	(*greater_e).addAdjNode(c,1);
	$node="gte";
	gte=false;
	}
	else{
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*greater_e).addAdjNode(b,1);
	}
	  }
	  
	  
	  )?
;





expression returns [string node,string s]   @init{bool andd=true,xorr=true,orr=true;Node* o=new Node("or");Node* x=new Node("xor");Node* an=new Node("and");}://,xorr=true;int c_and=1,c_or=1,c_xor=1;int temp_and=0;int temp_or=0,temp_xor=0;int replace_and=0,replace_or=0,replace_xor=0;} : 


op1=comparision 
	  { 
	  	$s.assign( $op1.node);
	    $node.assign($s);
	     
	  }
	  
	  ('and' op2=comparision 
	  {
	  if(andd){
	  
	  
    exp.addNewNode(an);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*an).addAdjNode(b,1);
	(*an).addAdjNode(c,1);
	$node="and";
	andd=false;}
	
	else{
	
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*an).addAdjNode(b,1);}
	  }
	  
	 |
	 
	 'or' op2=comparision 
	  {
	  if(orr){
	  
	  
    exp.addNewNode(o);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*o).addAdjNode(b,1);
	(*o).addAdjNode(c,1);
	$node="or";
	orr=false;}
	
	else{
	
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*o).addAdjNode(b,1);}
	  }
	  
	  |
	 
	 'xor' op2=comparision 
	  {
	  if(xorr){
	  
	  
    exp.addNewNode(x);
	Node*b=new Node($node);
	exp.addNewNode(b);
	Node*c=new Node($op2.node);
	exp.addNewNode(c);
	(*x).addAdjNode(b,1);
	(*x).addAdjNode(c,1);
	$node="xor";
	xorr=false;}
	
	else{
	
	Node*b=new Node($op2.node);
	exp.addNewNode(b);
	(*x).addAdjNode(b,1);}
	  }
	 
	  )*
;

assignment returns [string node, string s] 

@init{bool isDec=false;int count=0;Node* declare=new Node("var");Node* assign=new Node("Assignment");}:

 ('var'  
 {
 isDec = true;
 ass.addNewNode(declare);


 }
 )?

 i1 = myid{
ass.addNewNode(assign); 
if (isDec){
 
(*assign).addAdjNode(declare,1);//edge between declaration and assignment
}
$node="Assignment";
Node* ident=new Node($i1.result);
ass.addNewNode(ident);
(*assign).addAdjNode(ident,1);

} 




(' takes')

	
((e1 = expression)
{
exp.appendTo(ass);
if($e1.node!="*" && $e1.node!="/" &&$e1.node!="mod" && $e1.node!="tothe" && $e1.node!="+" && $e1.node!="-" 
&& $e1.node!="gt" && $e1.node!="lt" && $e1.node!="gte" && $e1.node!="lte" && $e1.node!="eq"&& $e1.node!="neq" && $e1.node!="and" && $e1.node!="or" && $e1.node!="xor"
&& $e1.node!="not")
{
Node* term=new Node($e1.node);
ass.addNewNode(term);
(*assign).addAdjNode(term,1);
}
else
(ass.findNodeByName("Assignment"))->addAdjNode(ass.findNodeByName($e1.node),1);
exp.clear(); 
}
	|	
	(p=paire)
	{
	Node* edon = new Node ("Pair");
	ass.addNewNode(edon);
	(ass.findNodeByName("Assignment"))->addAdjNode(edon,1);
	Paire.appendTo(ass);
	//ass.displayGraph();
	Paire.clear();
	
	
	}
	| (vecteur)
	{
	Node* done = new Node ("Array");
	ass.addNewNode(done);
	(ass.findNodeByName("Assignment"))->addAdjNode(done,1);
	vect.appendTo(ass);
	//ass.displayGraph();
	vect.clear();
	}
	| (b1=boole)
	{
	Node* Booldeneige = new Node ("Bool");
	ass.addNewNode(Booldeneige);
	(ass.findNodeByName("Assignment"))->addAdjNode(Booldeneige,1);
	Node* booleValue = new Node($b1.result);
	Booldeneige->addAdjNode(booleValue,1);
	
	}
	)




(
','
i2 = myid
(' takes' 

{

Node* ident=new Node($i2.result);
ass.addNewNode(ident);
(*assign).addAdjNode(ident,1); 
 
}

((e2=expression)
{
exp.appendTo(ass);
if($e2.node!="*" && $e2.node!="/" &&$e2.node!="mod" && $e2.node!="tothe" && $e2.node!="+" && $e2.node!="-" 
&& $e2.node!="gt" && $e2.node!="lt" && $e2.node!="gte" && $e2.node!="lte" && $e2.node!="eq"&& $e2.node!="neq" && $e2.node!="and" && $e2.node!="or" && $e2.node!="xor"
&& $e2.node!="not")
{
Node* term=new Node($e2.node);
ass.addNewNode(term);
(*assign).addAdjNode(term,1);
}
else
(ass.findNodeByName("Assignment"))->addAdjNode(ass.findNodeByName($e2.node),1);
exp.clear();
}
	|	
	(p=paire)
	{
	Node* edon = new Node ("Pair");
	ass.addNewNode(edon);
	(ass.findNodeByName("Assignment"))->addAdjNode(edon,1);
	Paire.appendTo(ass);
	//ass.displayGraph();
	Paire.clear();
	
	
	}
	| (vecteur)
	{
	Node* done = new Node ("Array");
	ass.addNewNode(done);
	(ass.findNodeByName("Assignment"))->addAdjNode(done,1);
	vect.appendTo(ass);
	//ass.displayGraph();
	vect.clear();
	}
	| (b2=boole)
	{
	Node* Booldeneige = new Node ("Bool");
	ass.addNewNode(Booldeneige);
	(ass.findNodeByName("Assignment"))->addAdjNode(Booldeneige,1);
	Node* booleValue = new Node($b2.result);
	Booldeneige->addAdjNode(booleValue,1);
	
	}
	)



)
)* ';'{}    ;  



element returns [string result, string s] : paire{$result = "pair";} | vecteur{$result = "array";} | expression{$result = "int"; $s = $expression.node;} | b=boole {$result = "boole"; $s = $b.result;} 
;

  paire @init 
  
  {
  Node* Pa = new Node ("Pair");
  Paire.addNewNode(Pa);
  
  
  }  : ('{' 
  
  (e1=element
  {
	 if ($e1.result=="int")
  {//cout << "HIII" << endl;
  Node* Type = new Node ("int");
  Paire.addNewNode(Type);
  Pa->addAdjNode(Type,1);
  Node* el = new Node ( $e1.s);
  Paire.addNewNode(el);
  Type->addAdjNode(el,1);	  
  
  }
  else if ($e1.result=="boole")
  {
  Node* Type = new Node ("boole");
  Paire.addNewNode(Type);
  Pa->addAdjNode(Type,1);
  Node* el = new Node ( $e1.s);
  Paire.addNewNode(el);
  Type->addAdjNode(el,1);
  }
   else if ($e1.result=="id")
  {
    Node* Type = new Node ("id");
  Paire.addNewNode(Type);
  Pa->addAdjNode(Type,1);
  Node* el = new Node ( $e1.s);
  Paire.addNewNode(el);
  Type->addAdjNode(el,1);
  
  }
    else if ($e1.result=="pair")
  {
  	
  cout << "Pair can take two other types but can not take a pair" << endl;
    
  }
   else if ($e1.result=="array")
  {
  	
	vect.appendTo(Paire);
	Pa->addAdjNode(Paire.findNodeByName("Array"),1);
	vect.clear();
  
  }
  
  })
  
   ',' (e2=element
  {//cout << $e2.result << endl;
	 if ($e2.result=="int")
  {
  Node* Type = new Node ("int");
  Paire.addNewNode(Type);
  Pa->addAdjNode(Type,1);
  Node* el = new Node ( $e2.s);
  Paire.addNewNode(el);
  Type->addAdjNode(el,1);	  
  
  }
  else if ($e2.result=="boole")
  {
  Node* Type = new Node ("boole");
  Paire.addNewNode(Type);
  Pa->addAdjNode(Type,1);
  Node* el = new Node ( $e2.s);
  Paire.addNewNode(el);
  Type->addAdjNode(el,1);
  }
   else if ($e2.result=="id")
  {
    Node* Type = new Node ("id");
  Paire.addNewNode(Type);
  Pa->addAdjNode(Type,1);
  Node* el = new Node ( $e2.s);
  Paire.addNewNode(el);
  Type->addAdjNode(el,1);
  
  }
    else if ($e2.result=="Pair")
  {
  	
  cout << "Pair can take two other types but can not take a pair" << endl;
    
  }
   else if ($e2.result=="array")
  {
	vect.appendTo(Paire);
	Pa->addAdjNode(Paire.findNodeByName("Array"),1);
	vect.clear();
  
  }
  
  })
   '}'{})
      
      
      
      ;
  
  
  
  
  vecteur  @init 
  
  {
  Node* Ar = new Node("Array");
  vect.addNewNode(Ar);
  } 
  :
   
  ('[' 
  (e1=element
{
  
  if ($e1.result=="int")
  {
  Node* Type = new Node ("int");
  vect.addNewNode(Type);
  Ar->addAdjNode(Type,1);
  Node* el = new Node ( $e1.s);
  vect.addNewNode(el);
  Type->addAdjNode(el,1);
  //vect.displayGraph();
  
  }
  else if ($e1.result=="boole")
  {
  Node* Type = new Node ("boole");
  vect.addNewNode(Type);
  Ar->addAdjNode(Type,1);
  Node* el = new Node ( $e1.s);
  vect.addNewNode(el);
  Type->addAdjNode(el,1);
  }
  else if ($e1.result=="array")
  {
  cout << " You have entered an array of arrays, this is not a valid type " << endl;
  
  }
  else if ($e1.result=="id")
  {
    Node* Type = new Node ("id");
  vect.addNewNode(Type);
  Ar->addAdjNode(Type,1);
  Node* el = new Node ( $e1.s);
  vect.addNewNode(el);
  Type->addAdjNode(el,1);
  
  }
  else if ($e1.result=="pair")
  {
  	Paire.appendTo(vect);
  	Ar->addAdjNode(Paire.findNodeByName("Pair"),1);
	Paire.clear();

  
  
  }
  else {cout << "Array input type is not VALID";}
  
  } /* */
    
   ) (',' 
   
   (e2=element)
   {
   if ($e2.result==$e1.result && $e1.result=="int")
   {
   Node* el2 = new Node ( $e2.s);
  vect.addNewNode(el2);
  vect.findNodeByName("int")->addAdjNode(el2,1);
 // vect.displayGraph();
   }
   else if ($e2.result==$e1.result && $e1.result=="boole")
   {
   Node* el2 = new Node ( $e2.s);
  vect.addNewNode(el2);
  vect.findNodeByName("boole")->addAdjNode(el2,1);

   }
   else if ($e2.result==$e1.result && $e1.result=="id")
   {
      Node* el2 = new Node ( $e2.s);
  vect.addNewNode(el2);
  vect.findNodeByName("id")->addAdjNode(el2,1);

   
   }
   else if ($e2.result==$e1.result && $e1.result=="pair")
   {
   Paire.appendTo(vect);
   Ar->addAdjNode(Paire.findNodeByName("Pair"),1);
   Paire.clear();
   
   }
   
   else 
   {cout << " Array inputs have different types " << endl;}
   
   }
   
   
   )* ']'
//{vect.displayGraph();}
)  
      ;
  value  returns [string result,string s] : 
(INTEGER{  
 uint8_t *widget; 	  	  
 widget = ($INTEGER.text->chars); 
 $s.append(1,*widget);
 $result.assign($s); 
 }                
 )+
      ;
  boole   returns [string result, string s]: ('true' { $result = "true";} |'false' {$result ="false";} )
      ;
arIndex1	returns [string result, string s,string node]:
identifier '[' value ']'{$result=$identifier.result + $value.result;
$node="value";
}
;	
arIndex2	returns [string result, string s,string node]:
i1=identifier '[' i2=identifier ']'{$result=$i1.result +"_" +$i2.result;}


;	
pairIndex returns [string result, string s]
	:identifier'{' value
	
	{  if($value.result=="0"){$result=$identifier.result + "0";}else if ($value.result=="1"){$result=$identifier.result + "1";}
else cout<<"invalid index"<<endl;
}
	'}'	;

myid 	returns [string result,string s]:  	arIndex2{$result = $arIndex2.result;}|arIndex1{$result = $arIndex1.result;}|pairIndex{$result = $pairIndex.result;}|identifier{$result = $identifier.result;};

identifier returns[string result,string s]@init {int counter =0;}:

L0=LETTER{ 
 uint8_t *widget; 	  
 widget = ($L0.text->chars); 
 $s.append(1,*widget);
 $result.assign($s); }
 
 (L1=LETTER{
 counter++;
 uint8_t *widget; 	  
 widget = ($L1.text->chars); 
 $result.insert(counter,1,*widget);
 $s.assign($result); 
 //cout << counter << endl;
 }
  | INTEGER{
 counter++;
 uint8_t *widget; 	  
 widget = ($INTEGER.text->chars); 
 $s.insert(counter,1,*widget);
 $result.assign($s); 
 }
   )* 
  ;

INTEGER : ('0'..'9');

LETTER:('a'..'z'|'A'..'Z');

WS : (' '|'\r'|'\t'|'\n')+ {$channel = HIDDEN;};