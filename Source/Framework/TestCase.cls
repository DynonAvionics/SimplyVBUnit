VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "TestCase"
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
' Module: TestCase
'
Option Explicit
Implements ITest

Private mTestMethod         As ITestMethod
Private mName               As String
Private mDisplayName        As String
Private mParent             As Long
Private mTicks              As Currency
Private mRunState           As RunState
Private mContext            As ContextMethods
Private mRunner             As ITestRunner
Private mCategories         As Categorization


Public Property Get Categories() As Categorization
    Set Categories = mCategories
End Property

Public Property Set Categories(ByVal RHS As Categorization)
    Set mCategories = RHS
End Property

Public Property Get HasCategories() As Boolean
    If Not mCategories Is Nothing Then
        HasCategories = mCategories.Count > 0
    End If
End Property

Public Function CountTestCases(ByVal Filter As ITestFilter) As Long
    If Filter.Pass(Me) Then
        CountTestCases = 1
    End If
End Function

Public Property Get RunState() As RunState
    RunState = mRunState
End Property

Public Property Let RunState(ByVal RHS As RunState)
    mRunState = RHS
End Property

Public Property Get HasParent() As Boolean
    HasParent = (mParent <> vbNullPtr)
End Property

Public Property Get TestCount() As Long
    TestCount = 1
End Property

Public Property Get Tests() As TestList
    Set Tests = Nothing
End Property

Public Property Get TestClass() As Object
    Set TestClass = mTestMethod.TestClass
End Property

Public Property Get Name() As String
    Name = mName
End Property

Public Property Get DisplayName() As String
    DisplayName = mDisplayName
End Property

Public Property Get FullName() As String
    FullName = TestUtils.BuildFullName(Me)
End Property

Public Property Get IsSuite() As Boolean
    IsSuite = False
End Property

Public Property Set Parent(ByVal RHS As ITest)
    mParent = ObjPtr(RHS)
End Property

Public Property Get Parent() As ITest
    Set Parent = TestUtils.ObjectFromPointer(mParent)
End Property

Public Function Run(Optional ByVal Listener As IEventListener) As TestResult
    If Listener Is Nothing Then
        Set Listener = NullListener.Instance
    End If
    
    Dim Result As TestResult
    Set Result = Sim.NewTestResult(Me)
    
    If Not mRunner.IsCancelled Then
        With New TestContext
            Listener.TestCaseStarted Me
            
            If Me.RunState = RunnableRunState Then
                RunTestCase Result, Listener
            Else
                Result.Invalid
            End If
        
            Listener.TestCaseFinished Result
        End With
    Else
        Result.SetResult CancelledState, "test cancelled by user"
    End If
    
    Set Run = Result
End Function

Private Sub RunTestCase(ByVal Result As TestResult, ByVal Listener As IEventListener)
    InitMetrics
    
    If RunSetup(Result) Then
        RunTestMethod Result, Listener
    End If
    
    RunTeardown Result
    RecordMetrics Result
End Sub

Private Sub InitMetrics()
    StartTiming
End Sub

Private Sub RecordMetrics(ByVal Result As TestResult)
    Result.Time = StopTiming
    Result.AssertCount = TestContext.AssertCount
End Sub

Private Function RunSetup(ByVal Result As TestResult) As Boolean
    On Error GoTo errTrap
    
    mContext.RunSetup
    
    RunSetup = True
    Exit Function
    
errTrap:
    If Err.Number = AssertCode.IgnoreCode Then
        RunSetup = True
    Else
        Result.Error "Error " & Err.Number & ", " & Err.Description, SetupSite
    End If
End Function

Private Sub RunTestMethod(ByVal Result As TestResult, ByVal Listener As IEventListener)
    On Error Resume Next
    mTestMethod.Run
    
    Dim Info As ErrorInfo
    Set Info = ErrorInfo.FromErr(Err)
    
    On Error GoTo 0
    Err.Clear
    
    Dim ExpectedThrows As ThrowsConstraint
    Set ExpectedThrows = TestContext.Throws
    
    Dim Writer As New TextMessageWriter
    
    Select Case Info.Number
        Case AssertCode.SuccessCode, ErrorCode.NoError
            If ExpectedThrows Is Nothing Then
                Result.Success Info.Description
            Else
                ExpectedThrows.WriteMessageTo Writer
                Result.Failure Writer.ToString
            End If
            
        Case AssertCode.FailureCode
            Result.Failure Info.Description, TestSite
            
        Case AssertCode.IgnoreCode
            Result.Ignore Info.Description
            
        Case Else
            If ExpectedThrows Is Nothing Then
                Result.Error Info.Description, TestSite
                Listener.UnhandledError Info
            ElseIf ExpectedThrows.Matches(Info) Then
                Result.Success
            Else
                ExpectedThrows.WriteMessageTo Writer
                Result.Failure Writer.ToString
            End If
    End Select
End Sub

Private Sub RunTeardown(ByVal Result As TestResult)
    On Error GoTo errTrap
    
    mContext.RunTeardown
    Exit Sub
    
errTrap:
    Result.Error "Error " & Err.Number & ", " & Err.Description, TeardownSite
End Sub

Private Sub StartTiming()
    mTicks = Timing.GetTicks
End Sub

Private Function StopTiming() As Currency
    StopTiming = Timing.GetTime(mTicks)
End Function


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Friend Methods
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Friend Sub Init(ByRef Name As String, ByRef DisplayName As String, ByVal TestMethod As ITestMethod)
    If Len(Name) = 0 Then _
        Error.CannotBeEmpty Me, "Init", "Name"
    If Len(DisplayName) = 0 Then _
        Error.CannotBeEmpty Me, "Init", "DisplayName"
    If TestMethod Is Nothing Then _
        Error.CannotBeNothing Me, "Init", "TestMethod"
    
    mName = Name
    mDisplayName = DisplayName
    Set mTestMethod = TestMethod
End Sub

Friend Property Set Context(ByVal RHS As ContextMethods)
    If Not RHS Is Nothing Then
        Set mContext = RHS
    Else
        Set mContext = NullContext.Instance
    End If
End Property


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Class Events
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Sub Class_Initialize()
    Me.RunState = RunnableRunState
    Set mContext = NullContext.Instance
    Set mRunner = NullTestRunner.Instance
End Sub


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   ITest Interface
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Property Set ITest_Categories(ByVal RHS As Categorization)
    Set Categories = RHS
End Property

Private Property Get ITest_Categories() As Categorization
    Set ITest_Categories = Categories
End Property

Private Function ITest_CountTestCases(ByVal Filter As ITestFilter) As Long
    ITest_CountTestCases = CountTestCases(Filter)
End Function

Private Property Get ITest_DisplayName() As String
    ITest_DisplayName = DisplayName
End Property

Private Property Get ITest_FullName() As String
    ITest_FullName = FullName
End Property

Private Property Get ITest_HasCategories() As Boolean
    ITest_HasCategories = HasCategories
End Property

Private Property Get ITest_HasParent() As Boolean
    ITest_HasParent = HasParent
End Property

Private Property Get ITest_IsSuite() As Boolean
    ITest_IsSuite = IsSuite
End Property

Private Property Get ITest_Parent() As ITest
    Set ITest_Parent = Parent
End Property

Private Property Set ITest_Parent(ByVal RHS As ITest)
    Set Parent = RHS
End Property

Private Property Get ITest_Name() As String
    ITest_Name = Name
End Property

Private Function ITest_Run(Optional ByVal Listener As IEventListener, Optional ByVal Filter As ITestFilter) As TestResult
    Set ITest_Run = Run(Listener)
End Function

Private Property Let ITest_RunState(ByVal RHS As RunState)
    Me.RunState = RHS
End Property

Private Property Get ITest_RunState() As RunState
    ITest_RunState = Me.RunState
End Property

Private Sub ITest_SetRunner(ByVal Runner As ITestRunner)
    Set mRunner = Runner
End Sub

Private Sub ITest_Sort(Optional ByVal Comparer As ITestComparer)
    ' do nothing
End Sub

Private Property Get ITest_TestClass() As Object
    Set ITest_TestClass = TestClass
End Property

Private Property Get ITest_TestCount() As Long
    ITest_TestCount = TestCount
End Property

Private Property Get ITest_Tests() As TestList
    Set ITest_Tests = Tests
End Property
