VERSION 5.00
Begin VB.Form frmAddIn 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "����AutoCode for VB6.0 ѧϰ��"
   ClientHeight    =   3450
   ClientLeft      =   2175
   ClientTop       =   1935
   ClientWidth     =   6030
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3450
   ScaleWidth      =   6030
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  '����������
   Begin VB.CommandButton Command1 
      Caption         =   "ֹͣAutoCode����"
      Enabled         =   0   'False
      Height          =   540
      Left            =   3045
      TabIndex        =   2
      Top             =   2760
      Width           =   2145
   End
   Begin VB.Frame Frame1 
      Height          =   2655
      Left            =   75
      TabIndex        =   1
      Top             =   -15
      Width           =   5895
      Begin VB.Frame Frame3 
         BackColor       =   &H00000000&
         BorderStyle     =   0  'None
         Height          =   600
         Left            =   45
         TabIndex        =   3
         Top             =   1995
         Width           =   5790
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "���룬���س���ѡ��ESC��ȡ���Զ��б�"
            ForeColor       =   &H0000FF00&
            Height          =   180
            Left            =   645
            TabIndex        =   5
            Top             =   345
            Width           =   3510
         End
         Begin VB.Label Label1 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "˵����������ɸ����ڿհ�������VB�ؼ��ֻ��߿ؼ�����ʱ���Զ�ƥ��"
            ForeColor       =   &H0000FF00&
            Height          =   180
            Left            =   105
            TabIndex        =   4
            Top             =   90
            Width           =   5580
         End
      End
      Begin VB.Image Image1 
         Height          =   1860
         Left            =   45
         Picture         =   "frmAddIn.frx":0000
         Top             =   120
         Width           =   5790
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "����AutoCode����"
      Height          =   540
      Left            =   735
      TabIndex        =   0
      Top             =   2760
      Width           =   2145
   End
End
Attribute VB_Name = "frmAddIn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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

'mid(VBInstance.VBProjects.StartProject.VBComponents(List1.List(List1.ListIndex)).CodeModule.Lines(a,1),b-3,3)
'Debug.Print Me.TextWidth("��"), Me.TextHeight("��")
'VBInstance.ActiveCodePane.CodeModule.Parent.Type 5=����Ĵ���  6=MDI������� 1=ģ�����  2=��ģ��  8=�û��ؼ�ģ��
'CodeModule.Members ������̼���

Option Explicit






Private Sub Command1_Click()
    Me.Hide
    JS_Frm.Timer1.Enabled = False
    If PrevProcPtr <> 0 Then NoTextInput: UnHookCodeWindow
    Unload AutoCodeFrm
    Command3.Enabled = True
    Command1.Enabled = False
End Sub

Private Sub Command3_Click() '����AutoCode����
    Me.Hide
    Load JS_Frm
    Call Initialization '��ʼ��
    JS_Frm.Timer1.Enabled = True
    Command3.Enabled = False
    Command1.Enabled = True
End Sub
    'HookCodeWindow VBInstance.MainWindow.hwnd, VBInstance.ActiveCodePane.Window.Caption
    'Call Initialization



'=================================================================================================================
'Sub GetFrm()
'Dim mCop As Object
''��õ�ǰ���������е����ж���
'    For Each mCop In VBInstance.VBProjects.StartProject.VBComponents
'        If mCop.Type = vbext_ct_VBForm Then
'            List1.AddItem mCop.Name '��������Ǵ������;ͽ�����ӵ�ListBox��
'        End If
'    Next
'
'    If List1.ListCount < 1 Then
'        MsgBox "������û����ӿؼ��Ĵ���"
'        Connect.Hide
'    Else
'        List1.ListIndex = 0
'    End If
'    Command1.Caption = "Add Code"
'End Sub

'Private Sub Command1_Click()
'Dim xComp As VBComponent
'Dim xModule As VBComponent
'Dim xForm As VBForm
'Dim xControl As VBControl
'Dim xCode As CodeModule
'
'
'
'    '����û�ѡ��Ĵ������
'    Set xComp = VBInstance.VBProjects.StartProject.VBComponents(List1.List(List1.ListIndex))
'    '��ô������������
'    Set xForm = xComp.Designer
'
'    '���һ��CommandButton��������
'    Set xControl = xForm.VBControls.Add("VB.CommandButton")
'    '�趨�ؼ�������
'    xControl.Properties("Name") = "cmdButton"
'    '��ӿؼ���Click�¼�����
'    xComp.CodeModule.CreateEventProc "Click", "cmdButton"
'
'    '���һ����ģ�鵽������
'    Set xModule = VBInstance.VBProjects.StartProject.VBComponents.Add(vbext_ct_StdModule)
'    '�趨ģ������
'    xModule.Properties("Name") = "ModulTemp"
'    '��ö���Ĵ������
'    Set xCode = xModule.CodeModule
'
'Dim astr As String
'
'    '���mClick�ӳ�����ģ����
'    astr = "Public Sub mClick()" + Chr(13) + Chr(10) + Chr(vbKeyTab) + "MsgBox ""You click a button!""" + Chr(13) + Chr(10) + "End Sub"
'    xCode.AddFromString astr
'
'Dim lCount As Long
'
'    '��cmdButton��Click�¼������ִ��mClick�ӳ���
'        lCount = xComp.CodeModule.ProcBodyLine("cmdButton_Click", vbext_pk_Proc)
'    If lCount <> 0 Then
'        xComp.CodeModule.InsertLines lCount + 1, "mClick"
'    End If
'End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub
