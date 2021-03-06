﻿B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=8.1
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano  'ignore
	Public vm As BANanoVM
	Private db As BANanoSQL
	Private alaSQL As BANanoAlaSQLE
End Sub

Sub Init
	'initialize the page
	vm.Initialize(Me, Main.appname)
	'add a hamburger
	vm.NavBar.AddHamburger
	vm.NavBar.Hamburger.SetVisible(True)
	vm.NavBar.AddLogo("./assets/formutilities.jpg")
	vm.NavBar.Logo.Show
	vm.NavBar.AddTitle("Form Utilities","")
	vm.NavBar.AddSpacer
	vm.NavBar.SetVisible(True)
	'set primary color for the navbar
	vm.NavBar.SetPrimary(True)
	'fix the navbar so that it does not move
	vm.NavBar.SetModeFixed(True)
	'the navbar will be visible
	vm.NavBar.Show
	'
	vm.NavBar.AddIcon("btnRefreshTables","refresh", "Refresh tables", "")
	vm.NavBar.AddIcon("btnAddTable","add", "Add table", "")
	
	'
	BuildDrawer
	AddPages
	'build the page
	vm.ux
	'
	HideButtons
	vm.Show("btnAddTable")
	vm.show("btnRefreshTables")
	vm.ShowPage(modTables.name)
	vm.CallMethod("RefreshTables")
End Sub

'hide all buttons
Sub HideButtons
	vm.hide("btnAddTable")
	vm.Hide("btnRefreshTables")
End Sub

Sub BuildDrawer
	vm.Drawer.AddItem("drawertables", "", "Tables")
End Sub

Sub btnAddTable_click(e As BANanoEvent)
	modTables.mode = "A"
	modTables.mdlTable.Container.setdefaults
	modTables.mdlTable.SetTitle("Add Table")
	vm.showdialog("mdlTable")
End Sub

'add different 'pages' you have created add them here
'these should be code modules
Sub AddPages
	vm.AddPage(modTables.name, modTables)
End Sub

Sub draweritems_click(e As BANanoEvent)
	'get the id from the event
	Dim elID As String = vm.GetIDFromEvent(e)
	Select Case elID
	Case "drawertables"	
		HideButtons
		vm.show("btnAddTable")
		vm.show("btnRefreshTables")
		vm.ShowPage(modTables.name)
		vm.CallMethod("RefreshTables")
	End Select
End Sub

Sub btnRefreshTables_click(e As BANanoEvent)
	vm.CallMethod("RefreshTables")
End Sub

Sub back_click(e As BANanoEvent)

End Sub

Sub confirm_ok(e As BANanoEvent)
	Dim sconfirm As String = vm.getconfirm
	Select Case sconfirm
	Case "delete_table"
		'delete the table
		Dim stablename As String = vm.getstate("tablename","")
		'open the database
		db.OpenWait("alasql", "formutilities")
		alaSQL.Initialize("tables", "tablename")
		alaSQL.Delete(stablename)
		alaSQL.result = db.ExecuteWait(alaSQL.query, alaSQL.args)
		Log(alaSQL.result)
		vm.CallMethod("RefreshTables")
	End Select
End Sub