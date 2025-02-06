public with sharing class ContactTriggerHandler {
    public static void beforeInsert(List<Contact> newList){
        setDummyJSONId(newList);
    }
    public static void afterInsert(List<Contact> newList, Map<Id, Contact> newMap){
        callgetDummyJSONUserFromId(newList);
    }
    public static void beforeUpdate(List<Contact> oldList, List<Contact> newList, Map<Id, Contact> oldMap, Map<Id, Contact> newMap){
        callpostCreateDummyJSONUser(oldList, newList);
    }

    public static void setDummyJSONId(List<Contact> newList){
        for (Contact con : newList) {
            if (con.DummyJSON_Id__c == null || String.isBlank(con.DummyJSON_Id__c) ) {
                con.DummyJSON_Id__c = String.valueOf(Integer.valueOf((Math.random()*100)));
            }
        }
    }

    public static void callgetDummyJSONUserFromId(List<Contact> newList){
        for (Contact con : newList) {
            if (Integer.valueOf(con.DummyJSON_Id__c) <= 100) {
                DummyJSONCallout.getDummyJSONUserFromId(con.DummyJSON_Id__c);
            }
        }
    }

    public static void callpostCreateDummyJSONUser(List<Contact> oldList, List<Contact> newList){
        for (Contact con : newList) {
            if (Integer.valueOf(con.DummyJSON_Id__c) > 100) {
                DummyJSONCallout.postCreateDummyJSONUser(con.Id);
            }
        }
    }
}