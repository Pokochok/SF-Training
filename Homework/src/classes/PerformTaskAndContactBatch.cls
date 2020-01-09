global class PerformTaskAndContactBatch implements Schedulable{
    global void execute(SchedulableContext sc){
        ChangeObjectsIfTaskIsNotSynced taskBatch = new ChangeObjectsIfTaskIsNotSynced();
        ChangeContactsWhichAreNotSynced contactsBatch = new ChangeContactsWhichAreNotSynced();
        Database.executeBatch(taskBatch);
        Database.executeBatch(contactsBatch);
    }
}