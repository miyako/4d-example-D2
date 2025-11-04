property Markdown : Text
property Diagram : Picture
property Message : Text
property D2 : cs:C1710.D2.D2
property tempFolder : 4D:C1709.Folder

Class constructor
	
	This:C1470.Markdown:="# example.d2\n# Simple D2 diagram for testing rendering and CLI output\n\n# Nodes\nApp: \"Frontend App\"\nAPI: \"Backend API\"\nDB: \"Database\"\nCache: \"Redis Cache\"\n\n# Connections\nApp -> API: \"calls\"\nAPI -> DB: \"queries\"\nAPI -> Cache: \"reads/writes\"\nCache -> DB:"+" \"fallback\"\n\n# Grouping\ngroup Infra {\n    DB\n    Cache\n}\n\n# Styling\nApp.style.fill: \"#f0f9ff\"\nAPI.style.fill: \"#e0f7fa\"\nDB.style.fill: \"#fff3e0\"\nCache.style.fill: \"#e8f5e9\"\n\n# Layout direction\ndirection: right"
	
	This:C1470.Message:=""
	
	This:C1470.D2:=cs:C1710.D2.D2.new()
	This:C1470.tempFolder:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).folder("d2")
	This:C1470.tempFolder.create()
	
Function render()
	
	This:C1470.Message:="Processing..."
	
	var $D2 : cs:C1710.D2.D2
	$D2:=cs:C1710.D2.D2.new()
	
	$file:=OBJECT Get name:C1087(Object with focus:K67:3)="Markdown" ? Get edited text:C655 : Form:C1466.Markdown
	
	var $tasks : Collection
	$tasks:=[]
	
	$output:=This:C1470.tempFolder.file(Generate UUID:C1066+".png")
	$tasks.push({file: $file; output: $output; data: $output})
	
	$D2.render($tasks; This:C1470.onResponse)
	
Function onResponse($worker : 4D:C1709.SystemWorker; $params : Object)
	
	If (Form:C1466#Null:C1517)
		If (Value type:C1509($params.context)=Is object:K8:27)\
			 && (OB Instance of:C1731($params.context; 4D:C1709.File))\
			 && ($params.context.exists)
			var $png : Picture
			READ PICTURE FILE:C678($params.context.platformPath; $png)
			Form:C1466.Diagram:=$png
			Form:C1466.Message:="Success!"
		Else 
			Form:C1466.Message:="Error!"
		End if 
	End if 