VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Mock2TestsWithFullContext"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Public Calls    As New CallTrace
Public Errors   As New CallError

Public Sub Test1()
    Err.Clear
    Calls.Add "Test1"
End Sub

Public Sub Test2()
    Err.Clear
    Calls.Add "Test2"
End Sub

Public Sub Setup()
    Err.Clear
    Calls.Add "Setup"
End Sub

Public Sub Teardown()
    Err.Clear
    Calls.Add "Teardown"
End Sub

Public Sub FixtureSetup()
    Err.Clear
    Calls.Add "FixtureSetup"
End Sub

Public Sub FixtureTeardown()
    Err.Clear
    Calls.Add "FixtureTeardown"
End Sub
