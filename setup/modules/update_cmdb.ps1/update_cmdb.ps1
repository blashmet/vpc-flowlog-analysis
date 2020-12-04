function Update-CMDB {

        [CmdletBinding()]

        Param(        
                [ValidatePattern('.*')][string]$AWSProfile, #no check, TBD       
                [ValidatePattern('.*')][string]$Region, #no check, TBD
                [ValidatePattern('^vpc-[0-9a-f]{8,17}$')][string]$VpcId,  #short (8char) or long (16char) VPC ID
                [ValidateSet("deploy", "destroy")][string]$Action #valid deploy command                            
        )    

                $CMDBFolder = "..\..\cmdb"
                $CMDBFile = "cmdb.log"
                if(!(Test-Path -Path "$CMDBFolder\$CMDBFile")) {New-Item -Path "$CMDBFolder\$CMDBFile" -ItemType File}

                $CMDBObject = New-Object PSObject -Property @{

                        AWSProfile       = $AWSProfile
                        Region          = $Region
                        VpcId           = $VpcId

                }
                    
                if($Action -eq "deploy"){
                        
                        $CMDBObject | Add-Content -Path "$CMDBFolder\$CMDBFile"
                        Write-Host "Added $VpcId to CMDB" -ForegroundColor Green

                }

                if($Action -eq "destroy"){
                        
                        Set-Content -Path "$CMDBFolder\$CMDBFile" -Value (Get-Content -Path "$CMDBFolder\$CMDBFile" | Select-String -Pattern $VpcId -NotMatch)
                        Write-Host "Removed $VpcId from CMDB" -ForegroundColor Green

                }               
             
    }