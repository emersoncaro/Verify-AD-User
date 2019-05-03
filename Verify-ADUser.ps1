#Write-Host "Server Monitoring Script v0.7.4"
$stdDate = Get-Date
Write-Host Script started on: $stdDate

function Get-andCheckADuser {
  param(
    [Parameter(Mandatory=$true, Position=0, 
               ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNull()]
    [string[]]$ADUserName
  )
      process {
                    #for($I=1; $I -le 99; $I++)
                    #{
                    #    Write-Progress -Activity "Getting utilization from server $ComputerName. Please wait..." -Status "$I% Complete" -PercentComplete $I
                    #}
          Try
          {
                foreach ($c in $ADUserName) 
                {
                    Write-Progress -Activity "Getting Active Directory information from user $c. Please wait..." -Status "99% Complete" -PercentComplete 99
                    if (@(Get-ADUser -Filter "Company -like '*$c*'").Count -eq 0)
                    {
                        Write-Output $c >> .\notfoundusers.txt
                    }
                    else
                    {
                        Get-ADUser -Filter "Company -like '*$c*'" -Properties *
                    }
                }
          }
          Catch
          {
            Write-Host "$c": $PSItem.ToString() -ForegroundColor red
          }
      }
  }

                 #for($I=1; $I -le 100; $I++)
               # {
               #     if(!(Test-Path -Path .\Output ))
               #     {
                  #      for($J=1; $J -le 100; $J++)
                 #       {
                    #        Write-Progress -Activity "Creating directory..." -Status "$J% Complete" -PercentComplete $J
                  #      }
                   #     Write-Host "`nCreating Folder ""Output""."
                   #     New-Item -ItemType Directory -Path .\Output
                   #     Write-Host "`nFolder ""Output"" Created."
                  #  }
                  #  if(!(Test-Path -Path '.\servers.txt'))
                   # {
                   #     New-Item -ItemType File -Path '.\servers.txt'
                    #    Write-Host "`n`n`nPlease edit the file 'servers.txt' and add the hostname of your server/s to continue"
                  #  }
              #  }
 
 Get-Content '.\users.txt' | Get-andCheckADuser | Format-Table -AutoSize | Tee-Object -FilePath ".\foundusers.txt" -Append
 $finalDate = Get-Date
 #Get-Date | Out-File -FilePath ".\Output\$(($finalDate).ToString('yyyy-MM-dd')).txt" -Append
 Write-Host "Script Done as of " $finalDate -ForegroundColor Green
 #Write-Host "`nScript done as of" $finalDate "`n`nThe result is stored in 'Results.xlsx' in the 'Output' folder on this directory. `n`nPress enter to exit and open the result..." -ForegroundColor green
#Invoke-Item -Path ".\adusers.txt"
 Read-Host