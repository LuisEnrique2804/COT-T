trigger CatalogoServiciosTradicionales on CatalogoServiciosTradicionales__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {
	new ServiciosTradicionalesTriggerHandler().Run();  
}