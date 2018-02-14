public class ChangeOwnerIdAction implements TriggerBeforeUpdate.Action { 
    public Boolean run(TriggerBeforeUpdate.Context currentContext, List<SObject> scope) {
        Set<Id> userIds = new Set<Id>();
        
        for(SObject theObject : scope) {
            Account theAccount = (Account)theObject;
            Account oldAccount = (Account)currentContext.oldMap.get(theAccount.Id);
            userIds.add(oldAccount.OwnerId);
        }
        Map<Id,User> allTheUsers = new Map<Id,User>([SELECT Id, FirstName, LastName from User where Id in :userIds]);
        
        for(SObject theObject : scope) {
            Account theAccount = (Account)theObject;
            Account oldAccount = (Account)currentContext.oldMap.get(theAccount.Id);
            User oldOwner = allTheUsers.get(oldAccount.OwnerId);
            theAccount.Description = 'Previous Owner: ' + oldOwner.FirstName + ' ' + oldOwner.LastName;
            System.debug('******************** Acct Des: ' + theAccount.Description);
        }
        return true;
    }
}
