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
#include<vector>
} 



@members{ Graph declarations;
Graph intDecl;
Graph arrayDecl;
Graph pairDecl;
Graph boolDecl;
Graph Loop;
Graph exp;
bool paire_array=false;
Graph ass;
Graph cond;
Graph vect;
Graph Paire;
Graph structure;
bool hidden=false;
int index_add=0;
int index_mult=0;
int index_div=0;
int index_exp=0;
int index_mod=0;
int index_sub=0;
int index_lt=0;
int index_lte=0;
int index_gt=0;
int index_gte=0;
int index_eq=0;
int index_neq=0;
int index_and=0;
int index_xor=0;
int index_or=0;
int index_unary=0;
int index_not=0;
int index_ass_unary=0;     //expression
int index_ass_not=0;
int index_pair_unary=0;
int index_pair_not=0;
int index_vect_unary=0;
int index_vect_not=0;
int index_loop_unary=0;
int index_loop_not=0;
int index_cond_unary=0;
int index_cond_not=0;
int index_cond1_unary=0;
int index_cond1_not=0;


int index_expression_cond=0;//condition
int index_expression_cond1=0;//condition


int index_expression_ass=0;  //assignment
int index_pair_ass=0;       //assignment

int index_vect_ass=0;		  //assignment
int index_pair_express=0;       //pair
int index_pair_int=0;        //pair
bool ass_unary=false;
bool ass_not=false;
int index_vect_express=0;  //vecteur
  
int index_loop_start=0;//loop
int index_loop_end=0;  //loop
int index_loop_inc=0;  //loop
}


pStructure : 'Begin'{Node* Begin=new Node("Begin"); structure.addNewNode(Begin);}
(s1=statement
{
if($s1.node=="Declaration"){
declarations.appendTo(structure);
structure.findNodeByName("Begin")->addAdjNode(declarations.findNodeByName("Declaration"),1);
declarations.clear();

}
if($s1.node=="Assignment"){

ass.appendTo(structure);
structure.findNodeByName("Begin")->addAdjNode(ass.findNodeByName("Assignment"),1);
ass.clear();
 index_expression_ass=0;
 index_pair_ass=0;
index_vect_ass=0;

//vector<Node*> node=structure.findNodeByName1("Assignment");
//for(int i=0;i<count_ass;i++)
//(structure.findNodeByName("Begin"))->addAdjNode(node[i],1);
//else
//(structure.findNodeByName("Begin"))->addAdjNode(structure.findNodeByName("Declaration"),1);

}
if($s1.node=="conditionalStatement"){

cond.appendTo(structure);
structure.findNodeByName("Begin")->addAdjNode(cond.findNodeByName("conditionalStatement"),1);
 cond.clear();

index_expression_cond=0;
}
if($s1.node=="Loop"){
Loop.appendTo(structure); 

structure.findNodeByName("Begin")->addAdjNode(Loop.findNodeByName("Loop"),1);
Loop.clear();
 index_loop_start=0;//loop
 index_loop_end=0;  //loop
 index_loop_inc=0;  //loop
}
 
}
)* 'end' {

structure.DFS(structure.nodeList[0]); 
cout<<endl<<"Program ends"<<endl;};

conditionalStatement returns [string result, string s]
@init {
//cond.clear();
Node* Con= new Node ("conditionalStatement");
cond.addNewNode(Con);


}
: 'is' {Node* is = new Node ("is");
cond.addNewNode(is);
Con->addAdjNode(is,1);}
'('
(e1=expression)
{

exp.appendTo(cond);
if(ass_unary){
(cond.findNodeByName("conditionalStatement"))->addAdjNode(exp.findNodeByName1($e1.node,index_cond_unary),1);
}
else if(ass_not)
{
(cond.findNodeByName("conditionalStatement"))->addAdjNode(exp.findNodeByName1($e1.node,index_cond_not),1);

}
else
(cond.findNodeByName("conditionalStatement"))->addAdjNode(exp.findNodeByName1($e1.node,index_expression_cond),1);
exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0; index_cond_not=0;index_cond_unary=0;   


//cond.DFS(cond.nodeList[0]);
}





')'


'do' '['
(s1=statement
{
if ($s1.node =="Declaration")
{
declarations.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(declarations.findNodeByName("Declaration"),1);

declarations.clear();

}
else if ($s1.node == "Assignment")
{
ass.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(ass.findNodeByName("Assignment"),1);

ass.clear();
index_expression_ass=0;  //assignment
index_pair_ass=0;       //assignment

index_vect_ass=0;		  //assignment

}
else if ($s1.node == "Loop" )
{
Loop.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(Loop.findNodeByName("Loop"),1);

Loop.clear();
index_loop_start=0;//loop
 index_loop_end=0;  //loop
 index_loop_inc=0;  //loop

}
else if ($s1.node == "conditionalStatement")
{
cout << " No nested ifs use a boolean to simulate " << endl;

}


}


)+ 
']' (
'oris'{Node* oris = new Node ("oris");
   cond.addNewNode(oris);
    Con->addAdjNode(oris,1);}
e2=expression
{    

exp.appendTo(cond);
if(ass_unary){
(cond.findNodeByName("conditionalStatement"))->addAdjNode(exp.findNodeByName1($e2.node,index_cond1_unary),1);
}
else if(ass_not)
{
(cond.findNodeByName("conditionalStatement"))->addAdjNode(exp.findNodeByName1($e2.node,index_cond1_not),1);

}
else
(cond.findNodeByName("conditionalStatement"))->addAdjNode(exp.findNodeByName1($e2.node,index_expression_cond1),1);
exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0; index_cond_not=0;index_cond_unary=0;   index_cond1_unary=0; index_cond1_not=0;

index_expression_cond1=0;

}

'do' '['
(s2=statement
{
if ($s2.node =="Declaration")
{
declarations.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(declarations.findNodeByName("Declaration"),1);

declarations.clear();

}
else if ($s2.node == "Assignment")
{
ass.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(ass.findNodeByName("Assignment"),1);

ass.clear();
index_expression_ass=0;  //assignment
index_pair_ass=0;       //assignment

index_vect_ass=0;		  //assignment


}

else if ($s2.node == "Loop")
{
Loop.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(Loop.findNodeByName("Loop"),1);

Loop.clear();
index_loop_start=0;//loop
 index_loop_end=0;  //loop
 index_loop_inc=0;  //loop

}
else if ($s2.node == "conditionalStatement")
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
declarations.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(declarations.findNodeByName("Declaration"),1);

declarations.clear();
//cond.displayGraph();
}
else if ($s3.node == "Assignment")
{
ass.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(ass.findNodeByName("Assignment"),1);

ass.clear();
index_expression_ass=0;  //assignment
index_pair_ass=0;       //assignment

index_vect_ass=0;	
}
else if ($s3.node == "Loop" )
{
Loop.appendTo(cond);
(cond.findNodeByName("conditionalStatement"))->addAdjNode(Loop.findNodeByName("Loop"),1);

Loop.clear();
index_loop_start=0;//loop
 index_loop_end=0;  //loop
 index_loop_inc=0;  //loop
}
else if ($s1.node == "conditionalStatement")
{
cout << " No nested ifs use a boolean to simulate " << endl;
}

}

)*
']'
)*//{cond.DFS(cond.nodeList[0]);} 

;

loopStatement
@init
{
Node* loopy = new Node ("Loop");
Node* start = new Node ("Start");
Node* equal = new Node ("\"=\"");
Node* end_d = new Node ("End");
Node* lt = new Node ("greater");
Node* inc = new Node ("Increment");
Node*temp=new Node("");
Node*temp1=new Node("");

Loop.addNewNode(loopy);
Loop.addNewNode(start);
Loop.addNewNode(end_d);
Loop.addNewNode(inc);
Loop.addNewNode(equal);
Loop.addNewNode(lt);
loopy->addAdjNode(start,1);
loopy->addAdjNode(end_d,1);
loopy->addAdjNode(inc,1);
start->addAdjNode(equal,1);
end_d->addAdjNode(lt,1);

//Loop.displayGraph();

}:
'loop'


'(' i1=identifier
{
Node* ione = new Node ($i1.result);
Loop.addNewNode(ione);
equal-> addAdjNode(ione,1);
Node* ione1 = new Node ($i1.result);
Loop.addNewNode(ione1);
lt->addAdjNode(ione1,1);



}


':' ( (n1=expression)
{
exp.appendTo(Loop);

if(ass_unary){
(Loop.findNodeByName("\"=\""))->addAdjNode(exp.findNodeByName1($n1.node,index_loop_unary),1);
}
else if(ass_not)
{
(Loop.findNodeByName("\"=\""))->addAdjNode(exp.findNodeByName1($n1.node,index_loop_not),1);

}
else
{

temp=(Loop.findNodeByName("\"=\""));
temp->addAdjNode(Loop.findNodeByName1($n1.node,index_loop_start),1);


}


exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0; index_loop_unary=0; index_loop_not=0;



}

) '->'
(n2= expression

{
exp.appendTo(Loop);


if(ass_unary){
(Loop.findNodeByName("greater"))->addAdjNode(exp.findNodeByName1($n2.node,index_loop_unary),1);
}
else if(ass_not)
{
(Loop.findNodeByName("greater"))->addAdjNode(exp.findNodeByName1($n2.node,index_loop_not),1);

}
else
{
temp1=(Loop.findNodeByName("greater"));
temp1->addAdjNode(Loop.findNodeByName1($n2.node,index_loop_end),1);
}





exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0; index_loop_unary=0; index_loop_not=0;


}


) ','
('+'
{
Node* plus = new Node ("\"+\"");
Loop.addNewNode(plus);
inc->addAdjNode(plus,1);

//Loop.displayGraph();


}

|
'*'
{
Node* times = new Node ("\"*\"");
Loop.addNewNode(times);
inc->addAdjNode(times,1);
// Loop.displayGraph();

}

)
( n3=expression
{
exp.appendTo(Loop);

if(ass_unary){
(Loop.findNodeByName("Increment"))->addAdjNode(exp.findNodeByName1($n3.node,index_loop_unary),1);
}
else if(ass_not)
{
(Loop.findNodeByName("Increment"))->addAdjNode(exp.findNodeByName1($n3.node,index_loop_not),1);

}
else
(Loop.findNodeByName("Increment"))->addAdjNode(Loop .findNodeByName1($n3.node,index_loop_inc),1);
exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0; index_loop_unary=0; index_loop_not=0;


//Loop.DFS(Loop.nodeList[0]);
}



) ')'  

'do' '['
(
(s1=statement
{
if ($s1.node == "Declaration")
{
declarations.appendTo(Loop);
(Loop.findNodeByName("Loop"))->addAdjNode(declarations.findNodeByName("Declaration"),1);

declarations.clear();

}
else if ($s1.node == "Assignment")
{ 
ass.appendTo(Loop);
(Loop.findNodeByName("Loop"))->addAdjNode(ass.findNodeByName("Assignment"),1);

ass.clear();
index_expression_ass=0;  //assignment
index_pair_ass=0;       //assignment

index_vect_ass=0;		  //assignment
}
else if ($s1.node == "conditionalStatement")
{
cond.appendTo(Loop);
(Loop.findNodeByName("Loop"))->addAdjNode(cond.findNodeByName("conditionalStatement"),1);

cond.clear();
index_expression_cond=0;//condition
int index_expression_cond1=0;//co
}
else if ($s1.node == "Loop")
{
cout << " Nested Loops ! Tsk Tsk Tsk ! STOP ! " << endl;
}


}

)+   


)']'   //{Loop.DFS(Loop.nodeList[0]);}
;


statement returns [string node,string s]
:declaration {$node ="Declaration";}
| assignment{$node = $assignment.node;}
| conditionalStatement{$node = "conditionalStatement";}
|loopStatement {$node= "Loop";}

;

declruleTrial


: loopStatement {};

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

$s.assign($myid.result); // This strange reassignment was done to remove the occuring of some errors(segmentation core)
$node.assign($s);
Node* term=new Node($node);
exp.addNewNode(term);

}
| '(' expression')' {

$s.assign($expression.node);
$node.assign($s);

}

|
value {
$s.assign($value.result);
$node.assign($s);
Node* term=new Node($node);
exp.addNewNode(term);
}


;
//*****************************************************************************************
//*****************************************************************************************
//*****************************************************************************************

negation returns[string node,string s] @init{bool negation=false;int count=0;}:

('not'{ negation=true; count++;}
)* term{
$s.assign( $term.node); // This strange reassignment was done to remove the occuring of some errors
$node.assign($s); //node=term.node
if(negation)
{ for(int i=1;i<=count;i++)
{


Node* neg=new Node("not");
exp.addNewNode(neg);
(*neg).addAdjNode(exp.findNodeByName1($node,index_not),1);

ass_not=true;
$node="not";
}

}

}
 
;
 

//*****************************************************************************************
//*****************************************************************************************
//*****************************************************************************************

unary returns[string node,string s] @init{bool positive=true; int count=0;}:
('+'|'-'{ count++;
positive=false;})* negation{
$s.assign( $negation.node); // This strange reassignment was done to remove the occuring of some errors
$node.assign($s);
if(!positive)
{
for(int i=1;i<=count;i++)
{
Node* unary=new Node("\"_\"");
exp.addNewNode(unary);
(*unary).addAdjNode(exp.findNodeByName1($node,index_unary),1);

ass_unary=true;
$node="\"_\"";
}

}
}
;


//*****************************************************************************************
//*****************************************************************************************
//*****************************************************************************************
mult returns[string node,string s]@init{ bool mul=true,div=true,ex=true,mod=true;Node* expon=new Node("exp");Node* mult=new Node("\"*\"");Node* divide=new Node("\"/\"");Node* modulo=new Node("mod");}: //;int c_m=1,c_d=1,c_e=1,c_mod=1;}:
op1=unary 

{$s.assign( $op1.node);
$node.assign($s); //$node=$op1.node

}

('*' op2=unary 
{

if(mul){

exp.addNewNode(mult);


(*mult).addAdjNode(exp.findNodeByName1($node,index_mult),1);
(*mult).addAdjNode(exp.findNodeByName1($op2.node,index_mult),1);
//index_mult=0;
$node="\"*\""; 

/*for(int i=0;i<mult->adjNodeList.size();i++)
       {  Edge edg = mult->adjNodeList[i];
          cout<<"mult: "<<mult->name<<"  "<<edg.getDstNode()->name<<endl;
        }*/
mul=false;
}     
 
else{

(*mult).addAdjNode(exp.findNodeByName1($op2.node,index_mult),1);
}
}

| '/' op2=unary
{

if(div){
exp.addNewNode(divide);
(*divide).addAdjNode(exp.findNodeByName1($node,index_div),1);
(*divide).addAdjNode(exp.findNodeByName1($op2.node,index_div),1);

$node="\"/\"";
div=false;
}

else{
(*divide).addAdjNode(exp.findNodeByName1($op2.node,index_div),1);
}
}
| 'exp' op2=unary
{

if(ex){
exp.addNewNode(expon);
(*expon).addAdjNode(exp.findNodeByName1($node,index_exp),1);
(*expon).addAdjNode(exp.findNodeByName1($op2.node,index_exp),1);

$node="exp";
ex=false;
}

else{
(*expon).addAdjNode(exp.findNodeByName1($op2.node,index_exp),1);
}
}


| 'mod' op2=unary
{

if(mod){
exp.addNewNode(modulo);
(*modulo).addAdjNode(exp.findNodeByName1($node,index_mod),1);
(*modulo).addAdjNode(exp.findNodeByName1($op2.node,index_mod),1);

  
$node="mod";
mod=false;
}

else{
(*modulo).addAdjNode(exp.findNodeByName1($op2.node,index_mod),1);
}
}

)*

;


//*****************************************************************************************
//*****************************************************************************************
//*****************************************************************************************


addmult returns [string node,string s] @init{bool add=true,sub=true;Node* ad=new Node("\"+\"");Node* substrat=new Node("\"-\"");}:
op1=mult{
$s.assign( $op1.node);
$node.assign($s);
//cout<<"op1_m"<<endl;
//cout<<$node<<endl;
 
}
('+'op2=mult{
if(add){

exp.addNewNode(ad);
(*ad).addAdjNode(exp.findNodeByName1($node,index_add),1);
(*ad).addAdjNode(exp.findNodeByName1($op2.node,index_add),1);
$node="\"+\"";
add=false;

}
else{

(*ad).addAdjNode(exp.findNodeByName1($op2.node,index_add),1);
}
}


| '-' op2=mult
{
if(sub){

exp.addNewNode(substrat);
(*substrat).addAdjNode(exp.findNodeByName1($node,index_sub),1);
(*substrat).addAdjNode(exp.findNodeByName1($op2.node,index_sub),1);

$node="\"-\"";
sub=false;

}
else{
(*substrat).addAdjNode(exp.findNodeByName1($op2.node,index_sub),1);
}
}
)*
;
//*****************************************************************************************
//*****************************************************************************************
//*****************************************************************************************



comparision returns [string node,string s] @init{bool lt=true,lte=true,gt=true,eq=true,neq=true,gte=true;Node* greater_e=new Node("gte");Node* less_e=new Node("lte");Node* nequal=new Node("neq");Node* equal=new Node("eq");Node* less=new Node("lt");Node* greater=new Node("gt");}://lte,gte=true;int c_lt=1,c_gt=1,c_eq=1,c_neq=1,c_lte=1,c_gte=1;int temp_lt=0;int temp_gt=0,temp_eq=0,temp_neq=0,temp_lte=0,temp_gte=0;int replace_lt=0,replace_gt=0,replace_lte,replace_gte,replace_eq,replace_neq=0;} :
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
(*less).addAdjNode(exp.findNodeByName1($node,index_lt),1);
(*less).addAdjNode(exp.findNodeByName1($op2.node,index_lt),1);

$node="lt";
less=false;
}
else{

(*less).addAdjNode(exp.findNodeByName1($op2.node,index_lt),1);
}
}

|
'gt' op2=addmult
{
if(gt){
exp.addNewNode(greater);
(*greater).addAdjNode(exp.findNodeByName1($node,index_gt),1);
(*greater).addAdjNode(exp.findNodeByName1($op2.node,index_gt),1);

$node="gt";
gt=false;
}
else{

(*greater).addAdjNode(exp.findNodeByName1($op2.node,index_gt),1);
}
}

|

'eq' op2=addmult
{
if(eq){
exp.addNewNode(equal);
(*equal).addAdjNode(exp.findNodeByName1($node,index_eq),1);
(*equal).addAdjNode(exp.findNodeByName1($op2.node,index_eq),1);

$node="eq";
eq=false;
}
else{

(*equal).addAdjNode(exp.findNodeByName1($op2.node,index_eq),1);
}
}
|

'neq' op2=addmult
{
if(neq){
exp.addNewNode(nequal);
(*nequal).addAdjNode(exp.findNodeByName1($node,index_neq),1);
(*nequal).addAdjNode(exp.findNodeByName1($op2.node,index_neq),1);

$node="neq";
neq=false;
}
else{

(*nequal).addAdjNode(exp.findNodeByName1($op2.node,index_neq),1);
}
}
|


'lte' op2=addmult
{
if(lte){
exp.addNewNode(less_e);
(*less_e).addAdjNode(exp.findNodeByName1($node,index_lte),1);
(*less_e).addAdjNode(exp.findNodeByName1($op2.node,index_lte),1);


$node="lte";
lte=false;
}
else{
(*less_e).addAdjNode(exp.findNodeByName1($op2.node,index_lte),1);
}
}

|

'gte' op2=addmult
{
if(gte){
exp.addNewNode(greater_e);
(*greater_e).addAdjNode(exp.findNodeByName1($node,index_gte),1);
(*greater_e).addAdjNode(exp.findNodeByName1($op2.node,index_gte),1);
$node="gte";
gte=false;
}
else{
(*greater_e).addAdjNode(exp.findNodeByName1($op2.node,index_gte),1);
}
}


)?
;





expression returns [string node,string s] @init{bool andd=true,xorr=true,orr=true;Node* o=new Node("or");Node* x=new Node("xor");Node* an=new Node("and");}://,xorr=true;int c_and=1,c_or=1,c_xor=1;int temp_and=0;int temp_or=0,temp_xor=0;int replace_and=0,replace_or=0,replace_xor=0;} :


op1=comparision
{
$s.assign( $op1.node);
$node.assign($s);

}

('and' op2=comparision
{
if(andd){


exp.addNewNode(an);
(*an).addAdjNode(exp.findNodeByName1($node,index_and),1);
(*an).addAdjNode(exp.findNodeByName1($op2.node,index_and),1);


$node="and";
andd=false;}

else{

(*an).addAdjNode(exp.findNodeByName1($op2.node,index_and),1);
}
}

|

'or' op2=comparision
{
if(orr){


exp.addNewNode(o);
(*o).addAdjNode(exp.findNodeByName1($node,index_or),1);
(*o).addAdjNode(exp.findNodeByName1($op2.node,index_or),1);


$node="or";
orr=false;}

else{

(*o).addAdjNode(exp.findNodeByName1($op2.node,index_or),1);
}
}

|

'xor' op2=comparision
{
if(xorr){


exp.addNewNode(x);
(*x).addAdjNode(exp.findNodeByName1($node,index_xor),1);
(*x).addAdjNode(exp.findNodeByName1($op2.node,index_xor),1);
$node="xor";
xorr=false;}

else{

(*x).addAdjNode(exp.findNodeByName1($op2.node,index_xor),1);

}
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
(ass.findNodeByName("Assignment"))->addAdjNode(ident,1);

}




(' takes')


((e1 = expression)
{
exp.appendTo(ass);

if(ass_unary){
(ass.findNodeByName("Assignment"))->addAdjNode(exp.findNodeByName1($e1.node,index_ass_unary),1);
}
else if(ass_not)
{
(ass.findNodeByName("Assignment"))->addAdjNode(exp.findNodeByName1($e1.node,index_ass_not),1);

}
else
(ass.findNodeByName("Assignment"))->addAdjNode(exp.findNodeByName1($e1.node,index_expression_ass),1);
exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0;index_expression_ass=0;

}
|
(p=paire)
{
Paire.appendTo(ass);
(ass.findNodeByName("Assignment"))->addAdjNode(ass.findNodeByName1("Pair",index_pair_ass),1);

Paire.clear();

index_pair_express=0; 
index_pair_int=0;

}
| (vecteur)
{


vect.appendTo(ass);

(ass.findNodeByName("Assignment"))->addAdjNode(ass.findNodeByName1("Array",index_vect_ass),1);

vect.clear();
index_vect_express=0;
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
i2 = myid  {

Node* ident=new Node($i2.result);
ass.addNewNode(ident);
(ass.findNodeByName("Assignment"))->addAdjNode(ident,1);

}
(' takes' 



((e2=expression)
{

exp.appendTo(ass);
if(ass_unary)

{

(ass.findNodeByName("Assignment"))->addAdjNode(exp.findNodeByName1($e2.node,index_ass_unary),1);

//ass_unary=false;
}
else if(ass_not)
{
(ass.findNodeByName("Assignment"))->addAdjNode(exp.findNodeByName1($e2.node,index_ass_not),1);

//ass_unary=false;

}
else
(ass.findNodeByName("Assignment"))->addAdjNode(exp.findNodeByName1($e2.node,index_expression_ass),1);

exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0;
index_expression_ass=0;
}
|
(p=paire)
{
Paire.appendTo(ass);
(ass.findNodeByName("Assignment"))->addAdjNode(ass.findNodeByName1("Pair",index_pair_ass),1);

Paire.clear();

index_pair_express=0; 
index_pair_int=0;


}
| (vecteur)
{

vect.appendTo(ass);

(ass.findNodeByName("Assignment"))->addAdjNode(ass.findNodeByName1("Array",index_vect_ass),1);

vect.clear();
index_vect_express=0;
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
)* ';' ;



element returns [string result, string s] : paire{$result = "pair";} | vecteur{$result = "array";} | expression{$result = "int"; $s = $expression.node;} | b=boole {$result = "boole"; $s = $b.result;}
;

paire @init

{
Node* Pa = new Node ("Pair");
Paire.addNewNode(Pa);
int temp=0;

} : ('{'

(e1=element
{
if ($e1.result=="int")
{
Node* Type = new Node ("int");
Paire.addNewNode(Type);
Pa->addAdjNode(Type,1);
exp.appendTo(Paire);


if(ass_unary){
(Paire.findNodeByName1("int",index_pair_int))->addAdjNode(exp.findNodeByName1($e1.s,index_pair_unary),1);
}
else if(ass_not)
{
(Paire.findNodeByName1("int",index_pair_int))->addAdjNode(exp.findNodeByName1($e1.s,index_pair_not),1);

}
else

Paire.findNodeByName1("int",index_pair_int)->addAdjNode(exp.findNodeByName1($e1.s,index_pair_express),1);
exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0;index_pair_express=0;
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

paire_array=true;

vect.appendTo(Paire);
Pa->addAdjNode(vect.findNodeByName1("Array",temp),1);
temp=temp+vect.nodeList.size();
vect.clear();
index_vect_express=0;

}

})

',' (e2=element
{//cout << $e2.result << endl;
if ($e2.result=="int")
{
Node* Type = new Node ("int");
Paire.addNewNode(Type);
Pa->addAdjNode(Type,1);
exp.appendTo(Paire);

if(paire_array) {index_pair_int=temp,paire_array=false;}

if(ass_unary){
(Paire.findNodeByName1("int",index_pair_int))->addAdjNode(exp.findNodeByName1($e2.s,index_pair_unary),1);
}
else if(ass_not)
{
(Paire.findNodeByName1("int",index_pair_int))->addAdjNode(exp.findNodeByName1($e2.s,index_pair_not),1);

}
else

Paire.findNodeByName1("int",index_pair_int)->addAdjNode(exp.findNodeByName1($e2.s,index_pair_express),1);

exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0;index_pair_express=0;

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
Pa->addAdjNode(vect.findNodeByName("Array"),1);
vect.clear();
index_vect_express=0;

}

})
'}'{})



;




vecteur @init

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
exp.appendTo(vect);

if(ass_unary){
(vect.findNodeByName("int"))->addAdjNode(exp.findNodeByName1($e1.s,index_vect_unary),1);
}
else if(ass_not)
{
(vect.findNodeByName("int"))->addAdjNode(exp.findNodeByName1($e1.s,index_vect_not),1);

}
else

vect.findNodeByName("int")->addAdjNode(exp.findNodeByName1($e1.s,index_vect_express),1);
exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0;index_vect_express=0;
////////////


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

index_pair_express=0;       //pair
index_pair_int=0;  

}
else {cout << "Array input type is not VALID";}

} /* */

) (','

(e2=element)
{
if ($e2.result==$e1.result && $e1.result=="int")
{


exp.appendTo(vect);

if(ass_unary){
(vect.findNodeByName("int"))->addAdjNode(exp.findNodeByName1($e2.s,index_vect_unary),1);
}
else if(ass_not)
{
(vect.findNodeByName("int"))->addAdjNode(exp.findNodeByName1($e2.s,index_vect_not),1);

}
else

vect.findNodeByName("int")->addAdjNode(exp.findNodeByName1($e2.s,index_vect_express),1);
exp.clear();
index_mult=0;index_div=0;index_exp=0;index_mod=0;index_sub=0;index_lt=0;index_lte=0;index_gt=0;index_gte=0;index_eq=0;
index_neq=0;index_and=0;index_xor=0;index_or=0;index_add=0;index_unary=0;index_ass_unary=0;index_ass_not=0;index_not=0;index_pair_unary=0;
index_pair_not=0;index_vect_not=0;index_vect_unary=0;index_vect_express=0;

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

index_pair_express=0;       //pair
index_pair_int=0;  

}

else
{cout << " Array inputs have different types " << endl;}

}


)* ']'
//{vect.displayGraph();}
)
;
value returns [string result,string s] :
(INTEGER{
uint8_t *widget;
widget = ($INTEGER.text->chars);
$s.append(1,*widget);
$result.assign($s);
}
)+
;
boole returns [string result, string s]: ('ok' { $result = "ok";} |'false' {$result ="false";} )
;
arIndex1 returns [string result, string s,string node]:
identifier '[' value ']'{$result=$identifier.result + $value.result;
$node="value";
}
;
arIndex2 returns [string result, string s,string node]:
i1=identifier '[' i2=identifier ']'{$result=$i1.result +"_" +$i2.result;}


;
pairIndex returns [string result, string s]
:identifier'{' value

{ if($value.result=="0"){$result=$identifier.result + "0";}else if ($value.result=="1"){$result=$identifier.result + "1";}
else cout<<"invalid index"<<endl;
}
'}' ;

myid returns [string result,string s]: arIndex2{$result = $arIndex2.result;}|arIndex1{$result = $arIndex1.result;}|pairIndex{$result = $pairIndex.result;}|identifier{$result = $identifier.result;};

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


