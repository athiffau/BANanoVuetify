﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public Card As VMElement
	Public ID As String
	Private vue As BANanoVue
	Private BANano As BANano  'ignore
	Private DesignMode As Boolean
	Private Module As Object
	Public Title As VMCardTitle
	Public SubTitle As VMCardSubTitle
	Public Text As VMCardText
	Public Actions As VMCardActions
	Public IsDialog As Boolean
	Public Image As VMImage
	Public ToolBar As VMToolBar
	Public Form As VMForm
	Public TextAfter As List
	Private extra As List
	Public IsTable As Boolean
	Private bStatic As Boolean
	Private titleKey As String
	Private subTitleKey As String
	Public Container As VMContainer
	Public TopSheet As VMSheet
End Sub

'initialize the Card
Public Sub Initialize(v As BANanoVue, sid As String, eventHandler As Object) As VMCard
	ID = sid.tolowercase
	Card.Initialize(v, ID)
	Card.SetTag("v-card")
	DesignMode = False
	Module = eventHandler
	vue = v
	'
	IsDialog = False
	Title.Initialize(vue, $"${ID}title"$, Module)
	SubTitle.Initialize(vue, $"${ID}subtitle"$, Module) 
	Text.Initialize(vue, $"${ID}text"$, Module)
	Actions.Initialize(vue, $"${ID}actions"$, Module)
	Form.Initialize(vue, $"${ID}form"$, Module)
	ToolBar.Initialize(vue, $"${ID}bar"$, Module).SetToolBar(True)
	Image.Initialize(vue, $"${ID}img"$, Module)
	TopSheet.Initialize(vue, $"${ID}ps"$, Module).SetTopOverlap 
	Container = Form.Container
	TextAfter.Initialize
	extra.Initialize 
	IsTable = False
	bStatic = False
	titleKey = $"${ID}title"$
	subTitleKey = $"${ID}subtitle"$
	SetOnClick($"${ID}_click"$)
	Return Me
End Sub

'add an element to the page content
Sub AddElement(elm As VMElement)
	Card.SetText(elm.ToString)
End Sub


Sub Validate
	Form.validate
End Sub

Sub Reset
	Form.Reset
End Sub

Sub ResetValidation
	Form.ResetValidation
End Sub

'set the title of the dialog
Sub SetTitle(sTitle As String) As VMCard
	Title.Clear
	If bStatic Then
		Title.SetText(sTitle)
		Return Me
	End If
	vue.SetStateSingle(titleKey, sTitle)
	Title.SetText($"{{ ${titleKey} }}"$)
	Return Me
End Sub

Sub SetSubTitle(sSubTitle As String) As VMCard
	If bStatic Then
		SubTitle.Clear
		SubTitle.SetText(sSubTitle)
		Return Me
	End If
	vue.SetStateSingle(subTitleKey, sSubTitle)
	SubTitle.SetText($"{{ ${subTitleKey} }}"$)
	Return Me
End Sub

'update the title of the dialog
Sub UpdateTitle(sTitle As String) As VMCard
	vue.SetStateSingle(titleKey, sTitle)
	Return Me
End Sub

'update the title of the dialog
Sub UpdateSubTitle(sSubTitle As String) As VMCard
	vue.SetStateSingle(subTitleKey, sSubTitle)
	Return Me
End Sub

Sub SetStatic(b As Boolean) As VMCard
	bStatic = b
	Card.SetStatic(b)
	Title.setstatic(b)
	SubTitle.setstatic(b)
	Text.setstatic(b)
	Actions.SetStatic(b)
	ToolBar.SetStatic(b)
	Form.SetStatic(b)
	Container.SetStatic(b)
	Image.SetStatic(b)
	TopSheet.SetStatic(b)
	Return Me
End Sub

'set the row and column position
Sub SetRC(sRow As String, sCol As String) As VMCard
	Card.SetRC(sRow, sCol)
	Return Me
End Sub

'set the offsets for this item
Sub SetDeviceOffsets(OS As String, OM As String,OL As String,OX As String) As VMCard
	Card.SetDeviceOffsets(OS, OM, OL, OX)
	Return Me
End Sub

'set the sizes for this item
Sub SetDeviceSizes(SS As String, SM As String, SL As String, SX As String) As VMCard
	Card.SetDeviceSizes(SS , SM , SL , SX )
	Return Me
End Sub

'set the position: row and column and sizes
Sub SetDevicePositions(srow As String, scell As String, small As String, medium As String, large As String, xlarge As String) As VMCard
	SetRC(srow, scell)
	SetDeviceSizes(small, medium , large , xlarge) 
	Return Me
End Sub

Sub SetAttrLoose(loose As String) As VMCard
	Card.SetAttrLoose(loose)
	Return Me
End Sub

Sub SetAttributes(attrs As List) As VMCard
	For Each stra As String In attrs
		SetAttrLoose(stra)
	Next
	Return Me
End Sub

'apply a theme to an element
Sub UseTheme(themeName As String) As VMCard
	themeName = themeName.ToLowerCase
	Dim themes As Map = vue.themes
	If themes.ContainsKey(themeName) Then
		Dim sclass As String = themes.Get(themeName)
		AddClass(sclass)
	End If
	Return Me
End Sub

'add stuff after the actions
Sub AddExtraContent(scontent As String) As VMCard
	extra.Add(scontent)
	Return Me
End Sub

Sub AddElement1(elID As String, elTag As String, elText As String, mprops As Map, mstyles As Map, lclasses As List) As VMCard
	Dim d As VMElement
	d.Initialize(vue,elID).SetDesignMode(DesignMode).SetTag(elTag)
	d.SetText(elText)
	d.BuildModel(mprops, mstyles, lclasses, Null)
	AddStuff(d.ToString)
	Return Me
End Sub

Sub AddCardText(ct As VMCardText) As VMCard
	AddStuff(ct.ToString)
	Return Me
End Sub

'add a component to the root of the card
Sub AddComponent(comp As String) As VMCard
	Card.SetText(comp)
	Return Me
End Sub

'add stuff to the root of the card
Sub AddStuff(stuff As String) As VMCard
	TextAfter.Add(stuff)
	Return Me	
End Sub

Sub SetTextAfter(stuff As String) As VMCard
	TextAfter.Add(stuff)
	Return Me	
End Sub

Sub AddTextAfter(stuff As String) As VMCard
	TextAfter.Add(stuff)
	Return Me	
End Sub

Sub SetData(prop As String, value As Object) As VMCard
	vue.SetData(prop, value)
	Return Me
End Sub


Sub AddDivider As VMCard
	IsDialog = True
	Return Me
End Sub

Sub AddTextAfterDivider(className As String) As VMCard
	Dim div As VMDivider
	div.Initialize(vue).AddClass(className)
	SetTextAfter(div.ToString)
	Return Me
End Sub

Sub SetTextAfterDivider(className As String) As VMCard
	Dim div As VMDivider
	div.Initialize(vue).AddClass(className)
	SetTextAfter(div.ToString)
	Return Me
End Sub


Sub ToString As String
	If vue.ShowWarnings Then
		Dim eName As String = $"${ID}_click"$
		If SubExists(Module, eName) = False Then
			Log($"VMCard.${eName} event has not been defined!"$)
		End If
	End If
	If TopSheet.hascontent Then TopSheet.Pop(Card)
	If ToolBar.hasContent Then ToolBar.Pop(Card)
	If Image.HasContent Then Image.Pop(Card)
	If Title.HasContent Then Title.Pop(Card)
	If SubTitle.HasContent Then SubTitle.Pop(Card)
	If IsTable = False Then 
		If Form.hascontent Then Text.AddContent(Form.ToString)
		If Text.HasContent Then Text.Pop(Card)
	End If
	For Each strItem As String In TextAfter
		Card.SetText(strItem)
	Next
	If IsDialog Then Card.AddDivider
	If IsTable = False Then 
		If Actions.HasContent Then Actions.Pop(Card)
		For Each strItem As String In extra
			Card.SetText(strItem)
		Next	
	End If
	Return Card.tostring
End Sub


Sub SetOK(okID As String, okCaption As String) As VMCard
	AddOK(okID, okCaption)
	Return Me
End Sub


Sub SetTitlePrimary(b As Boolean) As VMCard
	If b = False Then Return Me
	Title.SetAttrSingle("primary-title", True)
	Return Me
End Sub

private Sub AddOK(okID As String, okCaption As String) As VMCard
	Dim btnOK As VMButton
	btnOK.Initialize(vue, okID, Module)
	btnOK.SetStatic(bStatic)
	btnOK.SetDesignMode(DesignMode)
	btnOK.SetPrimary(True)
	btnOK.SetLabel(okCaption)
	btnOK.SetTransparent(True)
	Actions.SetText(btnOK.ToString)
	Return Me
End Sub

Sub SetCancel(cancelID As String, cancelCaption As String) As VMCard
	AddCANCEL(cancelID, cancelCaption)
	Return Me
End Sub

Sub AddButton(btn As VMButton) As VMCard
	Actions.SetText(btn.ToString)
	Return Me
End Sub


Sub AddMenu(menu As VMMenu) As VMCard
	Actions.SetText(menu.ToString)
	Return Me
End Sub


private Sub AddCANCEL(cancelID As String, cancelCaption As String) As VMCard
	Dim btnCancel As VMButton
	btnCancel.Initialize(vue, cancelID, Module).SetStatic(bStatic).SetDesignMode(DesignMode)
	btnCancel.SetLabel(cancelCaption)
	btnCancel.SetAccent(True)
	btnCancel.SetTransparent(True)
	Actions.SetText(btnCancel.ToString)
	Return Me
End Sub

Sub SetVModel(k As String) As VMCard
	Card.SetVModel(k)
	Return Me
End Sub

Sub SetVIf(vif As String) As VMCard
	Card.SetVIf(vif)
	Return Me
End Sub

Sub SetVShow(vif As String) As VMCard
	Card.SetVShow(vif)
	Return Me
End Sub

'add to app template
Sub Render
	vue.SetTemplate(ToString)
End Sub

'add a child
Sub AddChild(child As VMElement) As VMCard
	Dim childHTML As String = child.ToString
	Card.SetText(childHTML)
	Return Me
End Sub

'set text
Sub SetText(t As Object) As VMCard
	Card.SetText(t)
	Return Me
End Sub

'add to parent
Sub Pop(p As VMElement)
	p.SetText(ToString)
End Sub

'add a class
Sub AddClass(c As String) As VMCard
	Card.AddClass(c)
	Return Me
End Sub

'set an attribute
Sub SetAttr(attr As Map) As VMCard
	Card.SetAttr(attr)
	Return Me
End Sub

'set style
Sub SetStyle(sm As Map) As VMCard
	Card.SetStyle(sm)
	Return Me
End Sub

'add children
Sub AddChildren(children As List)
	For Each childx As VMElement In children
		AddChild(childx)
	Next
End Sub

'set append
Sub SetAppend(varAppend As Boolean) As VMCard
	If varAppend = False Then Return Me
	If bStatic Then
		SetAttrSingle("append", varAppend)
		Return Me
	End If
	Dim pp As String = $"${ID}Append"$
	vue.SetStateSingle(pp, varAppend)
	Card.Bind(":append", pp)
	Return Me
End Sub

'set dark
Sub SetDark(varDark As Boolean) As VMCard
	If varDark = False Then Return Me
	If bStatic Then
		SetAttrSingle("dark", varDark)
		Return Me
	End If
	Dim pp As String = $"${ID}Dark"$
	vue.SetStateSingle(pp, varDark)
	Card.Bind(":dark", pp)
	Return Me
End Sub

'set disabled
Sub SetDisabled(varDisabled As Boolean) As VMCard
	Card.SetDisabled(varDisabled)
	Return Me
End Sub

'set exact
Sub SetExact(varExact As Boolean) As VMCard
	If varExact = False Then Return Me
	If bStatic Then
		SetAttrSingle("exact", varExact)
		Return Me
	End If
	Dim pp As String = $"${ID}Exact"$
	vue.SetStateSingle(pp, varExact)
	Card.Bind(":exact", pp)
	Return Me
End Sub

'set flat
Sub SetFlat(varFlat As Boolean) As VMCard
	If varFlat = False Then Return Me
	If bStatic Then
		SetAttrSingle("flat", varFlat)
		Return Me
	End If
	Dim pp As String = $"${ID}Flat"$
	vue.SetStateSingle(pp, varFlat)
	Card.Bind(":flat", pp)
	Return Me
End Sub

'set hover
Sub SetHover(varHover As Boolean) As VMCard
	If varHover = False Then Return Me
	If bStatic Then
		SetAttrSingle("hover", varHover)
		Return Me
	End If
	Dim pp As String = $"${ID}Hover"$
	vue.SetStateSingle(pp, varHover)
	Card.Bind(":hover", pp)
	Return Me
End Sub

'set light
Sub SetLight(varLight As Boolean) As VMCard
	If varLight = False Then Return Me
	If bStatic Then
		SetAttrSingle("light", varLight)
		Return Me
	End If
	Dim pp As String = $"${ID}Light"$
	vue.SetStateSingle(pp, varLight)
	Card.Bind(":light", pp)
	Return Me
End Sub

'set link
Sub SetLink(varLink As Boolean) As VMCard
	If varLink = False Then Return Me
	If bStatic Then
		SetAttrSingle("link", varLink)
		Return Me
	End If
	Dim pp As String = $"${ID}Link"$
	vue.SetStateSingle(pp, varLink)
	Card.Bind(":link", pp)
	Return Me
End Sub

'set loading
Sub SetLoading(varLoading As Boolean) As VMCard
	If varLoading = False Then Return Me
	If bStatic Then
		SetAttrSingle("loading", varLoading)
		Return Me
	End If
	Dim pp As String = $"${ID}Loading"$
	vue.SetStateSingle(pp, varLoading)
	Card.Bind(":loading", pp)
	Return Me
End Sub

'set nuxt
Sub SetNuxt(varNuxt As Boolean) As VMCard
	If varNuxt = False Then Return Me
	If bStatic Then
		SetAttrSingle("nuxt", varNuxt)
		Return Me
	End If
	Dim pp As String = $"${ID}Nuxt"$
	vue.SetStateSingle(pp, varNuxt)
	Card.Bind(":nuxt", pp)
	Return Me
End Sub

'set outlined
Sub SetOutlined(varOutlined As Boolean) As VMCard
	If varOutlined = False Then Return Me
	If bStatic Then
		SetAttrSingle("outlined", varOutlined)
		Return Me
	End If
	Dim pp As String = $"${ID}Outlined"$
	vue.SetStateSingle(pp, varOutlined)
	Card.Bind(":outlined", pp)
	Return Me
End Sub

'set raised
Sub SetRaised(varRaised As Boolean) As VMCard
	If varRaised = False Then Return Me
	If bStatic Then
		SetAttrSingle("raised", varRaised)
		Return Me
	End If
	Dim pp As String = $"${ID}Raised"$
	vue.SetStateSingle(pp, varRaised)
	Card.Bind(":raised", pp)
	Return Me
End Sub

'set replace
Sub SetReplace(varReplace As Boolean) As VMCard
	If varReplace = False Then Return Me
	If bStatic Then
		SetAttrSingle("replace", varReplace)
		Return Me
	End If
	Dim pp As String = $"${ID}Replace"$
	vue.SetStateSingle(pp, varReplace)
	Card.Bind(":replace", pp)
	Return Me
End Sub

'set ripple
Sub SetRipple(varRipple As Boolean) As VMCard
	If varRipple = False Then Return Me
	If bStatic Then
		SetAttrSingle("ripple", varRipple)
		Return Me
	End If
	Dim pp As String = $"${ID}Ripple"$
	vue.SetStateSingle(pp, varRipple)
	Card.Bind(":ripple", pp)
	Return Me
End Sub

'set shaped
Sub SetShaped(varShaped As Boolean) As VMCard
	If varShaped = False Then Return Me
	If bStatic Then
		SetAttrSingle("shaped", varShaped)
		Return Me
	End If
	Dim pp As String = $"${ID}Shaped"$
	vue.SetStateSingle(pp, varShaped)
	Card.Bind(":shaped", pp)
	Return Me
End Sub

'set tile
Sub SetTile(varTile As Boolean) As VMCard
	If varTile = False Then Return Me
	If bStatic Then
		SetAttrSingle("tile", varTile)
		Return Me
	End If
	Dim pp As String = $"${ID}Tile"$
	vue.SetStateSingle(pp, varTile)
	Card.Bind(":tile", pp)
	Return Me
End Sub

'set active-class
Sub SetActiveClass(varActiveClass As String) As VMCard
	If varActiveClass = "" Then Return Me
	If bStatic Then
		SetAttrSingle("active-class", varActiveClass)
		Return Me
	End If
	Dim pp As String = $"${ID}ActiveClass"$
	vue.SetStateSingle(pp, varActiveClass)
	Card.Bind(":active-class", pp)
	Return Me
End Sub

'set color
Sub SetColor(varColor As String) As VMCard
	If varColor = "" Then Return Me
	If bStatic Then
		SetAttrSingle("color", varColor)
		Return Me
	End If
	Dim pp As String = $"${ID}Color"$
	vue.SetStateSingle(pp, varColor)
	Card.Bind(":color", pp)
	Return Me
End Sub

'set elevation
Sub SetElevation(varElevation As String) As VMCard
	If varElevation = "" Then Return Me
	AddClass($"elevation-${varElevation}"$)
	Return Me
End Sub

'set exact-active-class
Sub SetExactActiveClass(varExactActiveClass As String) As VMCard
	If varExactActiveClass = "" Then Return Me
	If bStatic Then
		SetAttrSingle("exact-active-class", varExactActiveClass)
		Return Me
	End If
	Dim pp As String = $"${ID}ExactActiveClass"$
	vue.SetStateSingle(pp, varExactActiveClass)
	Card.Bind(":exact-active-class", pp)
	Return Me
End Sub

'set height
Sub SetHeight(varHeight As String) As VMCard
	If varHeight = "" Then Return Me
	If bStatic Then
		SetAttrSingle("height", varHeight)
		Return Me
	End If
	Dim pp As String = $"${ID}Height"$
	vue.SetStateSingle(pp, varHeight)
	Card.Bind(":height", pp)
	Return Me
End Sub

'set href
Sub SetHref(varHref As String) As VMCard
	If varHref = "" Then Return Me
	If bStatic Then
		SetAttrSingle("href", varHref)
		Return Me
	End If
	Dim pp As String = $"${ID}Href"$
	vue.SetStateSingle(pp, varHref)
	Card.Bind(":href", pp)
	Return Me
End Sub

'set img
Sub SetImg(varImg As String) As VMCard
	If varImg = "" Then Return Me
	If bStatic Then
		SetAttrSingle("img", varImg)
		Return Me
	End If
	Dim pp As String = $"${ID}Img"$
	vue.SetStateSingle(pp, varImg)
	Card.Bind(":img", pp)
	Return Me
End Sub

'set loader-height
Sub SetLoaderHeight(varLoaderHeight As String) As VMCard
	If varLoaderHeight = "" Then Return Me
	If bStatic Then
		SetAttrSingle("loader-height", varLoaderHeight)
		Return Me
	End If
	Dim pp As String = $"${ID}LoaderHeight"$
	vue.SetStateSingle(pp, varLoaderHeight)
	Card.Bind(":loader-height", pp)
	Return Me
End Sub

'set max-height
Sub SetMaxHeight(varMaxHeight As String) As VMCard
	If varMaxHeight = "" Then Return Me
	If bStatic Then
		SetAttrSingle("max-height", varMaxHeight)
		Return Me
	End If
	Dim pp As String = $"${ID}MaxHeight"$
	vue.SetStateSingle(pp, varMaxHeight)
	Card.Bind(":max-height", pp)
	Return Me
End Sub

'set max-width
Sub SetMaxWidth(varMaxWidth As String) As VMCard
	If varMaxWidth = "" Then Return Me
	If bStatic Then
		SetAttrSingle("max-width", varMaxWidth)
		Return Me
	End If
	Dim pp As String = $"${ID}MaxWidth"$
	vue.SetStateSingle(pp, varMaxWidth)
	Card.Bind(":max-width", pp)
	Return Me
End Sub

'set min-height
Sub SetMinHeight(varMinHeight As String) As VMCard
	If varMinHeight = "" Then Return Me
	If bStatic Then
		SetAttrSingle("min-height", varMinHeight)
		Return Me
	End If
	Dim pp As String = $"${ID}MinHeight"$
	vue.SetStateSingle(pp, varMinHeight)
	Card.Bind(":min-height", pp)
	Return Me
End Sub

'set min-width
Sub SetMinWidth(varMinWidth As String) As VMCard
	If varMinWidth = "" Then Return Me
	If bStatic Then
		SetAttrSingle("min-width", varMinWidth)
		Return Me
	End If
	Dim pp As String = $"${ID}MinWidth"$
	vue.SetStateSingle(pp, varMinWidth)
	Card.Bind(":min-width", pp)
	Return Me
End Sub

'set tag
Sub SetTag(varTag As String) As VMCard
	If varTag = "" Then Return Me
	If bStatic Then
		SetAttrSingle("tag", varTag)
		Return Me
	End If
	Dim pp As String = $"${ID}Tag"$
	vue.SetStateSingle(pp, varTag)
	Card.Bind(":tag", pp)
	Return Me
End Sub

'set target
Sub SetTarget(varTarget As String) As VMCard
	If varTarget = "" Then Return Me
	If bStatic Then
		SetAttrSingle("target", varTarget)
		Return Me
	End If
	Dim pp As String = $"${ID}Target"$
	vue.SetStateSingle(pp, varTarget)
	Card.Bind(":target", pp)
	Return Me
End Sub

'set to
Sub SetTo(varTo As String) As VMCard
	If varTo = "" Then Return Me
	If bStatic Then
		SetAttrSingle("to", varTo)
		Return Me
	End If
	Dim pp As String = $"${ID}To"$
	vue.SetStateSingle(pp, varTo)
	Card.Bind(":to", pp)
	Return Me
End Sub

'set width
Sub SetWidth(varWidth As String) As VMCard
	If varWidth = "" Then Return Me
	If bStatic Then
		SetAttrSingle("width", varWidth)
		Return Me
	End If
	Dim pp As String = $"${ID}Width"$
	vue.SetStateSingle(pp, varWidth)
	Card.Bind(":width", pp)
	Return Me
End Sub
'
Sub SetSlotProgress(b As Boolean) As VMCard    'ignore
	SetAttr(CreateMap("slot": "progress"))
	Return Me
End Sub

'selValue
Sub SetOnClick(methodName As String) As VMCard
	methodName = methodName.tolowercase
	If SubExists(Module, methodName) = False Then Return Me
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(Module, methodName, Array(e))
	SetAttr(CreateMap("@click": methodName))
	'add to methods
	vue.SetCallBack(methodName, cb)
	Return Me
End Sub


Sub Hide As VMCard
	SetVShow($"${ID}show"$)
	Card.SetVisible(False)
	Return Me
End Sub

Sub Show As VMCard
	SetVShow($"${ID}show"$)
	Card.SetVisible(True)
	Return Me
End Sub

Sub Enable As VMCard
	Card.Enable(True)
	Return Me
End Sub

Sub Disable As VMCard
	Card.Disable(True)
	Return Me
End Sub


'bind a property to state
Sub Bind(prop As String, stateprop As String) As VMCard
	stateprop = stateprop.ToLowerCase
	SetAttrSingle(prop, stateprop)
	Return Me
End Sub


public Sub RemoveAttr(sName As String) As VMCard
	Card.RemoveAttr(sName)
	Return Me
End Sub

'set padding
Sub SetPaddingAll(p As String) As VMCard
	Card.SetPaddingAll(p)
	Return Me
End Sub

Sub SetMarginAll(p As String) As VMCard
	Card.setmarginall(p)
	Return Me
End Sub

Sub SetDesignMode(b As Boolean) As VMCard
	Card.SetDesignMode(b)
	Title.SetDesignMode(b)
	Text.SetDesignMode(b)
	Actions.SetDesignMode(b)
	Form.SetDesignMode(b)
	ToolBar.SetDesignMode(b)
	Container.SetDesignMode(b)
	SubTitle.SetDesignMode(b)
	Image.SetDesignMode(b)
	DesignMode = b
	Return Me
End Sub

Sub SetTabIndex(ti As String) As VMCard
	Card.SetTabIndex(ti)
	Return Me
End Sub

'The Select name. Similar To HTML5 name attribute.
Sub SetName(varName As Object, bbind As Boolean) As VMCard
	Card.SetName(varName, bbind)
	Return Me
End Sub


Sub SetStyleSingle(prop As String, value As String) As VMCard
	Card.SetStyleSingle(prop, value)
	Return Me
End Sub

Sub SetAttrSingle(prop As String, value As String) As VMCard
	Card.SetAttrSingle(prop, value)
	Return Me
End Sub

Sub AddToContainer(pCont As VMContainer, rowPos As Int, colPos As Int)
	pCont.AddComponent(rowPos, colPos, ToString)
End Sub

Sub BuildModel(mprops As Map, mstyles As Map, lclasses As List, loose As List) As VMCard
Card.BuildModel(mprops, mstyles, lclasses, loose)
Return Me
End Sub

Sub SetVisible(b As Boolean) As VMCard
Card.SetVisible(b)
Return Me
End Sub

'set color intensity
Sub SetColorIntensity(color As String, intensity As String) As VMCard
	If color = "" Then Return Me
	Dim scolor As String = $"${color} ${intensity}"$
	If bStatic Then
		SetAttrSingle("color", scolor)
		Return Me
	End If
	Dim pp As String = $"${ID}Color"$
	vue.SetStateSingle(pp, scolor)
	Card.Bind(":color", pp)
	Return Me
End Sub

'set color intensity - built in
Sub SetTextColor(textcolor As String) As VMCard
	If textcolor = "" Then Return Me
	Dim sColor As String = $"${textcolor}--text"$
	AddClass(sColor)
	Return Me
End Sub

'set color intensity - built in
Sub SetTextColorIntensity(textcolor As String, textintensity As String) As VMCard
	If textcolor = "" Then Return Me
	Dim sColor As String = $"${textcolor}--text"$
	Dim sIntensity As String = $"text--${textintensity}"$
	Dim mcolor As String = $"${sColor} ${sIntensity}"$
	AddClass(mcolor)
	Return Me
End Sub
