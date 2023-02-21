Param(
    [Parameter(Mandatory = $true)]
    [string]$finishTime,
    [int]$beefWeight,
    [int]$lambWeight,
    [int]$porkWeight
)

$timingTable = @()
$row = "" | Select-Object Time,Description
[int]$RestingTime = 900
[string]$highTemp = "220 (200 fan)"
[string]$lowTemp = "180 (160 fan)"

$endTime = Get-Date -Hour (($finishTime).split(":")[0]) -Minute (($finishTime).split(":")[1]) -Second 0

#beef - 25 min per 500g plus 25 min, 20 min at high temp
#lamb - 25 min per 500g plus 25 min, 20 min at high temp
#pork - 35 min per 500g, plus 35 min, 30 min at high temp


#beef and lamb

[int]$highTempTime = 1200
[int]$timePer500g = 1500

$takeOutOfOven = $endTime.AddSeconds(-$RestingTime)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($takeOutOfOven) -format "HH:mm"
$row.Description = "Take Beef out of the oven to rest"
$timingTable += $row

$weightModulo = $beefweight % 500
$timePeriods = ($beefweight - $weightModulo) / 500
$remainderTimePeriod = ($timePer500g / 500) * $weightModulo

$timeToCookTotal = ($timePeriods * $timePer500g) + $remainderTimePeriod

$setToLowTemp = $takeOutOfOven.AddSeconds( - ($timeToCookTotal - $timeAtLowTemp))

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($setToLowTemp) -format "HH:mm"
$row.Description = "Put Beef in the oven set to $lowTemp"
$timingTable += $row

$putInOven = $setToLowTemp.AddSeconds(-$highTempTime)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put Beef in the oven set to $highTemp"
$timingTable += $row



[int]$highTempTime = 1200
[int]$timePer500g = 1500

$takeOutOfOven = $endTime.AddSeconds(-$RestingTime)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($takeOutOfOven) -format "HH:mm"
$row.Description = "Take Lamb out of the oven to rest"
$timingTable += $row

$weightModulo = $lambWeight % 500
$timePeriods = ($lambWeight - $weightModulo) / 500
$remainderTimePeriod = ($timePer500g / 500) * $weightModulo

$timeToCookTotal = ($timePeriods * $timePer500g) + $remainderTimePeriod

$setToLowTemp = $takeOutOfOven.AddSeconds( - ($timeToCookTotal - $timeAtLowTemp))

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($setToLowTemp) -format "HH:mm"
$row.Description = "Put Lamb in the oven set to $lowTemp"
$timingTable += $row

$putInOven = $setToLowTemp.AddSeconds(-$highTempTime)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put Lamb in the oven set to $highTemp"
$timingTable += $row


#Pork

[int]$highTempTime = 1800
[int]$timePer500g = 2100

$takeOutOfOven = $endTime.AddSeconds(-$RestingTime)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($takeOutOfOven) -format "HH:mm"
$row.Description = "Take Pork out of the oven to rest"
$timingTable += $row

$weightModulo = $beefweight % 500
$timePeriods = ($beefweight - $weightModulo) / 500
$remainderTimePeriod = ($timePer500g / 500) * $weightModulo

$timeToCookTotal = ($timePeriods * $timePer500g) + $remainderTimePeriod

$setToLowTemp = $takeOutOfOven.AddSeconds( - ($timeToCookTotal - $timeAtLowTemp))

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($setToLowTemp) -format "HH:mm"
$row.Description = "Put Pork in the oven set to $lowTemp"
$timingTable += $row

$putInOven = $setToLowTemp.AddSeconds(-$highTempTime)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put Pork in the oven set to $highTemp"
$timingTable += $row

#Roast Carrots/Parsnips

$timeToCook = (45*60)

$putInOven = $endTime.AddSeconds(-$timeToCook)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put carrots and parsnips in the oven set to $highTemp"
$timingTable += $row

#Roast Potatoes

$timeToCook = (60*60)

$putInOven = $endTime.AddSeconds(-$timeToCook)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put potatoes in the oven set to $highTemp"
$timingTable += $row

$steamDry = $putInOven.AddSeconds(-600)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($steamDry) -format "HH:mm"
$row.Description = "Start to steam dry the potatoes"
$timingTable += $row

$parboil = $steamDry.AddSeconds(-600)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($parboil) -format "HH:mm"
$row.Description = "Start to parboil the potatoes"
$timingTable += $row

#Cauliflower Cheese

$timeToCook = (20*60)

$putInOven = $endTime.AddSeconds(-$timeToCook)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put cauliflower cheese in the oven set to $highTemp"
$timingTable += $row

#Yorkshire Puddings

$timeToCook = (20*60)

$putInOven = $endTime.AddSeconds(-$timeToCook)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put Yorkshire Puddings in the oven set to $highTemp"
$timingTable += $row

$putTrayInOven = $putInOven.AddSeconds(-$timeToCook)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putTrayInOven) -format "HH:mm"
$row.Description = "Put Yorkshire Pudding tray in the oven set to $highTemp to warm oil"
$timingTable += $row


#Brussel Sprouts

$timeToCook = (30*60)

$putInOven = $endTime.AddSeconds(-$timeToCook)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($putInOven) -format "HH:mm"
$row.Description = "Put Brussel Sprouts in the oven set to $highTemp"
$timingTable += $row

#Heat Ovens

$earliestTime = Get-Date($timingTable | Sort-Object Time | Select-Object -ExpandProperty Time -First 1)

$heatOvens = $earliestTime.AddSeconds(-1200)

$row = "" | Select-Object Time,Description
$row.Time = Get-Date($heatOvens) -format "HH:mm"
$row.Description = "Heat the ovens to $lowTemp and $highTemp"
$timingTable += $row

$timingTable | Sort-Object Time | Export-CSV -Path .\ChristmasDinner2022.csv -NoTypeInformation