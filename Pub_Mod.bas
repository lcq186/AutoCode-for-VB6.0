Attribute VB_Name = "Pub_Mod"
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

Public VBInstance As VBIDE.VBE 'IDE�ӿ�
Public Connect As Connect '���ӽӿ�
Public SetFonz As VBIDE.Properties
Public SetFonzs As VBIDE.Property

Public iButton     As Office.CommandBarButton

'---------------------------------------------------------------------------------
Public hWndCodeWindow As Long '���봰�ھ��
Public PrevProcPtr As Long
Public OldParent As Long '�Զ������б� �ɵĸ����
Public AtCodeParent As New Parent_Cls
'---------------------------------------------------------------------------------

Public PubHs() As String 'VB���еĺ���
Public PubYj() As String 'VB���йؼ��ֺ����
Public Tkey As String '��������Щ�ַ�ʱ��ȡ���Զ������б�
Public Okey As String '��������Щ�ַ�ʱ����¼���벢���ж�������룺ɾ�� �ո� �»���
Public SPkey As String '�����ÿո�����Ĺؼ���
'---------------------------------------------------------------------------------
Public ListType As Integer '�Զ�����˳�����ͣ�1=�Ⱥ��������  2=��������

Public SetFont As String '���봰�ڵ�����
Public SetFontSize As Integer '���봰�ڵ��ֺ�
Public FontHeight As Integer '���봰������߶�

Public FKinput As Boolean '�ж��Ƿ������Զ�����

Public TS As String

