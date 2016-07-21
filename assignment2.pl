indx(_,[],_,[]).
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

/*==============End==============*/
assign_number([],[],[]).
assign_number([],FinalRests,FinalRests).
assign_number([LH|List],Numbers,FinalRests) :-
	integer(LH),
	assign_number(List,Numbers,FinalRests).
assign_number([LH|List],Numbers,FinalRests) :-
	member(Num,Numbers),
	subtract(Numbers,[Num],Rests),
	LH is Num,
	assign_number(List,Rests,FinalRests).

calculate(_,_,_,[],0).
calculate(List1,List2,List3,[LH|List],Value) :-
	calculate(List1,List2,List3,List,Value1),
	coefficient(List1,List2,List3,LH,Coeff),
	Value is Value1 + Coeff * LH.

solved(0).
solve([List1,List2,List3]) :-
	assign_number(List1,[0,1,2,3,4,5,6,7,8,9],Rests1),
	assign_number(List2,Rests1,Rests2),
	assign_number(List3,Rests2,_),
	list_to_set(List1,ListSet1),
	list_to_set(List2,ListSet2),
	list_to_set(List3,ListSet3),
	union(ListSet1,ListSet2,TempSet),
	union(TempSet,ListSet3,UnionSet),
	calculate(List1,List2,List3,UnionSet,CalResult),
	solved(CalResult),
	write(UnionSet).
