Attribute VB_Name = "Proc_Mod"
'////////////////////////////////////////////////////////////////
'
'������ƣ�
'
'������ߣ����л��� QQ��449806776
'
'��Ȩ�������������޸Ļ������˲����������ע��ԭ��������Ϣ
'
'VB�����ߣ�����QQȺ����19871152
'
'////////////////////////////////////////////////////////////////
Option Explicit
Public Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Public Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function GetKeyState Lib "user32 " (ByVal nVirtKey As Long) As Integer
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

Private Const WM_SYSCOMMAND     As Long = &H112
Private Const SC_MAXIMIZE       As Long = 61488 '&H0F030
Private Const SC_KEYMENU        As Long = 61696 '&H0F100
Private Const WM_RBUTTONUP = &H205 '�Ҽ�����
Private Const WM_LBUTTONDBLCLK = &H203 ' ���˫��
Private Const WM_LBUTTONUP = &H202 ' �������
Private Const WM_LBUTTONCLICK = &H201 ' �������
Private Const WM_KEYDOWN = &H100 '���̰���
Private Const WM_KEYUP = &H101 '���̵���
Private Const VK_SHIFT = &H10
Private Const WM_MOUSEMOVE = &H200


Public Function HookCodeWindow(Mh As Long, Mdistr As String) '���ش��봰�ڹ���
On Error GoTo myErr
 If PrevProcPtr <> 0 Then Exit Function
    hWndCodeWindow = FindWindowEx(FindWindowEx(Mh, 0&, "MDIClient", vbNullString), 0&, "VbaWindow", Mdistr)
    PrevProcPtr = GetWindowLong(hWndCodeWindow, -4)
    
    PrevProcPtr = SetWindowLong(hWndCodeWindow, -4, AddressOf CodeWindowProc)
    'MsgBox hWndCodeWindow
    'JS_Frm.Show
    'JS_Frm.List1.AddItem "�ɹ����ش��봰�ڹ���"
    Exit Function
myErr:
        MsgBox Err.Description
End Function
Public Function UnHookCodeWindow() 'ж�ش��봰�ڹ���
    If PrevProcPtr Then
        SetWindowLong hWndCodeWindow, -4, PrevProcPtr
        PrevProcPtr = 0
        'JS_Frm.List1.AddItem "��ж�ش��봰�ڹ���"
    End If
End Function


Public Function CodeWindowProc(ByVal hwnd As Long, ByVal nMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
On Error Resume Next
Dim h As Long, pi As Integer, ls As String

'-------------------------------------------------------------
    If FKinput = True Then
        CodeWindowProc = CallWindowProc(PrevProcPtr, hwnd, nMsg, wParam, lParam)
        Exit Function
    End If
'-------------------------------------------------------------
    If nMsg = WM_KEYDOWN And (InStr(1, LCase(JS_Frm.Text1.Text), " as") <> 0 Or LCase(JS_Frm.Text1.Text) = "as" Or LCase(JS_Frm.Text1.Text) = "as ") And wParam = 32 Then
        If AutoCodeFrm.Visible = True Then Call NoTextInput
        CodeWindowProc = CallWindowProc(PrevProcPtr, hwnd, nMsg, wParam, lParam)
        Exit Function
    End If
'-------------------------------------------------------------
    'If (nMsg = WM_KEYDOWN Or nMsg = WM_KEYUP) And wParam = 32 And AutoCodeFrm.Visible = True Then
        'If LCase(JS_Frm.Text1.Text) = "on" Then
            'PostMessage JS_Frm.Text1.hwnd, WM_KEYDOWN, wParam, 0
            'CodeWindowProc = CallWindowProc(PrevProcPtr, hwnd, nMsg, wParam, lParam)
            'Exit Function
        'End If
    'End If
    If nMsg = WM_KEYDOWN And (wParam = 13 Or wParam = 32) And AutoCodeFrm.Visible = False Then
        Call NoTextInput '��������ı���ֹͣAutoCode
    End If
    If nMsg = WM_KEYDOWN And (wParam = 32 Or wParam = 13) And AutoCodeFrm.Visible = True Then

            CodeWindowProc = 0
        If wParam = 32 Then
            '�ÿո�ѡ�����Ŀ
            ls = "{BACKSPACE " & Len(JS_Frm.Text1) + 1 & "}" & AutoCodeFrm.ATlv.SelectedItem.Text & " "
            Call NoTextInput '��������ı���ֹͣAutoCode
            FKinput = True
            SendKeys ls, True
            FKinput = False
        Else
            '�ûس�ѡ�����Ŀ
            ls = "{BACKSPACE " & Len(JS_Frm.Text1) & "}" & AutoCodeFrm.ATlv.SelectedItem.Text '& "{ENTER}"
            Call NoTextInput '��������ı���ֹͣAutoCode
            FKinput = True
            SendKeys ls, True
            FKinput = False
        End If
        Exit Function
    End If
'-------------------------------------------------------------
    If nMsg = WM_KEYDOWN And (wParam = 38 Or wParam = 40) And AutoCodeFrm.Visible = True Then
    With AutoCodeFrm
            pi = .ATlv.SelectedItem.Index
        If wParam = 38 Then
            '���¡��ϡ���
            If pi > 1 Then
                .ATlv.ListItems(pi - 1).Selected = True
                .ATlv.ListItems(pi - 1).ForeColor = &HFFFFFF
                .ATlv.ListItems(pi - 1).EnsureVisible
                .SetLIC 'LV�����л�����ɫ
            End If
        Else
            '���¡��¡���
            If pi < .ATlv.ListItems.Count Then
                .ATlv.ListItems(pi + 1).Selected = True
                .ATlv.ListItems(pi + 1).ForeColor = &HFFFFFF
                .ATlv.ListItems(pi + 1).EnsureVisible
                .SetLIC 'LV�����л�����ɫ
            End If
        End If
     End With
        CodeWindowProc = 0
        Exit Function
    End If
'-------------------------------------------------------------
    h = FindWindowEx(0, 0&, "NameListWndClass", vbNullString)
    If h <> 0 Then
        If GetShow(h) = True Then
            If AutoCodeFrm.Visible = True Then Call NoTextInput
            CodeWindowProc = CallWindowProc(PrevProcPtr, hwnd, nMsg, wParam, lParam)
            Exit Function
        End If
    End If
'-------------------------------------------------------------
    If nMsg = WM_KEYDOWN Then
        JS_Frm.Caption = wParam
    End If
'-------------------------------------------------------------

    If nMsg = WM_LBUTTONUP Or nMsg = WM_RBUTTONUP Then Call NoTextInput '��������ı���ֹͣAutoCode
    If nMsg = WM_KEYDOWN And InStr(1, "|38|40|35|9|46|13|36|27|110|190|", "|" & wParam & "|") <> 0 Then
        If wParam = 110 Or wParam = 190 Then
            ls = "{BACKSPACE " & Len(JS_Frm.Text1) + 1 & "}" & AutoCodeFrm.ATlv.SelectedItem.Text & "{.}"
            Call NoTextInput '��������ı���ֹͣAutoCode
            FKinput = True
            SendKeys ls, True
            FKinput = False
        End If
        If AutoCodeFrm.Visible = True Then Call NoTextInput '��������ı���ֹͣAutoCode
    Else
        If nMsg = WM_KEYDOWN Then PostMessage JS_Frm.Text1.hwnd, WM_KEYDOWN, wParam, 0
    End If
'-------------------------------------------------------------

    If nMsg <> 132 And nMsg <> 512 Then

        If nMsg = WM_KEYUP Then
            If GetKeyState(VK_SHIFT) < 0 Then
                'If wParam <> 16 Then JS_Frm.List1.AddItem "SHIFT+" & Chr(wParam) & "  " & wParam & "  " & lParam: JS_Frm.List1.ListIndex = JS_Frm.List1.ListCount - 1
            Else
                'If wParam <> 16 Then JS_Frm.List1.AddItem nMsg & "  " & wParam & "  " & lParam: JS_Frm.List1.ListIndex = JS_Frm.List1.ListCount - 1
            End If
        End If
        If nMsg = WM_SYSCOMMAND Then
            'JS_Frm.List1.AddItem nMsg & "  " & wParam & "  " & lParam: JS_Frm.List1.ListIndex = JS_Frm.List1.ListCount - 1
            If wParam = 61536 Then
                CodeWindowProc = CallWindowProc(PrevProcPtr, hwnd, nMsg, wParam, lParam)
                Call NoTextInput '��������ı���ֹͣAutoCode
                UnHookCodeWindow
                Exit Function
            End If
        End If
        If nMsg = WM_LBUTTONUP Then
            'JS_Frm.List1.AddItem nMsg & "  " & wParam & "  " & lparam: JS_Frm.List1.ListIndex = JS_Frm.List1.ListCount - 1
        End If
    End If
            CodeWindowProc = CallWindowProc(ByVal PrevProcPtr, ByVal hwnd, ByVal nMsg, ByVal wParam, ByVal lParam)
End Function





