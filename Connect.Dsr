VERSION 5.00
Begin {AC0714F6-3D04-11D1-AE7D-00A0C90F26F4} Connect 
   ClientHeight    =   9405
   ClientLeft      =   1740
   ClientTop       =   1545
   ClientWidth     =   14100
   _ExtentX        =   24871
   _ExtentY        =   16589
   _Version        =   393216
   Description     =   "Add-In Project Template"
   DisplayName     =   "My Add-In"
   AppName         =   "Visual Basic"
   AppVer          =   "Visual Basic 6.0"
   LoadName        =   "Command Line / Startup"
   LoadBehavior    =   5
   RegLocation     =   "HKEY_CURRENT_USER\Software\Microsoft\Visual Basic\6.0"
   CmdLineSupport  =   -1  'True
End
Attribute VB_Name = "Connect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'VBProjects����: ͨ���ü��Ͽ��Է���VBʵ�����������Ĺ���
'Windows���ϣ�ͨ���ü��Ͽ��Է������еĴ��ڣ������ؼ������������Լ������еĴ���ȡ�
'CodePanes����: ͨ���ü��Ͽ��Է������еĴ��봰�ڣ����Ի�ô��봰���еĴ����Լ��ı����еĴ���
'CommandBars���ϣ�ͨ���ü��Ͽ��Է���VBʵ���е�����������������֧�ֿ��ٲ˵�����������
'Events ����: ͨ���ü��ϲ�����Է���VB�е������¼�����

Option Explicit

Public FormDisplayed          As Boolean
Dim iVBInstance             As VBIDE.VBE
Dim mcbMenuCommandBar         As Office.CommandBarControl
Dim mfrmAddIn                 As New frmAddIn
Public WithEvents MenuHandler As CommandBarEvents          '�������¼����
Attribute MenuHandler.VB_VarHelpID = -1
Public WithEvents mButton    As CommandBarEvents
Attribute mButton.VB_VarHelpID = -1

Sub Hide()
    
    On Error Resume Next
    
    FormDisplayed = False
    mfrmAddIn.Hide
   
End Sub

Sub Show()
  
    On Error Resume Next
    
    If mfrmAddIn Is Nothing Then
        Set mfrmAddIn = New frmAddIn
    End If
    
    Set VBInstance = iVBInstance
    Set Connect = Me
    FormDisplayed = True
    
    mfrmAddIn.Show 1, Me
End Sub

'------------------------------------------------------
'������������ӳ��� VB
'------------------------------------------------------
Private Sub AddinInstance_OnConnection(ByVal Application As Object, ByVal ConnectMode As AddInDesignerObjects.ext_ConnectMode, ByVal AddInInst As Object, custom() As Variant)
    On Error GoTo error_handler
    
    '���� vb ʵ��
    Set iVBInstance = Application
    
    '������һ�����öϵ��Լ����Բ�ͬ��ӳ���
    '����,���Լ��������ʵ�λ��
    'Debug.Print VBInstance.FullName

    If ConnectMode = ext_cm_External Then
        '�������򵼹���������������
        Me.Show
    Else
        'Set mcbMenuCommandBar = AddToAddInCommandBar("����AutoCode")
        '��ȡ�¼�
        'Set Me.MenuHandler = iVBInstance.Events.CommandBarEvents(mcbMenuCommandBar)
        
            'iVBInstance.CommandBars(1).Controls.Add Type:=10, Before:=2
            'iVBInstance.CommandBars(1).Controls(2).Caption = "�ҵĲ˵�"
            'iVBInstance.CommandBars(1).Controls(2).OnAction = "OKcmd"
            'iVBInstance.CommandBars(1).Controls(2).Visible = True
            Set iButton = iVBInstance.CommandBars(1).Controls.Add(Type:=msoControlButton, temporary:=True)
                With iButton
                    .Caption = " AutoCode "
                    .ToolTipText = "AutoCode"
                    .Style = msoButtonCaption 'msoButtonIconAndCaption 'msoButtonIcon 'msoButtonCaption
                    '.BeginGroup = True
                    .State = msoButtonUp
                End With
                Set mButton = iVBInstance.Events.CommandBarEvents(iButton)
    End If
  
    If ConnectMode = ext_cm_AfterStartup Then
        If GetSetting(App.Title, "Settings", "DisplayOnConnect", "0") = "1" Then
            '���������������ʾ�Ĵ���
            Me.Show
        End If
    End If
  
    Exit Sub
    
error_handler:
    
    MsgBox Err.Description
    
End Sub

'------------------------------------------------------
'��������� VB ��ɾ����ӳ���
'------------------------------------------------------
Private Sub AddinInstance_OnDisconnection(ByVal RemoveMode As AddInDesignerObjects.ext_DisconnectMode, custom() As Variant)
    On Error Resume Next
    
    'ɾ����������Ŀ
    iButton.Delete
    
    '�ر���ӳ���
    If FormDisplayed Then
        SaveSetting App.Title, "Settings", "DisplayOnConnect", "1"
        FormDisplayed = False
    Else
        SaveSetting App.Title, "Settings", "DisplayOnConnect", "0"
    End If
    
    Unload mfrmAddIn
    Set mfrmAddIn = Nothing

End Sub

Private Sub IDTExtensibility_OnStartupComplete(custom() As Variant)
    If GetSetting(App.Title, "Settings", "DisplayOnConnect", "0") = "1" Then
        '���������������ʾ�Ĵ���
        Me.Show
    End If
End Sub

'�� IDE �еĲ˵�������ʱ,����¼�������
'Private Sub MenuHandler_Click(ByVal CommandBarControl As Object, handled As Boolean, CancelDefault As Boolean)
    'Me.Show
'End Sub

'Function AddToAddInCommandBar(sCaption As String) As Office.CommandBarControl
'    Dim cbMenuCommandBar As Office.CommandBarControl  '����������
'    Dim cbMenu As Object
'
'    On Error GoTo AddToAddInCommandBarErr
'
'    '�쿴�ܷ��ҵ���ӳ���˵�
'    Set cbMenu = iVBInstance.CommandBars("Add-Ins")
'    If cbMenu Is Nothing Then
'        'û����Ч����ӳ���,����ʧ��
'        Exit Function
'    End If
'
'    '�������������
'    Set cbMenuCommandBar = cbMenu.Controls.Add(1)
'    '���ñ���
'
'    cbMenuCommandBar.Caption = sCaption
'
'    Set AddToAddInCommandBar = cbMenuCommandBar
'
'    Exit Function
'
'AddToAddInCommandBarErr:
'
'End Function

Private Sub mButton_Click(ByVal CommandBarControl As Object, handled As Boolean, CancelDefault As Boolean)
    Me.Show
End Sub
