indx(Elem,[],Ind,[]).
indx(Elem,[ElemY|List],Ind,Poses) :-
	Elem \= ElemY,
	Ind1 is Ind+1,
	indx(Elem,List,Ind1,Poses).
indx(Elem,[Elem|List],Ind,[Ind|Poses]) :- 
	Ind1 is Ind+1,
	indx(Elem,List,Ind1,Poses).
	
sum([],0).
sum([LH|List],Sum) :- 
	sum(List,Sum1),
	Sum is Sum1+10^LH.

coeff_singlelist(List,Elem,Number) :-
	reverse(List,ListReversed),
	indx(Elem,ListReversed,0,Positions),
	sum(Positions,Number).

/* Notice: The below one is the main predicate,
	Others are made to help the "coefficient" predicate
	achive its purpose.

	Usage:
	coefficient(List1,List2,List3,Elem_you_want_to_find,Result)

	Example:
	coefficient([e,a,t],[m,o,r,e],[e,g,g,s],e,Result) ==> Result is -899
	coefficient([e,a,t],[m,o,r,e],[e,g,g,s],m,Result) ==> Result is 1000
	
	Because the given example of symbolic addition puzzle
	in Assignment 1 can be converted to the equation below:

		-899E-110G-S+1000M+100O+10R+10A+T=0

	where the coefficient of the unknown number 'E' is -899 (For 'M' it's 1000).

	Written by Hongyu Zhou.
*/
coefficient(List1,List2,List3,Elem,Result) :- 
	coeff_singlelist(List1,Elem,Number1),
	coeff_singlelist(List2,Elem,Number2),
	coeff_singlelist(List3,Elem,Number3),
	Result is Number1 + Number2 - Number3.
