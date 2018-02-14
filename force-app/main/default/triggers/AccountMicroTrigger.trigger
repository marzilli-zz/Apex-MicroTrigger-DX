trigger AccountMicroTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    MicroTriggersDispatcher dispatcher = new MicroTriggersDispatcher();
    dispatcher.dispatch();
    //Print each MicroTrigger Result
    List<MicroTriggerResult> executionResults = MicroTriggersDispatcher.ExecutionResults;
    for(MicroTriggerResult microTriggerResult :executionResults) {
        System.debug('******************** MicroTrigger Execution ************************');
        System.debug('MicroTrigger Name = ' + microTriggerResult.MicroTriggerName);
        System.debug('Criteria Is Met = ' + microTriggerResult.CriteriaIsMet);
        
        //Print all the success Actions
        for(String successAction :microTriggerResult.SuccessActions)
            System.debug('Success Action = ' + successAction);
    }
}