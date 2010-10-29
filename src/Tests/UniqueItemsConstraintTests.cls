VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "UniqueItemsConstraintTests"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Copyright 2010 Kelly Ethridge
'
' Licensed under the Apache License, Version 2.0 (the "License");
' you may not use this file except in compliance with the License.
' You may obtain a copy of the License at
'
'     http://www.apache.org/licenses/LICENSE-2.0
'
' Unless required by applicable law or agreed to in writing, software
' distributed under the License is distributed on an "AS IS" BASIS,
' WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
' See the License for the specific language governing permissions and
' limitations under the License.
'
' Module: UniqueItemsConstraintTests
'
Option Explicit
Implements ITestCaseSource

Private Sub ITestCaseSource_GetTestCases(ByVal Test As TestCaseDataBuilder)
    Select Case Test.MethodName
        Case "Matches_WithEnumerable_ReturnsExpected"
            Test.Use(Array(1, 2, 3)).Expect True
            Test.Use(Array(1, 2, 2)).Expect False
            Test.Use(Array(CLng(1), CInt(1), CByte(1))).Expect True
            Test.Use(Array(CLng(1), CInt(1), Int(1))).Expect False
            Test.Use(NewCollection(1, 2, 3)).Expect True
            Test.Use(NewCollection("1", "1")).Expect False
            Test.Use(1).Throws 5
    End Select
End Sub


Public Function Matches_WithEnumerable_ReturnsExpected(ByRef Actual As Variant) As Boolean
    Dim c As New UniqueItemsConstraint
    c.Strict
    
    Matches_WithEnumerable_ReturnsExpected = c.Matches(Actual)
End Function