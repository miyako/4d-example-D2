//%attributes = {}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	//execute in a worker to process callbacks
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	var $form : cs:C1710.Form
	$form:=cs:C1710.Form.new()
	
	$window:=Open form window:C675("TEST")
	DIALOG:C40("TEST"; $form; *)
	
End if 