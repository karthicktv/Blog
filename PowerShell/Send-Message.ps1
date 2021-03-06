param([string]$qname, [string]$body, [string]$label)

if ( [System.String]::IsNullOrEmpty($qname) )
{
    write-host "You must provide a queue name"
    exit
}

if ( [System.String]::IsNullOrEmpty($body) )
{
    write-host "You must provide a message body"
    exit
}

[Reflection.Assembly]::LoadWithPartialName("System.Messaging") | out-null

$q = new-object System.Messaging.MessageQueue($qname)

$msg = new-object System.Messaging.Message($body)

if ( $label )
{
    $msg.Label = $label
}

$q.Send( $msg, [System.Messaging.MessageQueueTransactionType]::Single )

write-host "Message sent with body $body to $qname"

exit