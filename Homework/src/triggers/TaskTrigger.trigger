/**
 * Created by Павлик on 22/12/2019.
 */

trigger TaskTrigger on Task (before insert, before update, before delete, after insert, after update, after delete) {
    public static Boolean afterUpdateFirsRun = true;
    if (trigger.isAfter) {
        if (trigger.isUpdate) {
            TaskHandler.afterUpdateProcessing(trigger.oldMap, trigger.newMap);
        }
    }
}