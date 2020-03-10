﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Public JQuery As BANanoObject
	Private BANano As BANano
	Public vue As BANanoVue
	Private Pages As List
	Public VApp As VMElement
	Public VContent As VMElement
	Public Container As VMContainer
	Public BOVuetify As BANanoObject
	Public Drawer As VMNavigationDrawer
	Public NavBar As VMAppBar
	Public Footer As VMElement
	Private module As Object
	Public Elevation As Map
	Private HasKnob As Boolean
	Private HasInfoBox As Boolean
	Private Chartkick As BANanoObject
	Private Chart As BANanoObject
	Private VueGoogleMaps As BANanoObject
	Private IntensityOptions As Map
	Private ColorOptions As Map
	Private BorderOptions As Map
	Public Overlay As VMOverlay
	Public data As Map
	Public vuetify As BANanoObject
	Public Confirm As VMDialog
	Public Alert As VMDialog
	
	'Public zircleBO As BANanoObject
	'Public zircle As BANanoObject
	'
	Public const COLOR_AMBER As String = "amber"
	Public const COLOR_BLACK As String = "black"
	Public const COLOR_BLUE As String = "blue"
	Public const COLOR_BLUEGREY As String = "blue-grey"
	Public const COLOR_BROWN As String = "brown"
	Public const COLOR_CYAN As String = "cyan"
	Public const COLOR_DEEPORANGE As String = "deep-orange"
	Public const COLOR_DEEPPURPLE As String = "deep-purple"
	Public const COLOR_GREEN As String = "green"
	Public const COLOR_GREY As String = "grey"
	Public const COLOR_INDIGO As String = "indigo"
	Public const COLOR_LIGHTBLUE As String = "light-blue"
	Public const COLOR_LIGHTGREEN As String = "light-green"
	Public const COLOR_LIME As String = "lime"
	Public const COLOR_ORANGE As String = "orange"
	Public const COLOR_PINK As String = "pink"
	Public const COLOR_PURPLE As String = "purple"
	Public const COLOR_RED As String = "red"
	Public const COLOR_TEAL As String = "teal"
	Public const COLOR_TRANSPARENT As String = "transparent"
	Public const COLOR_WHITE As String = "white"
	Public const COLOR_YELLOW As String = "yellow"
	Public const COLOR_NONE As String = ""
	'
	Public const INTENSITY_NORMAL As String = ""
	Public const INTENSITY_LIGHTEN5 As String = "lighten-5"
	Public const INTENSITY_LIGHTEN4 As String = "lighten-4"
	Public const INTENSITY_LIGHTEN3 As String = "lighten-3"
	Public const INTENSITY_LIGHTEN2 As String = "lighten-2"
	Public const INTENSITY_LIGHTEN1 As String = "lighten-1"
	Public const INTENSITY_DARKEN1 As String = "darken-1"
	Public const INTENSITY_DARKEN2 As String = "darken-2"
	Public const INTENSITY_DARKEN3 As String = "darken-3"
	Public const INTENSITY_DARKEN4 As String = "darken-4"
	Public const INTENSITY_ACCENT1 As String = "accent-1"
	Public const INTENSITY_ACCENT2 As String = "accent-2"
	Public const INTENSITY_ACCENT3 As String = "accent-3"
	Public const INTENSITY_ACCENT4 As String = "accent-4"
	'
	Public const BORDER_DEFAULT As String = ""
	Public const BORDER_DASHED As String = "dashed"
	Public const BORDER_DOTTED As String = "dotted"
	Public const BORDER_DOUBLE As String = "double"
	Public const BORDER_GROOVE As String = "groove"
	Public const BORDER_HIDDEN As String = "hidden"
	Public const BORDER_INSET As String = "inset"
	Public const BORDER_NONE As String = "none"
	Public const BORDER_OUTSET As String = "outset"
	Public const BORDER_RIDGE As String = "ridge"
	Public const BORDER_SOLID As String = "solid"
	'
	Public const SIZE_H1 As String = "h1"
	Public const SIZE_H2 As String = "h2"
	Public const SIZE_H3 As String = "h3"
	Public const SIZE_H4 As String = "h4"
	Public const SIZE_H5 As String = "h5"
	Public const SIZE_H6 As String = "h6"
	Public const SIZE_P As String = "p"
	Public const SIZE_SPAN As String = "span"
	Public const SIZE_BLOCKQUOTE As String = "blockquote"
	'
	Public const ICON_SMALL As String = "small"
	Public const ICON_LARGE As String = "large"
	Public const ICON_XSMALL As String = "x-small"
	Public const ICON_XLARGE As String = "x-large"
	'
	Public const BUTTON_SMALL As String = "small"
	Public const BUTTON_LARGE As String = "large"
	Public const BUTTON_XSMALL As String = "x-small"
	Public const BUTTON_XLARGE As String = "x-large"
		
	Public SnackBar As VMSnackBar
	Public RTL As Boolean
	Public Dark As Boolean
	Private Options As Map
	Private lang As String
	Public Fake As VMData
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(eventHandler As Object, appName As String)
	'initialize vue
	vue.Initialize
	Fake.Initialize
	Options.Initialize 
	RTL = False
	Dark = False
	JQuery = vue.jquery
	module = eventHandler
	lang = "en"
	'load other libraries
	'VueLoading.initialize("VueLoading")
	'vue.Use(VueLoading)
	'vue.AddComponentBO("loading",VueLoading)
	
	Chartkick.initialize("Chartkick")
	Chart.Initialize("Chart")
	vue.Use(Chartkick.RunMethod("use", Chart))
	'zircleBO.Initialize("zircle")
	'vue.Use(zircleBO)
	
	
	'initialize the pages
	Pages.initialize
	HasKnob = False
	HasInfoBox = False
	'
	VApp.Initialize(vue, appName).SetTag("v-app")
	VContent.Initialize(vue, $"${appName}content"$).SetTag("v-content")
	Container.Initialize(vue, $"${appName}container"$, eventHandler)
	Drawer.Initialize(vue, "drawer", eventHandler)
	NavBar.Initialize(vue, "appbar", eventHandler)
	Footer.Initialize(vue, $"${appName}footer"$).SetTag("v-footer").SetAttrSingle("app", True).SetVModel(Footer.ID)
	'
	NavBar.Show
	'
	SnackBar = CreateSnackBar("snack", eventHandler).SetColor("").SetBottom(False).SetRight(False)
	SnackBar.Pop(VContent)
	'
	'put loader on page
	SetStateSingle("pageloader", False)
	Overlay = CreateOverlay("pageloader", module).SetValue("pageloader")
	Dim vpc As VMProgressCircular = CreateProgressCircular("", module).SetSize(200).SetIndeterminate(True).SetColor("blue")
	vpc.Pop(Overlay.Overlay)
	Overlay.Pop(VContent)
	'
	Drawer.Hide
	'
	vue.SetData("confirmtitle", "Confirm")
	vue.SetData("btnconfirmcancellabel", "Cancel")
	vue.SetData("btnconfirmoklabel", "Ok")
	vue.SetData("confirmcontent","Confirm Message")
	vue.SetData("confirmkey", "confirm")
	
	Confirm = CreateDialog("confirm", Me).SetWidth("600").SetModal(True)
	Confirm.SetTitle("Title")
	Confirm.SetContent("Confirm Message")
	Confirm.AddCancel("btnConfirmCancel", "Cancel")
	Confirm.AddOK("btnConfirmOk", "Ok")
	'
	Alert = CreateDialog("alert", Me).SetWidth("600").SetModal(True)
	Alert.SetTitle("Title")
	Alert.SetContent("Alert Message")
	Alert.AddOK("btnalertOk", "Ok")
	'
	Dim sDialog As String = Confirm.tostring
	AddContent(sDialog)
	'
	Dim sDialog As String = Alert.tostring
	AddContent(sDialog)
	
	'
	Dim e As Int
	Elevation.initialize
	For e = 0 To 24
		Elevation.Put(e, e)
	Next
	InitColors
	'
	If SubExists(module, "confirm_ok") = False Then
		Log("Initialize.confirm_ok - please add this event to trap confirm dialog!")
	End If
	'
	If SubExists(module, "confirm_cancel") = False Then
		Log("Initialize.confirm_cancel - please add this event to trap confirm dialog!")
	End If	
	'
	If SubExists(module, "alert_ok") = False Then
		Log("Initialize.alert_ok - please add this event to trap alert dialog!")
	End If

End Sub

Sub ShowConfirm(process As String, Title As String, Message As String,ConfirmText As String, CancelText As String)
	process = process.tolowercase
	vue.SetState(CreateMap("confirmtitle":Title,"confirmcontent":Message,"confirmkey":process,"btnconfirmoklabel":ConfirmText,"btnconfirmcancellabel":CancelText))
	Confirm.Show
End Sub


Sub ShowAlert(process As String, Title As String, Message As String, ConfirmText As String)
	process = process.tolowercase
	vue.SetState(CreateMap("alertkey":process, "alerttitle":Title,"alertcontent":Message,"btnalertoklabel":ConfirmText))
	Alert.Show
End Sub

Sub GetConfirm As String
	Dim sproc As String = vue.GetData("confirmkey")
	Return sproc
End Sub

Sub btnalertOk_click(e As BANanoEvent)
	Alert.hide
	Dim e As BANanoEvent
	BANano.CallSub(module, "alert_ok", Array(e))
End Sub

Sub btnConfirmCancel_click(e As BANanoEvent)
	Confirm.hide
	Dim e As BANanoEvent
	BANano.CallSub(module, "confirm_cancel", Array(e))
End Sub

Sub btnConfirmOk_click(e As BANanoEvent)
	Confirm.hide
	Dim e As BANanoEvent
	BANano.CallSub(module, "confirm_ok", Array(e))
End Sub

'convert json to a list
Sub Json2List(strValue As String) As List
	Return vue.Json2List(strValue)
End Sub

Sub CreateExpandTransition(eID As String, eventHandler As Object) As VMExpandTransition
	Dim el As VMExpandTransition
	el.Initialize(vue, eID, eventHandler)
	Return el
End Sub


Sub CreateAlert(eID As String, eventHandler As Object, typeOf As String) As VMAlert
	Dim el As VMAlert
	el.Initialize(vue, eID, eventHandler)
	If typeOf <> "" Then el.SetType(typeOf)
	Return el
End Sub


Sub CreateBanner(eID As String, eventHandler As Object) As VMBanner
	Dim el As VMBanner
	el.Initialize(vue, eID, eventHandler)
	Return el
End Sub

Sub CreateBottomNavigation(eID As String, eventHandler As Object) As VMBottomNavigation
	Dim el As VMBottomNavigation
	el.Initialize(vue, eID, eventHandler)
	Return el
End Sub


Sub CreateDataTable(cID As String, PrimaryKey As String, eventHandler As Object) As VMDataTable
	Dim el As VMDataTable
	el.Initialize(vue, cID,PrimaryKey,  eventHandler)
	Return el
End Sub


Sub CreateTreeView(cID As String, eventHandler As Object) As VMTreeView
	Dim el As VMTreeView
	el.Initialize(vue, cID, eventHandler)
	Return el
End Sub

Sub CreateCard(cID As String, eventHandler As Object) As VMCard
	Dim el As VMCard
	el.Initialize(vue, cID, eventHandler)
	Return el
End Sub

Sub CreateCardText(cID As String, eventHandler As Object) As VMCardText
	Dim el As VMCardText
	el.Initialize(vue, cID, eventHandler)
	Return el
End Sub

Sub HideSpeedDial(elID As String) As BANanoVM
	SetStateSingle(elID, False)
	Return Me
End Sub

Sub ShowSpeedDial(elID As String) As BANanoVM
	SetStateSingle(elID, True)
	Return Me
End Sub

Sub CreateProgressCircular(sid As String, eventHandler As Object) As VMProgressCircular
	Dim el As VMProgressCircular
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateProgressLinear(sid As String, eventHandler As Object) As VMProgressLinear
	Dim el As VMProgressLinear
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub ShowSnackBarError(Message As String)
	SetStateSingle("snackmessage", Message)
	SnackBar.SetColor("red")
	SnackBar.Button.Hide
	SnackBar.show
End Sub

Sub ShowSnackBarSuccess(Message As String)
	SetStateSingle("snackmessage", Message)
	SnackBar.SetColor("green")
	SnackBar.Button.Hide
	SnackBar.show
End Sub

Sub ShowSnackBar(Message As String)
	SetStateSingle("snackmessage", Message)
	SnackBar.Button.Hide
	SnackBar.show
End Sub

Sub ShowSnackBarButton(Message As String, buttonText As String, OnClick As String)
	SetStateSingle("snackmessage", Message)
	SnackBar.Button.Show
	SnackBar.SetOnClick(OnClick)
	SnackBar.Button.SetLabel(buttonText)
	SnackBar.show
End Sub


Sub Increment(elID As String, valueOf As Int) As BANanoVM
	elID = elID.tolowercase
	Dim oldv As Int = vue.GetState(elID,0)
	oldv = BANano.parseInt(oldv) + valueOf
	vue.SetStateSingle(elID, oldv)
	Return Me
End Sub

Sub Decrement(elID As String, valueOf As Int) As BANanoVM
	elID = elID.tolowercase
	Dim oldv As Int = vue.GetState(elID,0)
	oldv = BANano.parseInt(oldv) - valueOf
	vue.SetStateSingle(elID, oldv)
	Return Me
End Sub

'add a theme to use in the app
Sub AddTheme(themeName As String, ForeColor As String, ForeColorIntensity As String, BackColor As String, BackColorIntensity As String)
	vue.AddTheme(themeName, ForeColor, ForeColorIntensity, BackColor, BackColorIntensity)
End Sub

Sub MapKeys2List(m As Map) As List
	Return vue.MapKeys2List(m)
End Sub

Sub SaveText2File(sContent As String, sfileName As String)
	vue.SaveText2File(sContent, sfileName)
End Sub

Sub ProperCase(myStr As String) As String
	Return vue.ProperCase(myStr)
End Sub

Sub Capitalize(t As String) As String
	Return vue.Capitalize(t)
End Sub

Sub ShowMulti(lst As List)
	For Each item As String In lst
		Show(item)
	Next
End Sub

Sub CreateComboBox(sid As String, moduleObj As Object) As VMComboBox
	Dim el As VMComboBox
	el.Initialize(vue, sid, moduleObj)
	Return el
End Sub


Sub HideMulti(lst As List)
	For Each item As String In lst
		Hide(item)
	Next
End Sub

'create a b4j list from delimited string
Sub CreateList1(Delimiter As String, Values As String) As List
	Return vue.CreateList(Delimiter, Values)
End Sub


Sub CreateList(sid As String, eventHandler As Object) As VMList
	Dim el As VMList
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

'set booleans from checked and unchecked values
Sub SetBooleans(rec As Map, xFields As List, checkedValue As String, UnCheckedValue As String) As Map
	Return vue.SetBooleans(rec, xFields, checkedValue, UnCheckedValue)
End Sub

Sub SetUncheckedValue(rec As Map, xfields As List, checkedValue As String, UncheckedValue As String) As Map
	Return vue.SetUncheckedValue(rec, xfields, checkedValue, UncheckedValue)
End Sub

Public Sub YearNow() As String
	Return vue.YearNow
End Sub

Public Sub MonthNow() As String
	Return vue.monthnow
End Sub

Sub NewEmail(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, sIcon As String, shelpertext As String, serrorText As String, iTabIndex As Int) As VMTextField
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMTextField
	el.Initialize(vue, actName, module)
	el.TextField.ActualID = actID
	el.SetClearable(True)
	el.TextField.ActualID = actID
	el.SetErrorText(serrorText)
	el.SetLabel(slabel)
	el.SetRequired(bRequired)
	el.SetPrependIcon(sIcon)
	el.SetPlaceHolder(splaceholder)
	el.SetHint(shelpertext)
	el.SetTabIndex(iTabIndex)
	Return el
End Sub

Sub CreateGMap(sid As String, eventHandler As Object) As VMGMap
	Dim el As VMGMap
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateRangeSlider(sid As String, eventHandler As Object) As VMRangeSlider
	Dim el As VMRangeSlider
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateDevice(sid As String, eventHandler As Object) As VMDevice
	Dim el As VMDevice
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub SetGMapKey(key As String)
	VueGoogleMaps.Initialize("VueGoogleMaps")
	Dim opt As Map = CreateMap()
	Dim load As Map = CreateMap()
	load.Put("key", key)
	load.Put("libraries", "places")
	opt.Put("load", load)
	opt.Put("installComponents", True)
	vue.Use1(VueGoogleMaps, opt)
End Sub


Sub JoinLists(lst As List) As List
	Return vue.JoinLists(lst)
End Sub

'fix the records to match their data types
Sub FixRecordsUseDesign(recs As List, design As VMContainer)
	vue.FixRecords(recs, design.Strings, design.Integers, design.Booleans, design.Dates, design.Doubles)
End Sub

'copy a state from one to another
Sub State2Another(source As String, target As String, defaultValue As Object)
	vue.State2Another(source, target, defaultValue)
End Sub

Sub CreateChartKick(sid As String, eventHandler As Object) As VMChartKick
	Dim el As VMChartKick
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

'update value of progress bar
Sub SetProgressValue(pID As String, pVal As Int) As BANanoVM
	pID = pID.ToLowerCase
	SetStateSingle($"${pID}value"$, pVal)
	Return Me
End Sub

'update buffer of progress bar
Sub SetProgressBuffer(pID As String, bVal As Int) As BANanoVM
	pID = pID.ToLowerCase
	SetStateSingle($"${pID}buffer"$, bVal)
	Return Me
End Sub

'add a dialog to the page
Sub AddDialog(diag As VMDialog)
	diag.Pop(Container.Container)
End Sub

Sub AddSpeedDial(sd As VMSpeedDial)
	sd.Pop(Container.Container)
End Sub

'add a snack bar
Sub AddSnackBar(cSnackBar As VMSnackBar)
	cSnackBar.Pop(Container.Container)
End Sub

'show any dialog, alert, prompt
Sub ShowDialog(dID As String)
	dID = dID.tolowercase
	SetStateTrue(dID)
End Sub

Sub HideDialog(dID As String)
	dID = dID.tolowercase
	SetStateFalse(dID)
End Sub

Sub SetCloak(b As Boolean) As BANanoVM
	vue.SetCloak(b)
	Return Me
End Sub

Sub SetRequired(elID As String, b As Boolean)
	elID = elID.tolowercase
	vue.SetStateSingle($"${elID}required"$, b)
End Sub

Sub Enable(elID As String)
	elID = elID.tolowercase
	vue.SetStateSingle($"${elID}disabled"$, False)
End Sub

Sub Disable(elID As String)
	elID = elID.tolowercase
	vue.SetStateSingle($"${elID}disabled"$, True)
End Sub

Sub SetEnabled(elID As String, b As Boolean)
	elID = elID.tolowercase
	vue.SetStateSingle($"${elID}disabled"$, b)
End Sub

Sub Hide(elID As String)
	elID = elID.tolowercase
	vue.SetStateSingle($"${elID}show"$, False)
End Sub

Sub Show(elID As String)
	vue.SetStateSingle($"${elID}show"$, True)
End Sub

Sub ShowError(elID As String)
	vue.SetStateSingle($"${elID}error"$, True)
End Sub

Sub HideError(elID As String)
	vue.SetStateSingle($"${elID}error"$, False)
End Sub

Sub Date2YYYYMMDD(value As Object) As String
	Return vue.Date2YYYYMMDD(value)
End Sub

Sub DateAdd(mDate As String, HowManyDays As Int) As String
	Return vue.DateAdd(mDate, HowManyDays)
End Sub

Sub Age(birthDay As String) As Int
	Return vue.Age(birthDay)
End Sub

Sub DateDiff(CurrentDate As String, OtherDate As String) As Int
	Return vue.DateDiff(CurrentDate, OtherDate)
End Sub

Sub CreateFrappeGantt(sid As String, eventHandler As Object) As VMFrappeGantt
	Dim el As VMFrappeGantt
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateContainer(sid As String, eventHandler As Object) As VMContainer
	Dim el As VMContainer
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub InStr(searchit As String, searchfor As String) As Int
	Return vue.InStr(searchit, searchfor)
End Sub

Public Sub GetAlphabets(value As String) As String
	Return vue.GetAlphabets(value)
End Sub

Sub JSONSetProperty(sjson As String, updates As Map) As String
	Return vue.JSONSetProperty(sjson, updates)
End Sub

Sub EQOperators(sm As Map) As List
	Return vue.EQOperators(sm)
End Sub

'create a map subset from list of keys
Sub ExtractMap(source As Map, keys As List) As Map
	Return vue.ExtractMap(source, keys)
End Sub

'return md5 hash
Sub Md5Hash(value As String, key As String, raw As Boolean) As String
	Return vue.Md5Hash(value, key, raw)
End Sub

Sub CreatePrettyPrint(sid As String, slang As String) As VMPrettyPrint
	Dim El As VMPrettyPrint
	El.Initialize(vue, sid, slang)
	
	Return El
End Sub

'set dynamic style
Sub SetStyle(className As String, prop As String, vals As String) As BANanoVM
	vue.SetStyle(className, prop, vals)
	Return Me
End Sub

'return a pretty json from something
Sub JSONPretty(m As Object) As String
	Return vue.JSONPretty(m)
End Sub

'Sub CreatePrism(sid As String, lang As String) As VMPrism
'	Dim el As VMPrism
'	el.Initialize(Vue, sid, lang)
'	Return el
'End Sub

Sub CreateImage(img As String, eventHandler As Object) As VMImage
	Dim el As VMImage
	el.Initialize(vue, img, eventHandler)
	
	Return el
End Sub

Sub CreatePDF(sid As String, url As String) As VMPDF
	Dim el As VMPDF
	el.Initialize(vue, sid, url)
	
	Return el
End Sub

Sub CreateTimePicker(sid As String, eventHandler As Object) As VMTimePicker
	Dim el As VMTimePicker
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub


Sub MvField(sValue As String, iPosition As Int, Delimiter As String) As String
	Return vue.MvField(sValue, iPosition, Delimiter)
End Sub

'convert object to string
Sub CStr(o As Object) As String
	Return vue.CStr(o)
End Sub


'pad things to the right
Sub PadRight(Value As String, MaxLen As Int, PadChar As String) As String
	Return vue.PadRight(Value, MaxLen, PadChar)
End Sub

'length
private Sub Len(Text As String) As Int
	Return Text.Length
End Sub

Sub StrParse(Delim As String, InputString As String) As List
	Return vue.StrParse(Delim, InputString)
End Sub

private Sub InitColors
	IntensityOptions.Initialize
	IntensityOptions.put("","Normal")
	IntensityOptions.put("lighten-1","Lighten 1")
	IntensityOptions.put("lighten-2","Lighten 2")
	IntensityOptions.put("lighten-3","Lighten 3")
	IntensityOptions.put("lighten-4","Lighten 4")
	IntensityOptions.put("lighten-5","Lighten 5")
	IntensityOptions.put("darken-1","Darken 1")
	IntensityOptions.put("darken-2","Darken 2")
	IntensityOptions.put("darken-3","Darken 3")
	IntensityOptions.put("darken-4","Darken 4")
	IntensityOptions.put("accent-1","Accent 1")
	IntensityOptions.put("accent-2","Accent 2")
	IntensityOptions.put("accent-3","Accent 3")
	IntensityOptions.put("accent-4","Accent 4")
	'
	ColorOptions.Initialize
	ColorOptions.Put("amber","Amber")
	ColorOptions.Put("black","Black")
	ColorOptions.Put("blue","Blue")
	ColorOptions.Put("blue-grey","Blue Grey")
	ColorOptions.Put("brown","Brown")
	ColorOptions.Put("cyan","Cyan")
	ColorOptions.Put("deep-orange","Deep Orange")
	ColorOptions.Put("deep-purple","Deep Purple")
	ColorOptions.Put("green","Green")
	ColorOptions.Put("grey","Grey")
	ColorOptions.Put("indigo","Indigo")
	ColorOptions.Put("light-blue","Light Blue")
	ColorOptions.Put("light-green", "Light Green")
	ColorOptions.Put("lime", "Lime")
	ColorOptions.Put("orange", "Orange")
	ColorOptions.Put("pink", "Pink")
	ColorOptions.Put("purple", "Purple")
	ColorOptions.Put("red", "Red")
	ColorOptions.Put("teal", "Teal")
	ColorOptions.Put("transparent", "Transparent")
	ColorOptions.Put("white", "White")
	ColorOptions.Put("yellow", "Yellow")
	'
	BorderOptions.Initialize
	BorderOptions.Put("dashed", "Dashed")
	BorderOptions.Put("dotted", "Dotted")
	BorderOptions.Put("double", "Double")
	BorderOptions.Put("groove", "Groove")
	BorderOptions.Put("hidden", "Hidden")
	BorderOptions.Put("inset", "Inset")
	BorderOptions.Put("none", "None")
	BorderOptions.Put("outset", "Outset")
	BorderOptions.Put("ridge", "Ridge")
	BorderOptions.Put("solid", "Solid")
End Sub


Sub MergeMaps(oldm As Map, newm As Map) As Map
	Return vue.MergeMaps(oldm, newm)
End Sub

Sub CreateInfoBox(sid As String, eventHandler As Object) As VMInfoBox
	HasInfoBox = True
	Dim el As VMInfoBox
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateKnob(sid As String, eventHandler As Object) As VMKnob
	HasKnob = True
	Dim el As VMKnob
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub AddComponent(comp As VMElement)
	vue.AddComponent(comp)
End Sub

'add an element to the page content
Sub AddElement(elm As VMElement)
	elm.Pop(Container.Container)
End Sub

Sub AddHTML(htmlContent As String)
	Container.SetText(htmlContent)
End Sub

Sub CreateCustomComponent(id As String, tag As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue, id).SetTag(tag)
	
	Return el
End Sub

'create an element with a 'component' tag
Sub CreateComponent(id As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue, id).SetTag("component")
	
	Return el
End Sub

Sub AddRoute(path As String, comp As VMElement) As BANanoVM
	vue.AddRoute(path, comp)
	Return Me
End Sub

Sub UpdateBadge(elID As String, counted As String) As BANanoVM
	elID = elID.tolowercase
	Dim badValue As String = $"${elID}value"$
	vue.SetStateSingle(badValue, counted)
	Return Me
End Sub

Sub UpdateItemBadge(elID As String, counted As String) As BANanoVM
	elID = elID.tolowercase
	Dim badValue As String = $"${elID}badgevalue"$
	vue.SetStateSingle(badValue, counted)
	Return Me
End Sub

Sub IncrementBadge(elID As String, counted As Int) As BANanoVM
	elID = elID.tolowercase
	Dim badValue As String = $"${elID}badgevalue"$
	Dim lastValue As String = vue.GetState(badValue, "0")
	Dim intLast As Int = BANano.parseInt(lastValue)
	intLast = intLast + counted
	vue.SetStateSingle(badValue, intLast)
	Return Me
End Sub

Sub DecrementBadge(elID As String, counted As Int) As BANanoVM
	elID = elID.tolowercase
	Dim badValue As String = $"${elID}badgevalue"$
	Dim lastValue As String = vue.GetState(badValue, "0")
	Dim intLast As Int = BANano.parseInt(lastValue)
	intLast = intLast - counted
	vue.SetStateSingle(badValue, intLast)
	Return Me
End Sub

'hack
Sub GetChipIDFromEvent(e As BANanoEvent) As String
	Try
		Dim spath As List = e.OtherField("path").Result
		Dim sitem As Map = spath.get(5)
		Dim sid As String = sitem.get("id")
		Return sid
	Catch
		Return ""
		Log(LastException)
	End Try
End Sub

Sub CreateAvatar(sid As String, moduleObj As Object) As VMAvatar
	Dim el As VMAvatar
	el.Initialize(vue,sid, moduleObj)
	Return el
End Sub


Sub CreateBadge(sid As String, moduleObj As Object) As VMBadge
	Dim el As VMBadge
	el.Initialize(vue, sid, moduleObj)
	Return el
End Sub

'add break
Sub BR As String
	Return "<br>"
End Sub

'add hr
Sub HR As String
	Return "<hr>"
End Sub

Sub CreateRouterLink(rID As String, Text As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue,rID).SetTag("router-link").SetText(Text)
	
	Return el
End Sub

Sub CreateRouterView(rID As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue,rID).SetTag("router-view")
	
	Return el
End Sub

Sub CreateKeepAlive(sid As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue,sid).SetTag("keep-alive")
	
	Return el
End Sub

Sub CreateTag(id As String, tag As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue,id).SetTag(tag)
	
	Return el
End Sub

Sub CreateLabel(id As String) As VMLabel
	Dim el As VMLabel
	el.Initialize(vue, id)
	Return el
End Sub


'return if state exists
Sub HasState(k As String) As Boolean
	Return vue.HasState(k)
End Sub


Sub GetStates(lst As List) As Map
	Return vue.GetStates(lst)
End Sub

'set the state
Sub SetState(m As Map) As BANanoVM
	vue.SetState(m)
	Return Me
End Sub

'convert a list to key value pairs map records
Sub List2Options(lst As List, keyName As String, valueName As String) As Map
	Return vue.List2Options(lst, keyName, valueName)
End Sub

'convert a list to key value pairs map records
Sub List2Map(lst As List, keyName As String, valueName As String) As Map
	Return vue.List2Options(lst, keyName, valueName)
End Sub

'convert map to a list of maps with key and values
Sub Map2Options(m As Map, keyName As String, valueName As String) As List
	Return vue.Map2Options(m, keyName, valueName)
End Sub

'change state of items to be false
Sub HideItems(items As List)
	For Each item As String In items
		vue.SetStateSingle(item, False)
	Next
End Sub

'change state of items to be true
Sub ShowItems(items As List)
	For Each item As String In items
		vue.SetStateSingle(item, True)
	Next
End Sub

Sub SetStateSingle(k As Object, v As Object) As BANanoVM
	vue.SetStateSingle(k, v)
	Return Me
End Sub

Sub SetStateListValues(mapValues As List) As BANanoVM
	vue.SetStateListValues(mapValues)
	Return Me
End Sub

'set state list
Sub SetStateList(mapKey As String, mapValues As List) As BANanoVM
	vue.SetStateList(mapKey, mapValues)
	Return Me
End Sub

'set state object
Sub SetStateMap(mapKey As String, mapValues As Map) As BANanoVM
	vue.SetStateMap(mapKey, mapValues)
	Return Me
End Sub

'set watches 
Sub SetWatch(k As String, bImmediate As Boolean, bDeep As Boolean, moduleObj As Object, methodName As String) As BANanoVM
	vue.SetWatch(k, bImmediate, bDeep, moduleObj, methodName)
	Return Me
End Sub

Sub CreateTemplate(sid As String, eventHandler As Object) As VMTemplate
	Dim el As VMTemplate
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub SetData(prop As String, valuex As Object) As BANanoVM
	vue.SetStateSingle(prop, valuex)
	Return Me	
End Sub

Sub GetData(prop As String) As Object
	Dim obj As Object = vue.GetState(prop, Null)
	Return obj
End Sub

'set direct method
Sub SetMethod(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetMethod(moduleObj, methodName)
	Return Me
End Sub

'set created
Sub SetCreated(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetCreated(moduleObj, methodName)
	Return Me
End Sub

Sub RunMethod(methodName As String, params As Object) As BANanoObject
	Return vue.RunMethod(methodName, params)
End Sub


Sub CallMethod(methodName As String)
	vue.CallMethod(methodName)
End Sub

Sub CallComputed(methodName As String) As Object
	Return vue.CallComputed(methodName)
End Sub

Sub GetIDFromEvent(e As BANanoEvent) As String
	Return vue.GetIDFromEvent(e)
End Sub

Sub GetKeyFromEvent(e As BANanoEvent) As String
	Return vue.GetKeyFromEvent(e)
End Sub


Sub GetEventTargetProperty(e As BANanoEvent, prop As String) As String
	Return vue.GetEventTargetProperty(e, prop)
End Sub

private Sub SetFontFamily(ff As Object)
	vue.SetFontFamily(ff)
End Sub

Sub StateExists(stateName As String) As Boolean
	Return vue.StateExists(stateName)
End Sub

Sub ToggleState(stateName As String) As BANanoVM
	vue.ToggleState(stateName)
	Return Me
End Sub

Sub SetStateTrue(k As String) As BANanoVM
	vue.SetStateTrue(k)
	Return Me
End Sub

Sub AuditTrail(oldM As Map, newM As Map) As Map
	Return vue.AuditTrail(oldM, newM)
End Sub

Sub SetStateFalse(k As String) As BANanoVM
	vue.SetStateFalse(k)
	Return Me
End Sub

Sub SetStateIncrement(k As String) As BANanoVM
	vue.SetStateIncrement(k)
	Return Me
End Sub

Sub SetStateDecrement(k As String) As BANanoVM
	vue.SetStateDecrement(k)
	Return Me
End Sub

Sub GetState(k As String, default As Object) As Object
	Dim res As Object = vue.GetState(k, default)
	Return res
End Sub

'set mounted
Sub SetMounted(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetMounted(moduleObj, methodName)
	Return Me
End Sub


Sub ForceUpdate
	vue.ForceUpdate
End Sub

Sub CreateSlider(sid As String, eventHandler As Object) As VMSlider
	Dim el As VMSlider
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateTabs(sid As String, eventHandler As Object) As VMTabs
	Dim el As VMTabs
	el.Initialize(vue, sid, eventHandler)	
	Return el
End Sub

Sub CreateTab(sid As String, eventHandler As Object) As VMTab
	Dim el As VMTab
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateSwitch(sid As String, eventHandler As Object) As VMSwitch
	Dim el As VMSwitch
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateCheckBox(sid As String, eventHandler As Object) As VMCheckBox
	Dim el As VMCheckBox
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

'refresh jquery stuff, infobox and knob
Sub PageRefresh
	If HasInfoBox Then SetInfoBox
	If HasKnob Then SetKnob
End Sub

Sub CreateDynamicContent(sid As String) As VMElement
	sid = sid.tolowercase
	Dim pp As String = $"${sid}htmlcontent"$
	SetStateSingle(pp,"<div></div>")
	Dim UI As VMElement = CreateTag(sid, "renderstring")
	UI.Bind(":string", pp)
	UI.SetAttrSingle("v-bind", "$props")
	Return UI
End Sub

Sub SetDynamicContent(sid As String, dynaContent As String)
	sid = sid.ToLowerCase
	Dim pp As String = $"${sid}htmlcontent"$
	SetStateSingle(pp,dynaContent)
End Sub

Sub Use(bo As BANanoObject)
	vue.Use(bo)
End Sub

Sub CreateStepper(sid As String, eventHandler As Object) As VMStepper
	Dim el As VMStepper
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateA(sid As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue, sid).SetTag("a")
	
	Return el
End Sub

Sub GetShowState(k As String) As Boolean
	Dim showKey As String = $"${k}show"$
	Return GetState(showKey,False)
End Sub

Sub GetDisabledState(k As String) As Boolean
	Dim disKey As String = $"${k}disabled"$
	Return GetState(disKey,False)
End Sub

Sub GetRequiredState(k As String) As Boolean
	Dim disKey As String = $"${k}required"$
	Return GetState(disKey,False)
End Sub

Sub SetErrorState(k As String, v As Boolean)
	Dim showKey As String = $"${k}error"$
	SetStateSingle(showKey, v)
End Sub

Sub SetShowState(k As String, v As Boolean)
	Dim showKey As String = $"${k}show"$
	SetStateSingle(showKey, v)
End Sub

Sub SetDisabledState(k As String, v As Boolean)
	Dim disKey As String = $"${k}disabled"$
	SetStateSingle(disKey, v)
End Sub

Sub SetRequiredState(k As String, v As Boolean)
	Dim disKey As String = $"${k}required"$
	SetStateSingle(disKey, v)
End Sub

Sub CopyMap(source As Map, keys As List) As Map
	Return vue.CopyMap(source, keys)
End Sub

Sub FixRecords(recs As List, trimThese As List, numThese As List, boolThese As List, dateThese As List, dblThese As List)
	vue.FixRecords(recs, trimThese, numThese, boolThese, dateThese, dblThese)
End Sub

Sub MakeDouble(m As Map, xkeys As List)
	vue.MakeDouble(m, xkeys)
End Sub

Sub MakeInteger(m As Map, xkeys As List)
	vue.MakeInteger(m, xkeys)
End Sub

Sub MakeBoolean(m As Map, xkeys As List)
	vue.MakeBoolean(m, xkeys)
End Sub

Sub MakeTrim(m As Map, xkeys As List)
	vue.MakeTrim(m, xkeys)
End Sub

'date picker dates in yyyy-mm-dd format
Sub Prepare(keys As List)
	For Each k As String In keys
		Dim sk As String = GetState(k,"")
		sk = Date2YYYYMMDD(sk)
		SetStateSingle(k, sk)
	Next
End Sub

'convert date picker value to correct date
Sub ToYYYYMMDD(vmodel As String)
	Dim sk As String = GetState(vmodel,"")
	sk = Date2YYYYMMDD(sk)
	SetStateSingle(vmodel, sk)
End Sub

Sub JoinNonBlanks(delimiter As String, lst As List) As String
	Return vue.JoinNonBlanks(delimiter, lst)
End Sub

Sub JoinMaps(lst As List) As Map
	Return vue.JoinMaps(lst)
End Sub

Sub MakeDate(m As Map, xkeys As List)
	vue.MakeDate(m, xkeys)
End Sub

Sub ToggleNamedState(stateName As String, state1 As String, state2 As String) As BANanoVM
	vue.ToggleNamedState(stateName, state1, state2)
	Return Me
End Sub

'compile html to render
Sub Compile(html As String) As BANanoObject
	Dim bo As BANanoObject = vue.Compile(html)
	Return bo
End Sub

Sub CreateWaterBall(sid As String, eventHandler As Object, Width As String, Height As String) As VMWaterBall
	Dim el As VMWaterBall
	el.Initialize(vue, sid, eventHandler, Width, Height)
	
	Return el
End Sub

Sub CreateProgressCircle(sid As String, Width As String, Height As String) As VMProgressCircle
	Dim el As VMProgressCircle
	el.Initialize(vue, sid, Width, Height)
	
	Return el
End Sub

Sub MakePx(sValue As String) As String
	Return vue.MakePx(sValue)
End Sub

Sub SetDestroyed(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetDestroyed(moduleObj, methodName)
	Return Me
End Sub

Sub SetActivated(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetActivated(moduleObj, methodName)
	Return Me
End Sub

Sub SetComputed(k As String, moduleObj As Object, methodName As String) As BANanoVM
	vue.SetComputed(k, moduleObj, methodName)
	Return Me
End Sub


Sub SetDeActivated(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetDeActivated(moduleObj, methodName)
	Return Me
End Sub

Sub SetUpdated(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetUpdated(moduleObj, methodName)
	Return Me
End Sub

Sub SetBeforeMount(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetBeforeMount(moduleObj, methodName)
	Return Me
End Sub

Sub SetBeforeUpdate(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetBeforeUpdate(moduleObj, methodName)
	Return Me
End Sub

Sub SetBeforeDestroy(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetBeforeDestroy(moduleObj, methodName)
	Return Me
End Sub

Sub SetBeforeCreate(moduleObj As Object, methodName As String) As BANanoVM
	vue.SetBeforeCreate(moduleObj, methodName)
	Return Me
End Sub

'add a page to the template of the app
Sub AddPage(name As String, moduleObj As Object)
	Pages.add(name)
	BANano.CallSub(moduleObj, "Code", Array(Me))   'ignore
	Hide(name)
End Sub

'show a page for the app
Sub ShowPage(name As String)
	If Pages.IndexOf(name) = -1 Then
		Log($"ShowPage: ${name} does not exist!"$)
	End If
	For Each page As String In Pages
		If name = page Then
			Show(name)
		Else
			Hide(page)
		End If
	Next
End Sub

Sub GetOptionsFromKV(delim As String, k As String, v As String) As Map
	Return vue.GetOptionsFromKV(delim, k, v)
End Sub


Sub ShowPrompt1(pName As String)
	SetPrompt(Null)
	ShowDialog(pName)
End Sub

Sub SetPrompt(pvalue As Object)
	vue.SetStateSingle("promptvalue",pvalue)
End Sub

Sub GetPrompt As String
	Dim ss As String = vue.GetState("promptvalue","")
	ss = ss.tolowercase
	Return ss
End Sub

''build your own alert
'Sub AddAlert(alertid As String, eventHandler As Object, title As String, AlertContent As String, ConfirmText As String)
'	alertid = alertid.tolowercase
'	Dim myalert As VMAlert = CreateAlert(alertid,eventHandler).SetStatic(True).SetTitle(title).SetConfirmText(ConfirmText).SetContent(AlertContent)
'	myalert.Pop(Content)
'End Sub
'
''build your own confirm
'Sub AddConfirm(confirmid As String, eventHandler As Object, title As String, ConfirmContent As String, ConfirmText As String, CancelText As String)
'	confirmid = confirmid.tolowercase
'	Dim myalert As VMConfirm = CreateConfirm(confirmid,eventHandler).SetStatic(True).SetTitle(title).SetConfirmText(ConfirmText).SetContent(ConfirmContent).SetCancelText(CancelText)
'	myalert.Pop(Content)
'End Sub
'
''build your own prompt
'Sub AddPrompt(promptid As String, eventHandler As Object, title As String, Message As String,  placeHolder As String, maxLen As Int,ConfirmText As String, CancelText As String)
'	promptid = promptid.tolowercase
'	vue.SetStateSingle(promptid, Null)
'	Dim myprompt As VMPrompt = CreatePrompt(promptid, eventHandler).SetStatic(True).SetTitle(title).SetContent(Message).SetMaxLength(maxLen).SetPlaceHolder(placeHolder)
'	myprompt.SetConfirmText(ConfirmText).SetCancelText(CancelText)
'	myprompt.Pop(Content)
'End Sub

Sub SetCallBack(moduleObj As Object, methodName As String) As BANanoVM
	methodName = methodName.tolowercase
	If SubExists(moduleObj, methodName) = False Then Return Me
	Dim e As BANanoEvent
	Dim cb As BANanoObject = BANano.CallBack(moduleObj, methodName, e)
	vue.SetCallBack(methodName, cb)
	Return Me
End Sub

Sub SetButtonText(btnID As String, txt As String) As BANanoVM
	btnID = btnID.tolowercase
	vue.SetStateSingle($"${btnID}text"$, txt)
	Return Me
End Sub

Sub RemoveMethod(methodName As String) As BANanoVM
	vue.RemoveMethod(methodName)
	Return Me
End Sub



'Sub ShowPrompt(Title As String, Message As String,Placeholder As String, MaxLen As Int, ConfirmText As String, CancelText As String)
'	vue.SetStateSingle("promptvalue",Null)
'	vue.SetState(CreateMap("promptplaceholder":Placeholder, "prompttitle":Title,"promptcontent":Message, "promptconfirmtext":ConfirmText,"promptcanceltext":CancelText,"promptmaxlength":MaxLen))
'	Prompt.Show
'End Sub
'
'Sub ShowSnackBar(Message As String)
'	vue.SetState(CreateMap("snackmessage":Message))
'	Snack.show
'End Sub

Sub CreateSnackBar(sid As String, eventHandler As Object) As VMSnackBar
	Dim el As VMSnackBar
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub
	

Sub GetAlert As String
	Return vue.getstate("alertkey","")
End Sub

Sub CreateAutoComplete(sid As String, eventHandler As Object) As VMAutoComplete
	Dim el As VMAutoComplete
	el.Initialize(vue, sid, eventHandler)
	
	el.SetVModel(sid)
	Return el
End Sub

Sub CreateForm(sid As String, eventHandler As Object) As VMForm
	Dim el As VMForm
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateBottomSheet(sid As String, eventHandler As Object) As VMBottomSheet
	Dim el As VMBottomSheet
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateSheet(sid As String, eventHandler As Object) As VMSheet
	Dim el As VMSheet
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateChip(sid As String, eventHandler As Object) As VMChip
	Dim el As VMChip
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateTextArea(sid As String, eventHandler As Object) As VMTextArea
	Dim el As VMTextArea
	el.Initialize(vue, sid,eventHandler)
	
	Return el
End Sub


Sub CreateTextField(sid As String, eventHandler As Object) As VMTextField
	Dim el As VMTextField
	el.Initialize(vue, sid,eventHandler)
	Return el
End Sub


Sub CreateInput(sid As String, eventHandler As Object) As VMInput
	Dim el As VMInput
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateFileInput(sid As String, eventHandler As Object) As VMFileInput
	Dim el As VMFileInput
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub


'Sub CreateNumber(sid As String, eventHandler As Object) As VMInput
'	Dim el As VMInput = CreateInput(sid,eventHandler).SetTypeNumber(True)
'	
'	Return el
'End Sub
'
'Sub CreateEmail(sid As String, eventHandler As Object) As VMInput
'	Dim el As VMInput = CreateInput(sid, eventHandler).SetTypeEmail(True)
'	
'	Return el
'End Sub
'
'Sub CreatePassword(sid As String, eventHandler As Object) As VMInput
'	Dim el As VMInput = CreateInput(sid,eventHandler).SetTypePassword(True)
'	
'	Return el
'End Sub
'
'Sub CreateTel(sid As String, eventHandler As Object) As VMInput
'	Dim el As VMInput = CreateInput(sid,eventHandler).SetTypeTel(True)
'	
'	Return el
'End Sub


Sub AddContent(els As String)
	vue.SetTemplate(els)
End Sub

Sub CreateSpeedDial(sid As String, eventHandler As Object, initialIcon As String, finalIcon As String) As VMSpeedDial
	Dim el As VMSpeedDial
	el.Initialize(vue, sid,eventHandler)
	el.SetInitialIcon(initialIcon)
	el.SetFinalIcon(finalIcon)
	Return el
End Sub

Sub CreateMenu(sid As String, moduleObj As Object) As VMMenu
	Dim el As VMMenu
	el.Initialize(vue, sid, moduleObj)
	
	Return el
End Sub


Sub CreateDialog(sid As String, moduleObj As Object) As VMDialog
	Dim el As VMDialog
	el.Initialize(vue, sid, moduleObj)
	
	Return el
End Sub

Sub CreateDivider As VMDivider
	Dim el As VMDivider
	el.Initialize(vue)
	Return el
End Sub

Sub CreateRadio(sid As String, eventHandler As Object) As VMRadio
	Dim el As VMRadio
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateDatePicker(sid As String, eventHandler As Object) As VMDatePicker
	Dim el As VMDatePicker
	el.Initialize(vue, sid, eventHandler)
	
	Return el
End Sub

Sub CreateIcon(sid As String, moduleObj As Object, iconName As String) As VMIcon
	Dim el As VMIcon
	el.Initialize(vue, sid, moduleObj)
	el.SetText(iconName)
	Return el
End Sub

Sub CreateSpan(sid As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue,sid).SetTag("span")
	
	Return el
End Sub

Sub CreateElement(sid As String, stag As String) As VMElement
	Dim el As VMElement
	el.Initialize(vue,sid).SetTag(stag)	
	Return el
End Sub

Sub CreateButton(sid As String,moduleObj As Object) As VMButton
	Dim el As VMButton
	el.Initialize(vue, sid, moduleObj)
	Return el
End Sub

Sub CreateIconButton(sid As String,moduleObj As Object, iconName As String) As VMButton
	Dim el As VMButton
	el.Initialize(vue, sid, moduleObj)
	el.SetIconButton(iconName)
	Return el
End Sub

Sub CreateFABButton(sid As String,moduleObj As Object, iconName As String) As VMButton
	Dim el As VMButton
	el.Initialize(vue, sid, moduleObj)
	el.SetFabButton(iconName)
	Return el
End Sub

Sub CreateRadioGroup(sid As String, eventHandler As Object) As VMRadioGroup
	Dim el As VMRadioGroup
	el.Initialize(vue, sid, eventHandler)
	Return el
End Sub

Sub CreateToolbar(sid As String, moduleObj As Object) As VMToolBar
	Dim el As VMToolBar
	el.Initialize(vue, sid, moduleObj)	
	Return el
End Sub

Sub CreateOverlay(sid As String, moduleObj As Object) As VMOverlay
	Dim el As VMOverlay
	el.Initialize(vue, sid, moduleObj)	
	Return el
End Sub

Sub Validate(rec As Map, required As Map) As Boolean
	Return vue.Validate(rec, required)
End Sub

Sub CreateSelect(sid As String, eventHandler As Object) As VMSelect
	Dim el As VMSelect
	el.Initialize(vue,sid,eventHandler)
	
	Return el
End Sub

Public Sub DateNow() As String
	Return vue.DateNow
End Sub


Public Sub DateTimeNow() As String
	Return vue.DateTimeNow
End Sub

'get an element using jquery
Sub JQueryElement(sid As String) As BANanoObject
	sid = sid.ToLowerCase
	Dim bo As BANanoObject = JQuery.Selector($"#${sid}"$)
	Return bo
End Sub

'convert a map keys to lowercase
Sub MakeLowerCase(m As Map) As Map
	Return vue.MakeLowerCase(m)
End Sub

Sub HTTPUpload(fileObj As Object, moduleObj As Object, methodname As String)
	vue.HTTPUpload(fileObj, moduleObj, methodname)
End Sub

Sub GetFileDetails(fileObj As Map) As FileObject
	Return vue.GetFileDetails(fileObj)
End Sub

'for infor box
Sub SetInfoBox
	JQuery.Selector(".count-to").RunMethod("countTo", Null)
End Sub

Sub SetKnob
	BANano.RunJavascriptMethod("tron", Null)
End Sub

'show hour glass
Sub PagePause
	vue.SetStateSingle("pageloader", True)
End Sub

'hide hourglass
Sub PageResume
	vue.SetStateSingle("pageloader", False)
End Sub

Sub LeftString(Text As String, lLength As Long)As String
	Return vue.LeftString(Text, lLength)
End Sub

'set right to left
Sub SetRTL(b As Boolean) As BANanoVM
	RTL = b
	Drawer.SetRight(RTL)
	vuetify.SetField("rtl", b)
	Return Me
End Sub

'build the page
Sub UX
	Drawer.SetRight(RTL)
	'make spanish
	Dim mlang As Map = CreateMap()
	mlang.Put("current", lang)
	'
	Dim theme As Map = CreateMap()
	theme.Put("dark", Dark)
	Options.Put("rtl", RTL)
	Options.Put("theme", theme)
	Options.Put("lang", mlang)
	'
	Drawer.Pop(VApp)
	NavBar.Pop(VApp)
	
	Container.Pop(VContent)
	VContent.Pop(VApp)
	Footer.Pop(VApp)
	
	'template built from all pages
	vue.SetTemplate(VApp.ToString)
	'
	'set vuetify to the vue scope
	'create a new instance of vuetify
	BOVuetify.Initialize2("Vuetify", Options)
	vue.SetFrameWork("vuetify", BOVuetify)
	'create the app
	vue.ux
	data = vue.data
	'
	Dim svuetify As String = "$vuetify"
	vuetify = vue.BOVue.GetField(svuetify)
	
	If HasInfoBox Then SetInfoBox
	If HasKnob Then SetKnob
	
End Sub

Sub SetLocale(slang As String) As BANanoVM
	lang = slang
	Try
		vuetify.GetField("lang").SetField("current", slang)
	Catch
		Log(LastException)
	End Try
	Return Me
End Sub

'add a container
Sub AddContainer(cont As VMContainer)
	Dim scont As String = cont.tostring
	Container.SetText(scont)
End Sub

'add a container
Sub AddContainerRC(row As Int, col As Int, cont As VMContainer)
	Container.AddComponent(row, col, cont.ToString)
End Sub

Sub NewSwitch(sname As String, slabel As String, svalue As Object, sunchecked As Object, bPrimary As Boolean, iTabIndex As Int) As VMSwitch
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMSwitch = CreateSwitch(actName, module)
	el.SwitchBox.ActualID = actID
	el.SetVModel(actName)
	el.Setlabel(slabel)
	el.SetTrueValue(svalue)
	el.SetPrimary(bPrimary)
	el.SetFalseValue(sunchecked)
	el.SetTabIndex(iTabIndex)
	el.SwitchBox.Host = $"${actName}field"$
	Return el
End Sub
'
Sub NewRadioGroup(sname As String, slabel As String, svalue As Object, optionsm As Map, bShowLabel As Boolean, bLabelOnTop As Boolean, iTabIndex As Int) As VMRadioGroup
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMRadioGroup = CreateRadioGroup(actName, module)
	el.RadioGroup.ActualID = actID
	el.SetVModel(actName)
	el.Setlabel(slabel)
	el.SetOptions(optionsm)
	el.SetTabIndex(iTabIndex)
	el.RadioGroup.Host = $"${actName}label"$
	vue.SetData(actName, svalue)
	Return el
End Sub


Sub NewCheckBox(sname As String, slabel As String, svalue As Object, sunchecked As Object, bPrimary As Boolean, iTabIndex As Int) As VMCheckBox
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	
	Dim el As VMCheckBox = CreateCheckBox(actName, module)
	el.checkbox.ActualID = actID
	el.SetVModel(actName)
	el.SetTrueValue(svalue)
	el.Setlabel(slabel)
	el.SetPrimary(bPrimary)
	el.SetFalseValue(sunchecked)
	el.SetTabIndex(iTabIndex)
	el.CheckBox.Host = $"${actName}field"$
	Return el
End Sub

Sub NewDatePicker(sname As String, slabel As String, bRequired As Boolean, sPlaceholder As String, sHint As String, sErrorText As String, iTabIndex As Int) As VMDatePicker
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	
	Dim el As VMDatePicker = CreateDatePicker(actName, module)
	el.DatePicker.ActualID = actID
	el.Setlabel(slabel)
	el.SetRequired(bRequired)
	el.SetTabIndex(iTabIndex)
	el.SetVModel(actName)
	el.Setclearable(True)
	el.SetPlaceHolder(sPlaceholder)
	el.SetHint(sHint)
	el.SetErrorText(sErrorText)
	el.SetForInput
	Return el
End Sub
'
Sub NewTimePicker(sname As String, slabel As String, bRequired As Boolean, sPlaceholder As String, sHint As String, sErrorText As String, iTabIndex As Int) As VMTimePicker
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMTimePicker = CreateTimePicker(actName, module)
	el.TimePicker.ActualID = actID
	el.Setlabel(slabel)
	el.SetVModel(actName)
	el.Setclearable(True)
	el.SetRequired(bRequired)
	el.SetPlaceHolder(sPlaceholder)
	el.SetHint(sHint)
	el.SetTabIndex(iTabIndex)
	el.SetErrorText(sErrorText)
	el.SetForInput
	Return el
End Sub
'
'Sub NewChip(sname As String, sText As String, bClickable As Boolean, bDeletable As Boolean, sourceTable As String, sourceField As String, displayField As String) As VMInputControl
'	sname = sname.tolowercase
'	Dim actName As String = sname
'	Dim actID As String = sname
'	If sname.IndexOf(".") >= 0 Then
'		actName = MvField(sname,2,".")
'	End If
'	Dim el As VMInputControl
'	el.Initialize(actName)
'	el.ActualID = actID
'	el.SetChip
'	el.Text = sText
'	el.Clickable = bClickable
'	el.Deletable = bDeletable
'	If sourceTable <> Null Then el.sourceTable = sourceTable
'	If sourceField <> Null Then el.sourceField =sourceField
'	If displayField <> Null Then el.displayField = displayField
'	el.UseOptions = False
'	el.UseDataSource = True
'	el.Host = actName
'	Return el
'End Sub
'

'Sub NewInfoBox(sname As String, sText As String, sIcon As String, sIconBackgroundColor As String, iStart As Int, iFinish As Int) As VMInputControl
'	sname = sname.tolowercase
'	Dim actName As String = sname
'	Dim actID As String = sname
'	If sname.IndexOf(".") >= 0 Then
'		actName = MvField(sname,2,".")
'	End If
'	Dim el As VMInputControl
'	el.Initialize(actName)
'	el.ActualID = actID
'	el.typeof = "infobox"
'	el.fieldType = "string"
'	el.bSetCounter = True
'	el.Start = iStart
'	el.Finish = iFinish
'	el.IconName = sIcon
'	el.IconBackgroundColor = sIconBackgroundColor
'	el.Text = sText
'	el.Host = actName
'	Return el
'End Sub
'
''
Sub NewSlider(sname As String, slabel As String, iMinValue As Int, iMaxValue As String,iTabIndex As Int) As VMSlider
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMSlider = CreateSlider(actName, module)
	el.Slider.ActualID = actID
	el.Setmin(iMinValue)
	el.Setmax(iMaxValue)
	el.Setlabel(slabel)
	el.SetVModel(actName)
	el.SetThumbLabel("always")
	el.SetTabIndex(iTabIndex)
	Return el
End Sub
'
'added for back ward compatibility
Sub NewText(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, sIcon As String, iMaxLen As Int, shelpertext As String, sErrorText As String, iTabIndex As Int) As VMTextField
	Return NewTextField(sname, slabel, splaceholder, bRequired, sIcon, iMaxLen, shelpertext, sErrorText, iTabIndex)
End Sub

Sub NewTextField(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, sIcon As String, iMaxLen As Int, shelpertext As String, sErrorText As String, iTabIndex As Int) As VMTextField
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMTextField = CreateTextField(actName, module)
	el.TextField.ActualID = actID
	el.SetClearable(True)
	el.Setlabel(slabel)
	el.SetRequired(bRequired)
	el.SetPrependIcon(sIcon)
	If iMaxLen > 0 Then 
		el.SetMaxLength(iMaxLen)
		el.SetCounter(True)
	End If
	el.SetPlaceHolder(splaceholder)
	el.SetHint(shelpertext)
	el.SetTabIndex(iTabIndex)
	el.SetVModel(actName)
	el.SetErrorText(sErrorText)
	Return el
End Sub
'
Sub NewTel(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, sIcon As String, shelpertext As String, sErrorText As String, iTabIndex As Int) As VMTextField
	Dim el As VMTextField = NewTextField(sname, slabel, splaceholder, bRequired, sIcon, 0, shelpertext, sErrorText, iTabIndex)
	Return el
End Sub

Sub NewNumber(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, sIcon As String, shelpertext As String, sErrorText As String, iTabIndex As Int) As VMTextField
	Dim el As VMTextField = NewTextField(sname, slabel, splaceholder, bRequired, sIcon, 0, shelpertext, sErrorText, iTabIndex)
	Return el
End Sub

'
'auto complete that uses a list as a source
Sub NewAutoComplete(sname As String, slabel As String, splaceholder As String, lOptions As List, bRequired As Boolean, shelpertext As String, iTabIndex As Int) As VMAutoComplete
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMAutoComplete = CreateAutoComplete(actName, module)
	el.AutoComplete.ActualID = actID
	el.SetClearable(True)
	el.Setlabel(slabel)
	el.SetRequired(bRequired)
	el.SetPlaceHolder(splaceholder)
	el.SetHint(shelpertext)
	el.SetTabIndex(iTabIndex)
	el.SetVModel(actName)
	el.Bind(":items", $"${actName}items"$)
	vue.SetData($"${actName}items"$, lOptions)
	Return el
End Sub
'
'auto coomplete that uses objects as a source
Sub NewAutoComplete1(sname As String, slabel As String, splaceholder As String, dataSource As String, keyField As String, displayField As String, returnObject As Boolean, bRequired As Boolean, shelpertext As String, iTabIndex As Int) As VMAutoComplete
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMAutoComplete = CreateAutoComplete(actName, module)
	el.AutoComplete.ActualID = actID
	el.SetClearable(True)
	el.Setlabel(slabel)
	el.SetRequired(bRequired)
	el.SetPlaceHolder(splaceholder)
	el.SetHint(shelpertext)
	el.SetTabIndex(iTabIndex)
	el.SetVModel(actName)
	el.SetDataSource(dataSource, keyField, displayField, returnObject)
	Return el
End Sub

'
Sub NewTextArea(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, bAutoGrow As Boolean, sIcon As String, iMaxLen As Int, shelpertext As String, sErrorText As String, iTabIndex As Int) As VMTextArea
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMTextArea = CreateTextArea(actName, Me)
	el.TextArea.ActualID = actID
	el.SetClearable(True)
	el.Setlabel(slabel)
	el.Setrequired(bRequired)
	el.SetPrependIcon(sIcon)
	If iMaxLen > 0 Then 
		el.SetCounter(iMaxLen)
		el.SetMaxLength(iMaxLen)
	End If
	el.SetPlaceHolder(splaceholder)
	el.SetHint(shelpertext)
	el.SetTabIndex(iTabIndex)
	el.SetErrorText(sErrorText)
	el.SetAutoGrow(bAutoGrow)
	el.SetVModel(actName)
	Return el
End Sub

'
Sub NewPassword(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, bToggle As Boolean, sIcon As String, iMaxLen As Int, shelpertext As String, sErrorText As String, iTabIndex As Int) As VMTextField
	Dim el As VMTextField = NewTextField(sname, slabel, splaceholder, bRequired, sIcon, iMaxLen, shelpertext, sErrorText, iTabIndex)
	el.SetPassword(True, bToggle)
	Return el
End Sub

'backward compatibility
Sub NewFile(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, shelpertext As String, sErrorText As String, iTabIndex As Int) As VMFileInput
	Return NewFileInput(sname, slabel, splaceholder, bRequired, shelpertext, sErrorText, iTabIndex)
End Sub
'
Sub NewFileInput(sname As String, slabel As String, splaceholder As String, bRequired As Boolean, shelperText As String, sErrorText As String, iTabIndex As Int) As VMFileInput
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMFileInput = CreateFileInput(actName, module)
	el.FileInput.ActualID = actID
	el.SetHint(shelperText)
	el.SetErrorText(sErrorText)
	el.SetTabIndex(iTabIndex)
	el.SetPlaceHolder(splaceholder)
	el.SetVModel(actName)
	el.Setlabel(slabel)
	Return el
End Sub
'
Sub NewImage(sname As String, src As String, salt As String, swidth As String, sheight As String, borderRadius As String) As VMImage
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMImage = CreateImage(actName, module)
	el.Image.ActualID = actID
	el.SetWidth(swidth)
	el.SetHeight(sheight)
	el.SetSrc(src)
	el.SetAlt(salt)
	If borderRadius <> "" Then
		el.BindStyleSingle("borderRadius", borderRadius)
	End If
	Return el
End Sub
'
'
Sub NewLabel(sname As String, sSize As String, sText As String) As VMLabel
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMLabel = CreateLabel(actName)
	el.Label.ActualID = actID
	el.SetTag(sSize)
	el.SetText(sText)
	Select Case sSize
	Case vue.SIZE_BLOCKQUOTE
		el.AddClass("blockquote")	
	End Select
	Return el
End Sub


Sub NewIcon(sname As String, sIcon As String, sSize As String, scolor As String) As VMIcon
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMIcon = CreateIcon(actName, module, sIcon)
	el.Icon.ActualID = actID
	el.SetAttributes(Array(sSize))
	el.SetColor(scolor)
	Return el
End Sub
'
Sub NewButton(sname As String, sLabel As String, bTransparent As Boolean, bPrimary As Boolean, bFitWidth As Boolean) As VMButton
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	Dim el As VMButton = CreateButton(actName, Me)
	el.Button.ActualID = actID
	el.SetLabel(sLabel)
	el.SetTransparent(bTransparent)
	If bPrimary Then el.SetPrimary(bPrimary)
	If bFitWidth Then el.SetBlock(True)
	Return el
End Sub
'
'define a select from a datasource
Sub NewSelect(sname As String, sLabel As String, bRequired As Boolean, bMultiple As Boolean, sPlaceHolder As String, sourceTable As String, sourceField As String, displayField As String, returnObject As Boolean, sHelperText As String, iTabIndex As Int) As VMSelect
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	
	Dim el As VMSelect = CreateSelect(actName, module)
	el.COmbo.ActualID = actID
	el.Setlabel(sLabel)
	el.SetRequired(bRequired)
	el.SetTabIndex(iTabIndex)
	el.SetPlaceholder(sPlaceHolder)
	el.SetHint(sHelperText)
	el.SetMultiple(bMultiple)
	el.SetDataSource(sourceTable, sourceField, displayField,returnObject)
	el.SetVModel(actName)
	Return el
End Sub
'
'use select with map
Sub NewSelect1(sname As String, sLabel As String, bRequired As Boolean, bMultiple As Boolean, sPlaceHolder As String, optionsm As Map, sourceField As String, displayField As String, returnObject As Boolean, sHelperText As String, iTabIndex As Int) As VMSelect
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	
	Dim el As VMSelect = CreateSelect(actName, module)
	el.Combo.ActualID = actID
	el.Setlabel(sLabel)
	el.Setrequired(bRequired)
	el.SetTabIndex(iTabIndex)
	el.Setplaceholder(sPlaceHolder)
	el.SetHint(sHelperText)
	el.Setmultiple(bMultiple)
	el.SetOptions($"${actName}items"$, optionsm, sourceField, displayField, returnObject)
	Return el
End Sub
'
'
Sub NewIconButton(sname As String, iconName As String, sColor As String, sTooltip As String) As VMButton
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	
	Dim el As VMButton = CreateButton(actName, module)
	el.Button.ActualID = actID
	el.SetIconButton(iconName)
	el.SetColor(sColor)
	el.SetTooltip(sTooltip)
	Return el
End Sub

Sub NewFABButton(sname As String, iconName As String, sColor As String, sTooltip As String) As VMButton
	sname = sname.tolowercase
	Dim actName As String = sname
	Dim actID As String = sname
	If sname.IndexOf(".") >= 0 Then
		actName = MvField(sname,2,".")
	End If
	
	Dim el As VMButton = CreateFABButton(actName, module, iconName)
	el.Button.ActualID = actID
	el.SetColor(sColor)
	el.SetTooltip(sTooltip)
	Return el
End Sub

'add a blank option to a list
Sub AddBlankOption(lst As List, keyField As String, ValueField As String)
	Dim opt As Map = CreateMap()
	opt.Put(keyField, "")
	opt.Put(ValueField, "--Nothing Selected--")
	lst.Add(opt)
End Sub