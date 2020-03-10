﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Public name As String = "designCode"
	Public title As String = "Design"
	Private vm As BANanoVM
	Private BANano As BANano
End Sub


Sub Code
	vm = pgIndex.vm
	'create a container to hold all contents
	Dim cont As VMContainer = vm.CreateContainer(name, Me)
	'hide this container
	cont.Hide
	'
	Dim switch As VMSwitch = vm.NewSwitch("switch1", "Radio", "Yes", "No", True, 0).SetDevicePositions(1, 1, 12, 6, 6, 6)
	cont.AddControl1(switch.SwitchBox, switch.ToString)
	'
	Dim radiogroup As VMRadioGroup = vm.NewRadioGroup("radiogroup", "Gender", "female", CreateMap("male":"Male","female":"Female"), True, True, 0).SetDevicePositions(1, 2, 12, 6, 6, 6)
	radiogroup.SetHorizontal(True)
	cont.AddControl1(radiogroup.RadioGroup, radiogroup.ToString)
	'
	Dim checkbox As VMCheckBox = vm.NewCheckBox("checkbox", "I concur!", "Yes", "No", True, 0).SetDevicePositions(1, 3, 12, 6, 6, 6)
	cont.AddControl1(checkbox.CheckBox, checkbox.ToString)
	'
	Dim datepicker As VMDatePicker = vm.NewDatePicker("datepicker", "Date Picker", True,  "Select a Date Picker", "This date", "", 0).SetDevicePositions(1, 4, 12, 6, 6, 6)
	cont.AddControl1(datepicker.DatePicker, datepicker.ToString)
	'
	Dim timepicker As VMTimePicker = vm.NewTimePicker("timepicker", "Time Picker", True, "Select a time Picker", "This time", "", 0).SetDevicePositions(2, 1, 12, 6, 6, 6)
	cont.AddControl1(timepicker.TimePicker, timepicker.ToString)
	'
	Dim slider As VMSlider = vm.NewSlider("slider", "Slider", 0, 100, 0).SetDevicePositions(2, 2, 12, 6, 6, 6)
	cont.AddControl1(slider.Slider, slider.ToString)
	'
	Dim txtName As VMTextField = vm.NewTextField("firstname", "First Name", "Enter your first name", True, "", 50, "First Name", "", 0).SetDevicePositions(3, 1, 12, 6, 6, 6)
	cont.AddControl1(txtName.Textfield, txtName.ToString)
	'
	Dim lst As List
	lst.Initialize
	lst.Add(CreateMap("name": "Florida", "abbr": "FL", "id": "1"))
	lst.Add(CreateMap("name": "Georgia", "abbr": "GA", "id": "2"))
	lst.Add(CreateMap("name": "Nebraska", "abbr": "NE", "id": "3"))
	lst.Add(CreateMap("name": "California", "abbr": "CA", "id": "4"))
	lst.Add(CreateMap("name": "New York", "abbr": "NY", "id": "5"))
	vm.SetData("states2", lst)
	'
	Dim genderlist As Map = CreateMap("f":"Female", "m":"Male")
	Dim genderlist1 As List = Array("Male", "Female")
		
	Dim ac1 As VMAutoComplete = vm.NewAutoComplete1("acx1", "States", "States", "states2", "id", "name", False, True, "This is it!", 0).SetDevicePositions(3, 2, 12, 6, 6, 6)
	cont.AddControl1(ac1.AutoComplete, ac1.ToString)
	'
	Dim ac2 As VMAutoComplete = vm.NewAutoComplete("acx2", "Gender", "Gender", genderlist1, False, "This is it!", 0).SetDevicePositions(3, 2, 12, 6, 6, 6)
	cont.AddControl1(ac2.AutoComplete, ac2.ToString)
	'
	Dim txta As VMTextArea = vm.NewTextArea("txtarea", "Text Area", "A placeholder", True, False, "", 255, "Helper Text", "", 0).SetDevicePositions(4, 1, 12, 12, 12, 12)
	cont.AddControl1(txta.TextArea, txta.ToString)
	'
	Dim pwd As VMTextField = vm.NewPassword("pwd1", "Password", "Enter your password!", True, True, "mdi-lock", 10, "Password","", 0).SetDevicePositions(5, 1, 12, 6, 6, 6)
	cont.AddControl1(pwd.TextFIeld, pwd.ToString)
	'
	Dim fi As VMFileInput = vm.NewFileInput("fileinput", "Select your file!", "Enter a file", True, "This is a file!", "", 0).SetDevicePositions(5, 2, 12, 6, 6, 6)
	cont.AddControl1(fi.FileInput, fi.ToString)
	'
	Dim img As VMImage = vm.NewImage("image", "./assets/sponge.png", "Sponge", "100", "100", "10px").SetDevicePositions(6, 1, 12, 6, 6, 6)
	img.SetBorder("1px", vm.COLOR_BLACK, vm.BORDER_DOUBLE)
	cont.AddControl1(img.Image, img.ToString)
	'
	Dim lbl As VMLabel = vm.NewLabel("labelz", vm.SIZE_H1, "This is H1").SetDevicePositions(6, 2, 12, 6, 6, 6)
	cont.AddControl1(lbl.Label, lbl.ToString)
	'
	Dim icon As VMIcon = vm.NewIcon("icon", "mdi-chevron-right", vm.ICON_LARGE, vm.COLOR_AMBER).SetDevicePositions(7, 1, 12, 6, 6, 6)
	icon.SetDark(True)
	cont.AddControl1(icon.Icon, icon.ToString)
	'
	Dim btn As VMButton = vm.NewButton("buttonx", "TheMash Block", True, True, True).SetDevicePositions(7, 2, 12, 6, 6, 6)
	cont.AddControl1(btn.Button, btn.ToString)
	'
	Dim mysel As VMSelect = vm.NewSelect("myselect", "Select States", True, True, "States", "states2", "id", "name", False, "My thingo", 0).SetDevicePositions(8, 1, 12, 6, 6, 6)
	cont.AddControl1(mysel.Combo, mysel.ToString)
	'
	Dim mysel1 As VMSelect = vm.NewSelect1("myselect1", "Select Gender", True, False, "Gender", genderlist, "id", "text", False, "My thingo", 0).SetDevicePositions(8, 2, 12, 6, 6, 6)
	cont.AddControl1(mysel1.Combo, mysel1.ToString)
	'
	Dim btnx As VMButton = vm.NewIconButton("btnicon", "mdi-dots-vertical", vm.COLOR_BROWN, "Account details").SetDevicePositions(9, 1, 12, 6, 6, 6)
	cont.AddControl1(btnx.Button, btnx.ToString)
	'
	Dim btnxy As VMButton = vm.NewFabButton("btnicony", "mdi-pencil", vm.COLOR_DEEPORANGE, "Fab Button").SetDevicePositions(9, 2, 12, 6, 6, 6)
	btnxy.SetLarge(True)
	cont.AddControl1(btnxy.Button, btnxy.ToString)
	
	'add container to page
	vm.AddContainer(cont)
End Sub