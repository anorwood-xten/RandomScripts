using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.

$quad1 = $Request.Query.quad1
$quad2 = $Request.Query.quad2
$quad3 = $Request.Query.quad3
$quad4 = $Request.Query.quad4
$comb1 = $Request.Query.comb1
$comb2 = $Request.Query.comb2
$comb3 = $Request.Query.comb3

[array]$comb1List = $Request.Query.comb1List
[array]$comb2List = $Request.Query.comb2List
[array]$comb3List = $Request.Query.comb3List


if (-not $quad1) {
    $quad1 = $Request.Body.quad1
    $quad2 = $Request.Body.quad2
    $quad3 = $Request.Body.quad3
    $quad4 = $Request.Body.quad4
    $comb1 = $Request.Body.comb1
    $comb2 = $Request.Body.comb2
    $comb3 = $Request.Body.comb3

    [array]$comb1List = $Request.Body.comb1List
    [array]$comb2List = $Request.Body.comb2List
    [array]$comb3List = $Request.Body.comb3List
}

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

$a = 1..9

$i = 0

$answer = 0

while ($answer -eq 0) {

    $i = $i + 1

    $list = $a | Sort-Object { Get-Random }

    if (($i % 10000) -eq 0) {
        $i
        $list -join ','
        $comb1Value
        $comb2Value
        $comb3Value
    }

    $matrix = [PsCustomObject]@{
        1 = $list[0] 
        2 = $list[1] 
        3 = $list[2] 
        4 = $list[3] 
        5 = $list[4] 
        6 = $list[5] 
        7 = $list[6]
        8 = $list[7] 
        9 = $list[8]
            
    }

    $comb1Value = 0
    $comb2Value = 0
    $comb3Value = 0

    $comb1List | ForEach-Object {
        $comb1Value += ((Get-Variable matrix).Value).$_
    }

    $comb2List | ForEach-Object {
        $comb2Value += ((Get-Variable matrix).Value).$_
    }

    $comb3List | ForEach-Object {
        $comb3Value += ((Get-Variable matrix).Value).$_
    }

    if ($quad1 -eq ($matrix.1 + $matrix.2 + $matrix.4 + $matrix.5)`
            -and $quad2 -eq ($matrix.2 + $matrix.3 + $matrix.5 + $matrix.6)`
            -and $quad3 -eq ($matrix.4 + $matrix.5 + $matrix.7 + $matrix.8)`
            -and $quad4 -eq ($matrix.5 + $matrix.6 + $matrix.8 + $matrix.9)`
            -and $comb1 -eq $comb1Value`
            -and $comb2 -eq $comb2Value`
            -and $comb3 -eq $comb3Value) {

        $body = $matrix

        $answer = 1

    }
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
        Body       = $body
    })
