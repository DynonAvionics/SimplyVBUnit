VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "RangeConstraint"
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
' Module: RangeConstraint
'
Option Explicit
Implements IResolvable
Implements IConstraint
Implements IComparisonConstraint

Private mExpression As ConstraintExpression
Private mActual     As Variant
Private mFrom       As Variant
Private mTo         As Variant
Private mFactory    As New ComparerFactory



Public Function IgnoreCase() As RangeConstraint
    mFactory.IgnoreCase = True
    Set IgnoreCase = Me
End Function

Public Function DateInterval(ByVal Interval As DateInterval) As RangeConstraint
    mFactory.Interval = Interval
    Set DateInterval = Me
End Function

Public Function Using(ByVal Comparer As IComparer) As RangeConstraint
    Set mFactory.ExternalComparer = Comparer
    Set Using = Me
End Function

Public Function Matches(ByRef Actual As Variant) As Boolean
    Dim Comparer As IComparer
    Set Comparer = mFactory.Create(Actual)
    
    Dim Result As Boolean
    If Comparer.Compare(Actual, mFrom) >= 0 Then
        Result = (Comparer.Compare(Actual, mTo) <= 0)
    End If
    
    If Result Then
        Matches = True
    Else
        VariantCopyInd mActual, Actual
    End If
End Function


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   Friend Methods
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Friend Sub Init(ByVal FromValue As Variant, ByVal ToValue As Variant, ByVal Expression As ConstraintExpression)
    VariantCopyInd mFrom, FromValue
    VariantCopyInd mTo, ToValue
    Set mExpression = Expression
End Sub


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   IComparisonConstraint Interface
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function IComparisonConstraint_AndAlso() As SimplyVBUnitType.IConstraintExpression
    Set IComparisonConstraint_AndAlso = mExpression.AndAlso
End Function

Private Function IComparisonConstraint_DateInterval(ByVal Interval As SimplyVBUnitType.DateInterval) As SimplyVBUnitType.IBasicExpression
    Set IComparisonConstraint_DateInterval = DateInterval(Interval)
End Function

Private Function IComparisonConstraint_IgnoreCase() As SimplyVBUnitType.IBasicExpression
    Set IComparisonConstraint_IgnoreCase = IgnoreCase
End Function

Private Function IComparisonConstraint_OrElse() As SimplyVBUnitType.IConstraintExpression
    Set IComparisonConstraint_OrElse = mExpression.OrElse
End Function

Private Function IComparisonConstraint_Using(ByVal Comparer As SimplyVBUnitType.IComparer) As SimplyVBUnitType.IBasicExpression
    Set IComparisonConstraint_Using = Using(Comparer)
End Function


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   IConstraint Interface
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function IConstraint_Matches(Actual As Variant) As Boolean
    IConstraint_Matches = Matches(Actual)
End Function

Private Sub IConstraint_WriteActualValueTo(ByVal Writer As TextMessageWriter)
    Writer.WriteValue mActual
End Sub

Private Sub IConstraint_WriteDescriptionTo(ByVal Writer As TextMessageWriter)
    Writer.WriteText "in range ({0},{1})", mFrom, mTo
End Sub

Private Sub IConstraint_WriteMessageTo(ByVal Writer As TextMessageWriter)
    Writer.DisplayConstraintDifferences Me
End Sub


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'   IResolvable Interface
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function IResolvable_Resolve() As IConstraint
    Set IResolvable_Resolve = Resolve(Me, mExpression)
End Function

