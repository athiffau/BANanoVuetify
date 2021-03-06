﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public TimeLine As VMElement
	Public ID As String
	Private vue As BANanoVue
	Private BANano As BANano  'ignore
	Private DesignMode As Boolean  'ignore
	Private Module As Object   'ignore
	Private bStatic As Boolean
End Sub

'initialize the TimeLine
Public Sub Initialize(v As BANanoVue, sid As String, eventHandler As Object) As VMTimeline
	ID = sid.tolowercase
	TimeLine.Initialize(v, ID)
	TimeLine.SetTag("v-timeline")
	vue = v
	DesignMode = False
	Module = eventHandler
	bStatic = False
	Return Me
End Sub



'add an element to the page content
Sub AddElement(elm As VMElement)
	TimeLine.SetText(elm.ToString)
End Sub

Sub AddTimeLineItem(tlItem As VMTimelineItem)
	AddComponent(tlItem.tostring)
End Sub

Sub SetData(xprop As String, xValue As Object) As VMTimeline
	vue.SetData(xprop, xValue)
	Return Me
End Sub



'get component
Sub ToString As String
	Return TimeLine.ToString
End Sub

Sub SetVModel(k As String) As VMTimeline
	TimeLine.SetVModel(k)
	Return Me
End Sub

Sub SetVIf(vif As String) As VMTimeline
	TimeLine.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As String) As VMTimeline
	TimeLine.SetVShow(vif)
	Return Me
End Sub

'add to app template
Sub Render
	vue.SetTemplate(ToString)
End Sub

'add a child
Sub AddChild(child As VMElement) As VMTimeline
	Dim childHTML As String = child.ToString
	TimeLine.SetText(childHTML)
	Return Me
End Sub

'set text - built-in
Sub SetText(t As String) As VMTimeline
	TimeLine.SetText(t)
	Return Me
End Sub

'add to parent
Sub Pop(p As VMElement)
	p.SetText(ToString)
End Sub

'add a class
Sub AddClass(c As String) As VMTimeline
	TimeLine.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As VMTimeline
	TimeLine.SetAttr(attr)
	Return Me
End Sub

'set style
Sub SetStyle(sm As Map) As VMTimeline
	TimeLine.SetStyle(sm)
	Return Me
End Sub

'add children
Sub AddChildren(children As List)
	For Each childx As VMElement In children
		AddChild(childx)
	Next
End Sub

'set align-top
Sub SetAlignTop(varAlignTop As Boolean) As VMTimeline
	If varAlignTop = False Then Return Me
	If bStatic Then
		SetAttrSingle("align-top", varAlignTop)
		Return Me
	End If
	Dim pp As String = $"${ID}AlignTop"$
	vue.SetStateSingle(pp, varAlignTop)
	TimeLine.Bind(":align-top", pp)
	Return Me
End Sub

'set dark
Sub SetDark(varDark As Boolean) As VMTimeline
	If varDark = False Then Return Me
	If bStatic Then
		SetAttrSingle("dark", varDark)
		Return Me
	End If
	Dim pp As String = $"${ID}Dark"$
	vue.SetStateSingle(pp, varDark)
	TimeLine.Bind(":dark", pp)
	Return Me
End Sub

'set dense
Sub SetDense(varDense As Boolean) As VMTimeline
	If varDense = False Then Return Me
	If bStatic Then
		SetAttrSingle("dense", varDense)
		Return Me
	End If
	Dim pp As String = $"${ID}Dense"$
	vue.SetStateSingle(pp, varDense)
	TimeLine.Bind(":dense", pp)
	Return Me
End Sub

'set light
Sub SetLight(varLight As Boolean) As VMTimeline
	If varLight = False Then Return Me
	If bStatic Then
		SetAttrSingle("light", varLight)
		Return Me
	End If
	Dim pp As String = $"${ID}Light"$
	vue.SetStateSingle(pp, varLight)
	TimeLine.Bind(":light", pp)
	Return Me
End Sub

'set reverse
Sub SetReverse(varReverse As Boolean) As VMTimeline
	If varReverse = False Then Return Me
	If bStatic Then
		SetAttrSingle(":reverse", varReverse)
		Return Me
	End If
	Dim pp As String = $"${ID}Reverse"$
	vue.SetStateSingle(pp, varReverse)
	TimeLine.Bind(":reverse", pp)
	Return Me
End Sub


'hide the component
Sub Hide As VMTimeline
	TimeLine.SetVisible(False)
	Return Me
End Sub

'show the component
Sub Show As VMTimeline
	TimeLine.SetVisible(True)
	Return Me
End Sub

'enable the component
Sub Enable As VMTimeline
	TimeLine.Enable(True)
	Return Me
End Sub

'disable the component
Sub Disable As VMTimeline
	TimeLine.Disable(True)
	Return Me
End Sub


'bind a property to state
Sub Bind(prop As String, stateprop As String) As VMTimeline
	stateprop = stateprop.ToLowerCase
	SetAttrSingle(prop, stateprop)
	Return Me
End Sub

'add a loose attribute without value
Sub SetAttrLoose(loose As String) As VMTimeline
	TimeLine.SetAttrLoose(loose)
	Return Me
End Sub

'apply a theme to an element
Sub UseTheme(themeName As String) As VMTimeline
	themeName = themeName.ToLowerCase
	Dim themes As Map = vue.themes
	If themes.ContainsKey(themeName) Then
		Dim sclass As String = themes.Get(themeName)
		AddClass(sclass)
	End If
	Return Me
End Sub


'remove an attribute
public Sub RemoveAttr(sName As String) As VMTimeline
	TimeLine.RemoveAttr(sName)
	Return Me
End Sub

'set padding
Sub SetPaddingAll(p As String) As VMTimeline
	TimeLine.SetPaddingAll(p)
	Return Me
End Sub

'set all margins
Sub SetMarginAll(p As String) As VMTimeline
	TimeLine.setmarginall(p)
	Return Me
End Sub

'set design mode
Sub SetDesignMode(b As Boolean) As VMTimeline
	TimeLine.SetDesignMode(b)
	DesignMode = b
	Return Me
End Sub

'set design mode
Sub SetStatic(b As Boolean) As VMTimeline
	TimeLine.SetStatic(b)
	DesignMode = b
	Return Me
End Sub

'set tab index
Sub SetTabIndex(ti As String) As VMTimeline
	TimeLine.SetTabIndex(ti)
	Return Me
End Sub

'The Select name. Similar To HTML5 name attribute.
Sub SetName(varName As String, bbind As Boolean) As VMTimeline
	TimeLine.SetName(varName, bbind)
	Return Me
End Sub

'set single style
Sub SetStyleSingle(prop As String, value As String) As VMTimeline
	TimeLine.SetStyleSingle(prop, value)
	Return Me
End Sub

'set single attribute
Sub SetAttrSingle(prop As String, value As String) As VMTimeline
	TimeLine.SetAttrSingle(prop, value)
	Return Me
End Sub

'set single style
Sub BindStyleSingle(prop As String, value As String) As VMTimeline
	TimeLine.BindStyleSingle(prop, value)
	Return Me
End Sub

Sub SetVElse(vif As String) As VMTimeline
	TimeLine.SetVElse(vif)
	Return Me
End Sub

Sub SetVText(vhtml As String) As VMTimeline
	TimeLine.SetVText(vhtml)
	Return Me
End Sub

Sub SetVhtml(vhtml As String) As VMTimeline
	TimeLine.SetVHtml(vhtml)
	Return Me
End Sub

Sub SetAttributes(attrs As List) As VMTimeline
	For Each stra As String In attrs
		SetAttrLoose(stra)
	Next
	Return Me
End Sub

'set for
Sub SetVFor(item As String, dataSource As String) As VMTimeline
	dataSource = dataSource.tolowercase
	item = item.tolowercase
	Dim sline As String = $"${item} in ${dataSource}"$
	SetAttrSingle("v-for", sline)
	Return Me
End Sub

Sub SetKey(k As String) As VMTimeline
	k = k.tolowercase
	SetAttrSingle(":key", k)
	Return Me
End Sub

'set the row and column position
Sub SetRC(sRow As String, sCol As String) As VMTimeline
	TimeLine.SetRC(sRow, sCol)
	Return Me
End Sub

'set the offsets for this item
Sub SetDeviceOffsets(OS As String, OM As String,OL As String,OX As String) As VMTimeline
	TimeLine.SetDeviceOffsets(OS, OM, OL, OX)
	Return Me
End Sub


'set the position: row and column and sizes
Sub SetDevicePositions(srow As String, scell As String, small As String, medium As String, large As String, xlarge As String) As VMTimeline
	SetRC(srow, scell)
	SetDeviceSizes(small,medium, large, xlarge)
	Return Me
End Sub

'set the sizes for this item
Sub SetDeviceSizes(SS As String, SM As String, SL As String, SX As String) As VMTimeline
	TimeLine.SetDeviceSizes(SS, SM, SL, SX)
	Return Me
End Sub


Sub AddComponent(comp As String) As VMTimeline
	TimeLine.SetText(comp)
	Return Me
End Sub


Sub SetTextCenter As VMTimeline
	TimeLine.AddClass("text-center")
	Return Me
End Sub

Sub AddToContainer(pCont As VMContainer, rowPos As Int, colPos As Int)
	pCont.AddComponent(rowPos, colPos, ToString)
End Sub


Sub BuildModel(mprops As Map, mstyles As Map, lclasses As List, loose As List) As VMTimeline
	TimeLine.BuildModel(mprops, mstyles, lclasses, loose)
	Return Me
End Sub


Sub SetVisible(b As Boolean) As VMTimeline
	TimeLine.SetVisible(b)
	Return Me
End Sub

