#$a=1,2,3,4,6,8,9
$a = 1..9

$i = 0

$answer = 0

$quad1 = 24
$quad2 = 22
$quad3 = 20
$quad4 = 15
$comb1 = 16
$comb2 = 8
$comb3 = 21

$comb1List = 2, 5
$comb2List = 6, 8, 9
$comb3List = 1, 3, 4, 7

$startTime = Get-Date

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

        $matrix

        $answer = 1

    }
}

$EndTime = Get-Date

($endTime - $startTime).TotalSeconds