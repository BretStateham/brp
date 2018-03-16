$reponame = "FlySimExpress"
$repozipurl = "https://github.com/BretStateham/FlySimExpress/archive/master.zip"
$curloc = Get-Location
$curpath = $curloc.Path.toString()
$repounzipfolder = $curpath + "/" + $reponame + "-master"
$repofolder = $curpath + "/" + $reponame
$testfolder = $curpath + "/" + $reponame + "Test"
$repozip = $curpath + "/" + $reponame + "-master.zip"
$releasezip = $curpath + "/" + $reponame + ".zip"
Remove-Item -Recurse -Force -Path $repofolder
Remove-Item -Recurse -Force -Path $testfolder
Remove-Item -Path $repozip
Remove-Item -Path $releasezip
Write-Host "Downloading repo zip file. Please wait..."
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://github.com/BretStateham/FlySimExpress/archive/master.zip" -OutFile $repozip
$ProgressPreference = 'Continue'
Unblock-File -Path $repozip
Expand-Archive -Path $repozip -Destination $curpath -Force
Rename-Item -Path $repounzipfolder -NewName $repofolder
.\TrainingKitPackager\TrainingKitPackager.exe $repofolder
Compress-Archive -Path $repofolder -DestinationPath $releasezip -Force
Expand-Archive -Path $releasezip -Destination $testfolder -Force

