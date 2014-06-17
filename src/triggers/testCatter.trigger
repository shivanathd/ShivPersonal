trigger testCatter on FeedItem (after insert) {

for(FeedItem a: Trigger.new)
{
 system.debug('$$$$$$'+a);
}

}