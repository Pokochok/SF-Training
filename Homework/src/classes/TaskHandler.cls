/**
 * Created by Павлик on 22/12/2019.
 */

public with sharing class TaskHandler {
    public static Boolean afterUpdateProcessingFirstRun = true;

    public static void afterUpdateProcessing(Map<Id, Task> oldTasks, Map<Id, Task> newTasks){
        afterUpdateProcessingFirstRun = false;
        TaskTriggerHelper.plansDiscussedToTrueWhenTaskCompleted(newTasks.values());
    }
}