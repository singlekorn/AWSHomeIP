#Requires -Modules @{ModuleName='AWS.Tools.Common';ModuleVersion='4.1.80'}
#Requires -Modules @{ModuleName='AWS.Tools.EventBridge';ModuleVersion='4.1.80'}

# Get IPv4 Public IPs from $env:URLS and store into $json
$json = @{}
$ips=@()
foreach ($url in ($env:URLS -split ',')) {

    # ADD validation: Good Request, is IPv4 Address
    $ip = (Invoke-WebRequest -Uri $url | ConvertFrom-Json).ip
    Write-Host "$((Get-PSCallStack)[0].FunctionName): INFO `'$url`' is reachable from $ip"
    $ips += $ip

}
$json.Add("ipv4",$ips)

# Send IP information to AWS EventBridge

# Create the Event Entry
$PutEventsRequestEntry = New-Object Amazon.EventBridge.Model.PutEventsRequestEntry
    $PutEventsRequestEntry.Detail = $json | ConvertTo-Json
    $PutEventsRequestEntry.DetailType = "AHI-Agent Public IPs"
    $PutEventsRequestEntry.EventBusName = $env:AWS_EVENT_BUS_NAME
    $PutEventsRequestEntry.Time = Get-Date

Write-Host "$((Get-PSCallStack)[0].FunctionName): INFO creating EventBridge Event: "
$PutEventsRequestEntry

# Send the Event to the AHI-Updater via AWS EventBridge