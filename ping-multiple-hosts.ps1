$Output= @()
$names = Get-content "hostnames.txt"
while ($true) {
    foreach ($name in $names){
      $Time = (Get-Date).ToString(“HH:mm:ss”)
      $Date = Get-Date -Format dd.MM.yyyy
      # Test-Connection -TimeoutSeconds parameter available at PSVersion 6 (Check: $PSVersionTable.PSVersion)
      $response = (Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue | measure-Object -Property ResponseTime -Average).average
      if ($response -ne $null){
        #$response = ($response -as [int] ) 
        $Output+= "$Date,$Time,$name,up,$response ms"
        Write-Host "$Date,$Time,$Name,up,$response ms" -ForegroundColor Green
      }else{
        $Output+= "$Date,$Time,$name,down,no response"
        Write-Host "$Date,$Time,$Name,down,no response" -ForegroundColor Red
      }
    }
    $Output | Out-file results.csv
    # Start-Sleep -Seconds 1
    # Start-Sleep -Millis 300
}