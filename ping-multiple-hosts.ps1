$Output= @()
$names = Get-content "hostnames.txt"
while ($true) {
    foreach ($name in $names){
      $Time = (Get-Date).ToString(“HH:mm:ss”)
      $Date = Get-Date -Format dd.MM.yyyy
      if (Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue){
       $Output+= "$Date,$Time,$name,up"
       Write-Host "$Date,$Time,$Name,up" -ForegroundColor Green
      }
      else{
        $Output+= "$Date,$Time,$name,down"
        Write-Host "$Date,$Time,$Name,down" -ForegroundColor Red
      }
    }
    $Output | Out-file results.csv
    Start-Sleep -Seconds 1
}