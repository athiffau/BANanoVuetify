﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
Public SlideYTransition As VMElement
Public ID As String
Private vue As BANanoVue
Private BANano As BANano  'ignore
Private DesignMode As Boolean
Private Module As Object
End Sub

'initialize the SlideYTransition
Public Sub Initialize(v As BANanoVue, sid As String, eventHandler As Object) As VMSlideYTransition
ID = sid.tolowercase
	SlideYTransition.Initialize(v, ID)
	SlideYTransition.SetTag("v-slide-y-transition")
	DesignMode = False
	Module = eventHandler
	vue = v
	Return Me
End Sub

'get component
Sub ToString As String
Return SlideYTransition.ToString
End Sub

Sub SetVModel(k As String) As VMSlideYTransition
SlideYTransition.SetVModel(k)
Return Me
End Sub

Sub SetVIf(vif As Object) As VMSlideYTransition
SlideYTransition.SetVIf(vif)
Return Me
End Sub

Sub SetVShow(vif As Object) As VMSlideYTransition
SlideYTransition.SetVShow(vif)
Return Me
End Sub

'add to app template
Sub Render
vue.SetTemplate(ToString)
End Sub

'add a child
Sub AddChild(child As VMElement) As VMSlideYTransition
Dim childHTML As String = child.ToString
SlideYTransition.SetText(childHTML)
Return Me
End Sub

'set text
Sub SetText(t As Object) As VMSlideYTransition
SlideYTransition.SetText(t)
Return Me
End Sub

'add to parent
Sub Pop(p As VMElement)
p.SetText(ToString)
End Sub

'add a class
Sub AddClass(c As String) As VMSlideYTransition
SlideYTransition.AddClass(c)
Return Me
End Sub

'set an attribute
Sub SetAttr(attr as map) As VMSlideYTransition
SlideYTransition.SetAttr(attr)
Return Me
End Sub

'set style
Sub SetStyle(sm As Map) As VMSlideYTransition
SlideYTransition.SetStyle(sm)
Return Me
End Sub

'add children
Sub AddChildren(children As List)
For Each childx As VMElement In children
AddChild(childx)
Next
End Sub

'set group
Sub SetGroup(varGroup As Object) As VMSlideYTransition
Dim pp As String = $"${ID}Group"$
vue.SetStateSingle(pp, varGroup)
SlideYTransition.Bind(":group", pp)
Return Me
End Sub

'set hide-on-leave
Sub SetHideOnLeave(varHideOnLeave As Object) As VMSlideYTransition
Dim pp As String = $"${ID}HideOnLeave"$
vue.SetStateSingle(pp, varHideOnLeave)
SlideYTransition.Bind(":hide-on-leave", pp)
Return Me
End Sub

'set leave-absolute
Sub SetLeaveAbsolute(varLeaveAbsolute As Object) As VMSlideYTransition
Dim pp As String = $"${ID}LeaveAbsolute"$
vue.SetStateSingle(pp, varLeaveAbsolute)
SlideYTransition.Bind(":leave-absolute", pp)
Return Me
End Sub

'set mode
Sub SetMode(varMode As Object) As VMSlideYTransition
Dim pp As String = $"${ID}Mode"$
vue.SetStateSingle(pp, varMode)
SlideYTransition.Bind(":mode", pp)
Return Me
End Sub

'set origin
Sub SetOrigin(varOrigin As Object) As VMSlideYTransition
Dim pp As String = $"${ID}Origin"$
vue.SetStateSingle(pp, varOrigin)
SlideYTransition.Bind(":origin", pp)
Return Me
End Sub


'hide the component
Sub Hide As VMSlideYTransition
	SlideYTransition.SetVisible(False)
    Return Me
End Sub

'show the component
Sub Show As VMSlideYTransition
	SlideYTransition.SetVisible(True)
    Return Me
End Sub

'enable the component
Sub Enable As VMSlideYTransition
	SlideYTransition.Enable(True)
    Return Me
End Sub

'disable the component
Sub Disable As VMSlideYTransition
	SlideYTransition.Disable(true)
    Return Me
End Sub


'bind a property to state
Sub Bind(prop As String, stateprop As String) As VMSlideYTransition
	stateprop = stateprop.ToLowerCase
	SetAttrSingle(prop, stateprop)
	Return Me
End Sub

'add a loose attribute without value
Sub SetAttrLoose(loose As String) As VMSlideYTransition
	SlideYTransition.SetAttrLoose(loose)
	Return Me
End Sub

'apply a theme to an element
Sub UseTheme(themeName As String) As VMSlideYTransition
	themeName = themeName.ToLowerCase
	Dim themes As Map = vue.themes
	If themes.ContainsKey(themeName) Then
		Dim sclass As String = themes.Get(themeName)
		AddClass(sclass)
	End If
	Return Me
End Sub


'set color intensity
Sub SetColorIntensity(varColor As String, varIntensity As String) As VMSlideYTransition
	Dim pp As String = $"${ID}Color"$
	Dim scolor As String = $"${varColor} ${varIntensity}"$
	vue.SetStateSingle(pp, scolor)
	SlideYTransition.Bind(":color", pp)
	Return Me
End Sub

'remove an attribute
public Sub RemoveAttr(sName As String) As VMSlideYTransition
	SlideYTransition.RemoveAttr(sName)
	Return Me
End Sub

'set padding
Sub SetPaddingAll(p As String) As VMSlideYTransition
	SlideYTransition.SetPaddingAll(p)
	Return Me
End Sub

'set all margins
Sub SetMarginAll(p As String) As VMSlideYTransition
	SlideYTransition.setmarginall(p)
	Return Me
End Sub

'set design mode
Sub SetDesignMode(b As Boolean) As VMSlideYTransition
	SlideYTransition.SetDesignMode(b)
	DesignMode = b
	Return Me
End Sub

'set tab index
Sub SetTabIndex(ti As String) As VMSlideYTransition
	SlideYTransition.SetTabIndex(ti)
	Return Me
End Sub

'The Select name. Similar To HTML5 name attribute.
Sub SetName(varName As Object, bbind As Boolean) As VMSlideYTransition
	SlideYTransition.SetName(varName, bbind)
	Return Me
End Sub

'set single style
Sub SetStyleSingle(prop As String, value As String) As VMSlideYTransition
	SlideYTransition.SetStyleSingle(prop, value)
	Return Me
End Sub

'set single attribute
Sub SetAttrSingle(prop As String, value As String) As VMSlideYTransition
	SlideYTransition.SetAttrSingle(prop, value)
	Return Me
End Sub

'set single style
Sub BindStyleSingle(prop As String, value As String) As VMSlideYTransition
	SlideYTransition.BindStyleSingle(prop, value)
	Return Me
End Sub

Sub SetVElse(vif As String) As VMSlideYTransition
	SlideYTransition.SetVElse(vif)
	Return Me
End Sub

Sub SetVText(vhtml As String) As VMSlideYTransition
	SlideYTransition.SetVText(vhtml)
	Return Me
End Sub

Sub SetVhtml(vhtml As String) As VMSlideYTransition
	SlideYTransition.SetVHtml(vhtml)
	Return Me
End Sub

Sub SetAttributes(attrs As List) As VMSlideYTransition
	For Each stra As String In attrs
		SetAttrLoose(stra)
	Next
	Return Me
End Sub

'set for
Sub SetVFor(item As String, dataSource As String) As VMSlideYTransition
	dataSource = dataSource.tolowercase
	item = item.tolowercase
	Dim sline As String = $"${item} in ${dataSource}"$
	SetAttrSingle("v-for", sline)
	Return Me
End Sub

Sub SetKey(k As String) As VMSlideYTransition
	k = k.tolowercase
	SetAttrSingle(":key", k)
	Return Me
End Sub

'set the row and column position
Sub SetRC(sRow As String, sCol As String) As VMSlideYTransition
	SlideYTransition.SetRC(sRow, sCol)
	Return Me
End Sub

'set the offsets for this item
Sub SetDeviceOffsets(OS As String, OM As String,OL As String,OX As String) As VMSlideYTransition
	SlideYTransition.SetDeviceOffsets(OS, OM, OL, OX)
	Return Me
End Sub


'set the position: row and column and sizes
Sub SetDevicePositions(srow As String, scell As String, small As String, medium As String, large As String, xlarge As String) As VMSlideYTransition
	SetRC(srow, scell)
	SetDeviceSizes(small,medium, large, xlarge)
	Return Me
End Sub

'set the sizes for this item
Sub SetDeviceSizes(SS As String, SM As String, SL As String, SX As String) As VMSlideYTransition
	SlideYTransition.SetDeviceSizes(SS, SM, SL, SX)
	Return Me
End Sub


Sub AddComponent(comp As String) As VMSlideYTransition
	SlideYTransition.SetText(comp)
	Return Me
End Sub


Sub SetTextCenter As VMSlideYTransition
	SlideYTransition.AddClass("text-center")
	Return Me
End Sub

Sub AddToContainer(pCont As VMContainer, rowPos As Int, colPos As Int)
	pCont.AddComponent(rowPos, colPos, ToString)
End Sub


Sub BuildModel(mprops As Map, mstyles As Map, lclasses As List, loose As List) As VMSlideYTransition
SlideYTransition.BuildModel(mprops, mstyles, lclasses, loose)
Return Me
End Sub


Sub SetVisible(b As Boolean) As VMSlideYTransition
SlideYTransition.SetVisible(b)
Return Me
End Sub


'set color intensity
Sub SetTextColor(varColor As String) As VMSlideYTransition
	Dim sColor As String = $"${varColor}--text"$
	AddClass(sColor)
	Return Me
End Sub

'set color intensity
Sub SetTextColorIntensity(varColor As String, varIntensity As String) As VMSlideYTransition
	Dim sColor As String = $"${varColor}--text"$
	Dim sIntensity As String = $"text--${varIntensity}"$
	Dim mcolor As String = $"${sColor} ${sIntensity}"$
	AddClass(mcolor)
	Return Me
End Sub