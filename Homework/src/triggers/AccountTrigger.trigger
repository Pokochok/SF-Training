/**
 * Created by Павлик on 22/12/2019.
 */

trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete) {
    if (trigger.isAfter) {
        if (trigger.isInsert) {
            AccountHandler.createNewTaskAndLinkWithAccount(trigger.new);
        }
    }
}