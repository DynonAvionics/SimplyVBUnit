VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ConstraintBuilderTests"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Copyright 2009 Kelly Ethridge
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
' Module: ConstraintBuilderTests
'
Option Explicit

Public Sub Resolve_WhenEmpty_StoresNothing()
    Dim Builder As New ConstraintBuilder
    
    Dim Actual As IConstraint
    Set Actual = Builder.Resolve
    
    Assert.IsTrue Actual Is Nothing
End Sub

Public Sub Resolve_WithOneConstraint_StoresAsFinalConstraint()
    Dim Fake As New StubConstraint
    Dim Builder As New ConstraintBuilder
    Builder.AddConstraint Fake
    
    Dim Actual As IConstraint
    Set Actual = Builder.Resolve
    
    Assert.IsTrue Actual Is Fake
End Sub

Public Sub Resolve_WithOperator_ResolvesConstraints()
    Dim FakeLeft    As New StubConstraint
    Dim FakeRight   As New StubConstraint
    Dim Op          As New AndOperator
    Dim Builder     As New ConstraintBuilder
    Builder.AddConstraint FakeLeft
    Builder.AddConstraint FakeRight
    Builder.AddOperator Op
    
    Dim Actual As AndConstraint
    Set Actual = Builder.Resolve
    
    Assert.IsTrue Actual.LeftSide Is FakeLeft
    Assert.IsTrue Actual.RightSide Is FakeRight
End Sub

Public Sub Resolve_WithParenOperators_ResolvesWithinParens()
    Dim FakeOutside As New StubConstraint
    Dim FakeLeft    As New StubConstraint
    Dim FakeRight   As New StubConstraint
    Dim Builder     As New ConstraintBuilder
    Builder.AddConstraint FakeOutside
    Builder.AddOperator New AndOperator
    Builder.AddOperator New LeftParenOperator
    Builder.AddConstraint FakeLeft
    Builder.AddOperator New AndOperator
    Builder.AddConstraint FakeRight
    Builder.AddOperator New RightParenOperator
    
    Dim Op As AndConstraint
    Set Op = Builder.Resolve
    
    Assert.AreSame FakeOutside, Op.LeftSide
    Assert.IsTrue TypeOf Op.RightSide Is AndConstraint
End Sub

Public Sub Resolve_WithParenOperators_ResolvesWithinParens2()
    Dim FakeOutside As New StubConstraint
    Dim FakeLeft    As New StubConstraint
    Dim FakeRight   As New StubConstraint
    Dim Builder     As New ConstraintBuilder
    Builder.AddOperator New LeftParenOperator
    Builder.AddConstraint FakeOutside
    Builder.AddOperator New AndOperator
    Builder.AddConstraint FakeLeft
    Builder.AddOperator New RightParenOperator
    Builder.AddOperator New AndOperator
    Builder.AddConstraint FakeRight
    
    Dim Op As AndConstraint
    Set Op = Builder.Resolve
    
    Assert.IsTrue TypeOf Op.LeftSide Is AndConstraint
    Assert.AreSame FakeRight, Op.RightSide
End Sub
