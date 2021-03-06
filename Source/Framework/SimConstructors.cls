VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SimConstructors"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'The MIT License (MIT)
'Copyright (c) 2012 Kelly Ethridge
'
'Permission is hereby granted, free of charge, to any person obtaining a copy
'of this software and associated documentation files (the "Software"), to deal
'in the Software without restriction, including without limitation the rights to
'use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
'the Software, and to permit persons to whom the Software is furnished to do so,
'subject to the following conditions:
'
'The above copyright notice and this permission notice shall be included in all
'copies or substantial portions of the Software.
'
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
'INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
'PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
'FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
'OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
'DEALINGS IN THE SOFTWARE.
'
'
' Module: SimConstructors
'
Option Explicit

Public Function NewTestFixture(ByVal TestClass As Object, Optional ByVal Name As String) As TestFixture
    Dim Suite As New TestSuite
    Suite.InitTestFixture TestClass, Name
    Set NewTestFixture = Suite
End Function

Public Function NewTestResult(ByVal Test As ITest) As TestResult
    Set NewTestResult = New TestResult
    NewTestResult.Init Test
End Function

Public Function NewTestCase(ByRef Name As String, ByRef DisplayName As String, ByVal TestMethod As ITestMethod) As TestCase
    Set NewTestCase = New TestCase
    NewTestCase.Init Name, DisplayName, TestMethod
End Function

Public Function NewSimpleTestMethod(ByVal TestClass As Object, ByRef MemberId As Variant) As SimpleTestMethod
    Set NewSimpleTestMethod = New SimpleTestMethod
    NewSimpleTestMethod.Init TestClass, MemberId
End Function

Public Function NewTestSuite(ByRef Name As String) As TestSuite
    Set NewTestSuite = New TestSuite
    NewTestSuite.InitTestSuite Name
End Function

Public Function NewErrorInfo(ByVal Number As Long, Optional ByRef Source As String, Optional ByRef Description As String, Optional ByVal LastDllError As Long) As ErrorInfo
    Set NewErrorInfo = New ErrorInfo
    NewErrorInfo.Init Number, Source, Description, LastDllError
End Function

Public Function NewParameterizedTestMethod(ByVal TestClass As Object, ByRef MemberId As Variant, ByVal TestCaseData As TestCaseData) As ParameterizedTestMethod
    Set NewParameterizedTestMethod = New ParameterizedTestMethod
    NewParameterizedTestMethod.Init TestClass, MemberId, TestCaseData
End Function

Public Function NewTestListEnumerator(ByVal List As TestList) As TestListEnumerator
    Set NewTestListEnumerator = New TestListEnumerator
    NewTestListEnumerator.Init List
End Function

Public Function NewTestCaseCollector(ByVal MethodName As String, Optional ByVal DataStore As Collection) As TestCaseCollector
    Set NewTestCaseCollector = New TestCaseCollector
    NewTestCaseCollector.Init MethodName, DataStore
End Function

Public Function NewEqualConstraint(ByRef Expected As Variant, Optional ByVal Expression As ConstraintExpression) As EqualConstraint
    Set NewEqualConstraint = New EqualConstraint
    NewEqualConstraint.Init Expected, Expression
End Function

Public Function NewArrayEnumerator(ByRef Arr As Variant) As ArrayEnumerator
    Set NewArrayEnumerator = New ArrayEnumerator
    NewArrayEnumerator.Init Arr
End Function

Public Function NewEnumVariantEnumerator(ByVal Obj As Object) As EnumVariantEnumerator
    Set NewEnumVariantEnumerator = New EnumVariantEnumerator
    NewEnumVariantEnumerator.Init Obj
End Function

Public Function NewTestOutput(ByRef Text As String, ByVal OutputType As TestOutputType) As TestOutput
    Set NewTestOutput = New TestOutput
    NewTestOutput.Init Text, OutputType
End Function

Public Function NewContextMethods(ByVal SetupMethod As ITestMethod, ByVal TeardownMethod As ITestMethod) As ContextMethods
    Set NewContextMethods = New ContextMethods
    NewContextMethods.Init SetupMethod, TeardownMethod
End Function

Public Function NewTestRunner(ByVal Test As ITest) As TestRunner
    Set NewTestRunner = New TestRunner
    NewTestRunner.Init Test
End Function

Public Function NewNotFilter(ByVal BaseFilter As ITestFilter) As NotFilter
    Set NewNotFilter = New NotFilter
    NewNotFilter.Init BaseFilter
End Function

Public Function NewAndConstraint(ByVal LeftSide As IConstraint, ByVal RightSide As IConstraint) As AndConstraint
    Set NewAndConstraint = New AndConstraint
    NewAndConstraint.Init LeftSide, RightSide
End Function

Public Function NewOrConstraint(ByVal LeftSide As IConstraint, ByVal RightSide As IConstraint) As OrConstraint
    Set NewOrConstraint = New OrConstraint
    NewOrConstraint.Init LeftSide, RightSide
End Function

Public Function NewNotConstraint(ByVal BaseConstraint As IConstraint) As NotConstraint
    Set NewNotConstraint = New NotConstraint
    NewNotConstraint.Init BaseConstraint
End Function

Public Function NewThrowsConstraint(ByVal Expected As ErrorInfo) As ThrowsConstraint
    Set NewThrowsConstraint = New ThrowsConstraint
    NewThrowsConstraint.Init Expected
End Function

Public Function NewTestCaseModifier(ByVal Data As TestCaseData) As TestCaseModifier
    Set NewTestCaseModifier = New TestCaseModifier
    NewTestCaseModifier.Init Data
End Function

Public Function NewTolerance(ByRef Amount As Variant) As Tolerance
    Set NewTolerance = New Tolerance
    NewTolerance.Init Amount
End Function

Public Function NewTally(ByRef Value As Variant) As Tally
    Set NewTally = New Tally
    NewTally.Init Value
End Function

Public Function NewComparisonConstraint(ByRef Expected As Variant, ByVal CanBeLess As Boolean, ByVal CanBeGreater As Boolean, ByVal CanBeEqual As Boolean, ByRef Predicate As String, Optional ByVal Expression As ConstraintExpression) As ComparisonConstraint
    Set NewComparisonConstraint = New ComparisonConstraint
    NewComparisonConstraint.Init Expected, CanBeLess, CanBeGreater, CanBeEqual, Predicate, Expression
End Function

Public Function NewRangeConstraint(ByRef FromValue As Variant, ByRef ToValue As Variant, Optional ByVal Expression As ConstraintExpression) As RangeConstraint
    Set NewRangeConstraint = New RangeConstraint
    NewRangeConstraint.Init FromValue, ToValue, Expression
End Function

Public Function NewResolvableConstraint(ByVal InnerConstraint As IConstraint, ByVal Expression As ConstraintExpression) As ResolvableConstraint
    Set NewResolvableConstraint = New ResolvableConstraint
    NewResolvableConstraint.Init InnerConstraint, Expression
End Function

Public Function NewSameAsConstraint(ByVal Expected As Object) As SameAsConstraint
    Set NewSameAsConstraint = New SameAsConstraint
    NewSameAsConstraint.Init Expected
End Function

Public Function NewUniqueItemsConstraint(Optional ByVal Expression As ConstraintExpression) As UniqueItemsConstraint
    Set NewUniqueItemsConstraint = New UniqueItemsConstraint
    NewUniqueItemsConstraint.Init Expression
End Function

Public Function NewEquivalentConstraint(ByRef Expected As Variant, Optional ByVal Expression As ConstraintExpression) As EquivalentConstraint
    Set NewEquivalentConstraint = New EquivalentConstraint
    NewEquivalentConstraint.Init Expected, Expression
End Function

Public Function NewSubsetOfConstraint(ByRef Expected As Variant, Optional ByVal Expression As ConstraintExpression) As SubsetOfConstraint
    Set NewSubsetOfConstraint = New SubsetOfConstraint
    NewSubsetOfConstraint.Init Expected, Expression
End Function

Public Function NewSubstringConstraint(ByRef Expected As String, Optional ByVal Expression As ConstraintExpression) As SubstringConstraint
    Set NewSubstringConstraint = New SubstringConstraint
    NewSubstringConstraint.Init Expected, Expression
End Function

Public Function NewStartsWithConstraint(ByRef Expected As String, Optional ByVal Expression As ConstraintExpression) As StartsWithConstraint
    Set NewStartsWithConstraint = New StartsWithConstraint
    NewStartsWithConstraint.Init Expected, Expression
End Function

Public Function NewEndsWithConstraint(ByRef Expected As String, Optional ByVal Expression As ConstraintExpression) As EndsWithConstraint
    Set NewEndsWithConstraint = New EndsWithConstraint
    NewEndsWithConstraint.Init Expected, Expression
End Function

Public Function NewRegexConstraint(ByRef Pattern As String, Optional ByVal Expression As ConstraintExpression) As RegexConstraint
    Set NewRegexConstraint = New RegexConstraint
    NewRegexConstraint.Init Pattern, Expression
End Function

Public Function NewSamePathConstraint(ByRef Expected As String, Optional ByVal Expression As ConstraintExpression) As SamePathConstraint
    Set NewSamePathConstraint = New SamePathConstraint
    NewSamePathConstraint.Init Expected, Expression
End Function

Public Function NewSamePathOrUnderConstraint(ByRef Expected As String, Optional ByVal Expression As ConstraintExpression) As SamePathOrUnderConstraint
    Set NewSamePathOrUnderConstraint = New SamePathOrUnderConstraint
    NewSamePathOrUnderConstraint.Init Expected, Expression
End Function

Public Function NewAllItemsConstraint(ByVal Constraint As IConstraint) As AllItemsConstraint
    Set NewAllItemsConstraint = New AllItemsConstraint
    NewAllItemsConstraint.Init Constraint
End Function

Public Function NewSomeItemsConstraint(ByVal Constraint As IConstraint) As SomeItemsConstraint
    Set NewSomeItemsConstraint = New SomeItemsConstraint
    NewSomeItemsConstraint.Init Constraint
End Function

Public Function NewNoItemsConstraint(ByVal Constraint As IConstraint) As NoItemsConstraint
    Set NewNoItemsConstraint = New NoItemsConstraint
    NewNoItemsConstraint.Init Constraint
End Function

Public Function NewCollectionContainsConstraint(ByRef Expected As Variant, Optional ByVal Expression As ConstraintExpression) As CollectionContainsCstr
    Set NewCollectionContainsConstraint = New CollectionContainsCstr
    NewCollectionContainsConstraint.Init Expected, Expression
End Function

Public Function NewLateBoundTestMethod(ByVal TestClass As Object, ByRef MethodName As String, ByVal TestCaseData As TestCaseData) As LateBoundTestMethod
    Set NewLateBoundTestMethod = New LateBoundTestMethod
    NewLateBoundTestMethod.Init TestClass, MethodName, TestCaseData
End Function

Public Function NewCategorization(ByRef Name As String, ByVal IsFixture As Boolean) As Categorization
    Set NewCategorization = New Categorization
    NewCategorization.Init Name, IsFixture
End Function

Public Function NewCategoryStore(ByRef FixtureName As String) As CategoryStore
    Set NewCategoryStore = New CategoryStore
    NewCategoryStore.Init FixtureName
End Function

Public Function NewCategoryCollector(ByVal Store As CategoryStore) As CategoryCollector
    Set NewCategoryCollector = New CategoryCollector
    NewCategoryCollector.Init Store
End Function

Public Function NewTestOutputWriter(ByVal Listener As IEventListener, ByVal OutputType As TestOutputType) As TestOutputWriter
    Set NewTestOutputWriter = New TestOutputWriter
    NewTestOutputWriter.Init Listener, OutputType
End Function

Friend Function NewConstraintProxy(ByVal Constraint As IConstraint) As IConstraint
    Dim Proxy As New ConstraintProxy
    Proxy.Init Constraint
    Set NewConstraintProxy = Proxy
End Function

Friend Function NewFailurePoint(ByVal Position As Long, ByRef Expected As Variant, ByRef Actual As Variant) As FailurePoint
    Set NewFailurePoint = New FailurePoint
    NewFailurePoint.Init Position, Expected, Actual
End Function
