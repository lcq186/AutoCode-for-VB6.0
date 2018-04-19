VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Parent_Cls"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'////////////////////////////////////////////////////////////////
'
'������ƣ�
'
'������ߣ����л��� QQ��449806776
'
'��Ȩ�������������޸Ļ��������˲����������ע��ԭ��������Ϣ
'
'VB�����ߣ�����QQȺ����19871152
'
'////////////////////////////////////////////////////////////////
Option Explicit

Private Declare Function MoveWindow Lib "user32" (ByVal hwnd As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal bRepaint As Long) As Long
Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type


Public Sub SetMdi(Fhw As Long, Zhw As Long, SetMove As String) '���Զ������б����� ����Ϊ���봰�ڵ��Ӵ���
Dim Rt() As String, rctemp As RECT
    
    OldParent = SetParent(Zhw, Fhw)              'ָ��������Ϊ�򿪳���ĸ�����
    Rt = Split(SetMove, ",") 'ʾ����"10,10,200,300,"
    GetWindowRect Zhw, rctemp                 'ָ���ӳ�����λ��
    MoveWindow Val(Zhw), Val(Rt(0)), Val(Rt(1)), Val(Rt(2)), Val(Rt(3)), 1

End Sub

Public Sub OutMdi(Zhw As Long) '�ͷ��Ӵ���  �Զ������б�����
    If OldParent Then
        SetParent Zhw, OldParent
        OldParent = 0
    End If
End Sub
