# Freedom PROGRAMMING LANGUAGE

**Project Name:** Freedoom

**How it runs?**

  - make
- ./freedom < exampleprog1.free

&nbsp;
&nbsp;
&nbsp;

1. [ BNF Form ](#BNF)
   * [Blocks and Commands](#commands)
   * [Expressions](#expressions)
   * [Types](#types)
2. [ Explanation Of the Syntax ](#ExplanationSyntax)
3. [ Design Features ](#Design) 

&nbsp;
&nbsp;
<a name="BNF"></a>
## BNF Form

&nbsp;
<a name="commands"></a>
### Blocks and Commands ###

* < program > :**START** program **END** | statements program | program statements | statements  | error 

*  < statement > :  statements | printnumberStatement | scannerStatement | IfElseStatement | whileStatement | commentStatement | assignmentStatement | printStringStatement | boolStatement | funcStatement

* < printStringStatement > :  **OUTPUT**  **STRING**

* < printnumberStatement > : **OUTPUT** term

* < assignmentStatement > : **IDENTIFIER** '=' exp 

* < funcStatement > : **FUNC** **FUNCNAME** statements **RETURN** statements **SEMICOLON** | **FUNC** **FUNCNAME** **LP** term **RP** **RETURN** | **FUNC** **FUNCNAME** **LP** term **COMMA** term **RP** **RETURN** IfElseStatement

* < commentStatement > : **COMMENT**

* < scannerStatement ? : **SCANNER**

* < boolStatement > : **EUCLID EQUALS EUCLID** | **EUCLID BIGGER EUCLID** | **EUCLID SMALLER EUCLID** | **EUCLID BIGGER_EQUALS EUCLID** | **EUCLID SMALLER_EQUALS EUCLID** | **EUCLID AND EUCLID** | **EUCLID OR EUCLID** | '(' boolStatement ')'

* < IfElseStatement > :  **IF** boolExpression exp **ELSE** exp **SEMICOLON** | **IF** boolExpression **OUTPUT** term **ELSE** **OUTPUT** term | **IF** term **EQUALS** term exp **ELSE** | **IF** **LP** term **MOD** term **RP** **EQUALS** term | **IF** term **EQUALS** term **OUTPUT** **STRING** **ELSE** **OUTPUT** **STRING**

* < whileStatement > : **WHILE** term **SMALLER** term **RETURN** exp **SEMICOLON**  | **WHILE** term **BIGGER** term **RETURN** exp **SEMICOLON**  | **WHILE** term **SMALLER** term **RETURN** **OUTPUT** exp **SEMICOLON** | **WHILE** term **BIGGER** term **RETURN** **OUTPUT** exp **SEMICOLON** | **WHILE** term **SMALLER** term **RETURN** **OUTPUT** **STRING** **SEMICOLON** | **WHILE** term **BIGGER** term **RETURN** **OUTPUT** **STRING** **SEMICOLON** | **WHILE** term **NOT_EQUALS** term **RETURN** term '=' term term '=' term assignmentStatement term | **WHILE** term **S** term **RETURN** 
OUTPUT
&nbsp;
<a name="expressions"></a>
### Expressions ###

* < expression > : comparisonExpression  | orExpression | andExpression  | boolExpression

* < exp > : term  |  exp '+' term   |  exp '-' term |  exp **MOD** term |  **FUNCNAME** **LP** term **COMMA** term **RP**    

* < boolExpression > :  term **EQUALS** term   | term **BIGGER** term   | term **SMALLER** term    | term **BIGGER_EQUALS** term  | term **SMALLER_EQUALS** term 	 | term **AND** term | term **OR** term



* < comparisonExpression > :  **EUCLID**  assignmentOperator **EUCLID**  | **IDENTIFIER** assignmentOperator **EUCLID** | **IDENTIFIER** assignmentOperator **IDENTIFIER**

* < orExpression > : **BOOL OR BOOL**

* < andExpression > : **BOOL AND BOOL**

* < assignmentOperator > : **EQUALS** | **BIGGER_EQUALS**  | **SMALLER_EQUALS**  | **BIGGER**  | **SMALLER**


&nbsp;
<a name="types"></a>
### Types ###

* < term >  :  **EUCLID**  | **IDENTIFIER**


&nbsp;
<a name="ExplanationSysntax"></a>
## Explanation Of the Syntax

:arrow_forward: COMMENT LINE DESCRIPTION

One of the statemants is the comment line. Thanks to the comment line, the user can explain the code blocks. The program defines the comment line with two "//" characters. The command line consists of these characters and the sentence(s) between these characters.

```
START
//something//
END
```
> NO OUTPUT

:arrow_forward: PRINT DESCRIPTION

In Freedom language, "print" is used to display values on the screen. We print with the keyword "OUTPUT" and the character ":". We write the expressions we want to be printed on the screen in the field specified with "OUTPUT:". The value printed in a print operation can be a character value, a string value, an integer value, an euclid value, or an expression.

```
START
a = 2
OUTPUT:"Hello WORLD !"
OUTPUT:a
END

```
> Hello WORLD !

> 2

:arrow_forward: BOOLEAN OPERATION DESCRIPTION

In Freedon, Boolean Operators are EQUALS, BIGGER, SMALLER, BIGGER_EQUALS, SMALLER_EQUALS, AND, OR or NOT. Boolean Operators can be operators that combine multiple boolean expressions or values and provide a single boolean output (such as AND, OR, or NOT). The primary use of these boolean tools is to implement statements that control if decisions and while loops. Or there may be operators that compare values and return TRUE or FALSE (like EQUALS, BIGGER, SMALLER, BIGGER_EQUALS or SMALLER_EQUALS).

```
START
5==5
2>=7
1<4
END
```
> TRUE

> FALSE

> TRUE

:arrow_forward: IF ELSE DESCRIPTION

Many times when you write code, you want to perform different actions for different decisions. Conditionals are used to define a condition. In Freedom language, if-else part consists of two parts, if and else part. IF is used to specify the block of code to execute if the given condition is true, otherwise ELSE is used to specify the block of code to execute if the same condition is false, i.e. it executes the statements after ELSE.

```
START
a=5
IF a<6 
  OUTPUT:1 
ELSE 
  OUTPUT:2
END
```
> 1

:arrow_forward: WHILE DESCRIPTION

The while loop takes a single parameter and loops as long as that parameter is true. In our programming language, we can use a previously assigned variable as a parameter in a while loop.
```
START
s = 0
WHILE s < 2 RETURN
  s+5;
END
```
> 10

:arrow_forward: WHILE 2 DESCRIPTION

The while loop takes a single parameter and loops as long as that parameter is true. In our programming language, we can use a previously assigned variable as a parameter in a while loop. We also have the flexibility to use multiple while loops in a row.
```
START 
WHILE 2<5 RETURN OUTPUT:2;

i = 3
s = 2
WHILE i<4 RETURN s+2;
END 
```
> 2

> 2

> 2

> 4

:arrow_forward: METHOD DESCRIPTION

Methods can be mathematical, logical, etc. without directly changing the application's data. It is a programming approach that returns results by going through operations. To define a function in Freedom language, it starts with the FUNC keyword and after the function name, the function name is defined with the " : " sign, then the parameter is added in parentheses according to the function and the method is written with the RETURN keyword.
```
START 
a = 5
b = 3
FUNC ekranayazdir: (a , b) RETURN 
     IF a<b 
         OUTPUT:4 
     ELSE 
         OUTPUT:3
END
```
> 3

:arrow_forward: ERROR HANDLING DESCRIPTON

Error handling has been added to our programming language for predicting, detecting and solving programming, application and communication errors, and as an error message, the user is told that the error handling has occurred and on which line it is.
```
START 
a = 5
b = 3

asdasdasdasds //error handling//
//i written the wrong code in upper line.//

END
```
> syntax error on line 5


:arrow_forward: Example Program

```
START

a = 28
b = 28

FUNC gcd: ( a , b ) RETURN
	IF b == 0 a
	ELSE
	    c = a % b
	    WHILE c != 0 RETURN
		a = b
		b = c
		c = a % b
	    b

d = gcd: (a , b)
FUNC isperfectnumber: ( d ) RETURN
	e = 0
	i = 1
	WHILE i < d RETURN
		IF (d % i) == 0 e = e + i
	IF e == d OUTPUT: "TRUE"
	ELSE OUTPUT: "FALSE"
END

```
> 28

> TRUE

:arrow_forward: Example Program 2

```
START

a = 10
b = 5

FUNC gcd: ( a , b ) RETURN
	IF b == 0 a
	ELSE
	    c = a % b
	    WHILE c != 0 RETURN
		a = b
		b = c
		c = a % b
	    b

d = gcd: (a , b)
FUNC isperfectnumber: ( d ) RETURN
	e = 0
	i = 1
	WHILE i < d RETURN
		IF (d % i) == 0 e = e + i
	IF e == d OUTPUT: "TRUE"
	ELSE OUTPUT: "FALSE"
END

```
> 5

> FALSE


&nbsp;
<a name="Design"></a>
## Design Features

DESCRIPTION

A programming language is a computer language that offers the opportunity to develop commands and software in a certain standard form. In this way, it is possible to control what kind of output a computer can give in which situation. It provides efficient communication between humans and computers. Freedom is characterized as the capacity to act or alter without constraint, or the resources and power to accomplish one's goals. We created a special programming language based on the C programming language which we called "Freedom" and assigned it the ".free" extension in our project. We chose this term for our programming language because we wanted to establish a language that was easy to adapt and unrestrained by the word's meaning. As instructed in the command, we defined extreme values such as integers, floats, and characters. Our programming language has a good language structure since it includes text, true/false, operators, conditional expressions and functions, as well as constants and variables and interpreted IO expressions.The feature was made possible by us. We sought assistance from C-based languages because of their excellent comprehensibility and versatility. Like other programming languages, the Freedom programming language begins with START and concludes with END. Programs, as previously stated, are a procedural language that consists of if, while, for, and similar constructs. The processes are then invoked by invoking the procedures that were formed by combining the phases.Our programming language was created to serve a specific goal. We constructed a programming language based on the "Fuzzy" programming language example you provided in the project description, in which you can define variables for the greatest common divisor and perfect number. With INT TYPE, we've created a custom data type called "euclid" that we'll use for numeric data. With BOOLEAN TYPE, we created a particular data type we call "perfect," which is used for true or false values. We're trying to figure out whether the input supplied is a perfect number or not with the isperfectnumber() method, which has a Euclid data type parameter.
A perfect number is a number whose positive divisors are equal to itself. For example, because argument 28 is a perfect number, isperfectnumber(28) returns true. 1,2,4, 7, 14 and 28 are its positive divisors. It is still equal to itself because the sum of the other divisors except itself is 1+2+4+7+14=28. However, isperfectnumber(10) returns false. Because positive integer divisors of 10 are 1,2,5 and 10. Except for itself, the total of the divisors is 1+2+5=8, which is not equal to the number itself. The greatest common divisor of two integers is the number that divides both numbers exactly. The larger of the given numbers is divided by the smaller one, and the remainder is calculated using the Euclidean algorithm to determine the greatest common divisor. If the remainder is 0, the lower integer is determined to be the greatest common divisor, and the operation is completed. With the parameters we obtained in the euclid data type and the gcd() method in our program, we calculated the greatest common divisor using the Euclidean algorithm. The gcd() function will return a value of the euclid data type. The gcd(600,136) method, for example, takes as inputs the euclid data type values 600 and 136. The following is the Euclidean algorithm that the procedure follows. 600 = 4 * 136 + 56 136 = 2 * 56 + 24 56 = 2 * 24 + 8 24 = 3 * 8 + 0 We stop the procedure when the remaining value is 0 and use the gcd() method to return the smallest number, 8, as the greatest common divisor. When we were writing this programming language, we found that the notions of finding the greatest common divisor and perfect number, which are fundamental concepts in mathematics, were not included in the mathematics libraries offered by other languages. We constructed a programming language that uses the euclidean algorithm to discover gcd and returns true false for the ideal number by writing functions that return these special data types using the data types we created, as we described above.
Currently, users of the Freedom language can execute many simple statements, make statements while writing code with commands, use consitional statements such as if-else, use loops, write various functions, and use existing functions. In addition, this language can catch the error made by the user. Freedom language is also a language open to development. Currently, only the gcd() and isperfectnumber() methods are available in our language, but many more mathematical functions can be added. These may be important functions for mathematics such as Bernoulli function, Airy function, Hankel functio
We wanted it to be a more understandable language in which some special functions in mathematics were used by improving our familiarity with languages such as Java, C, Python. Thanks to this project, we have created a small demo of our dream language.



