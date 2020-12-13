[CmdletBinding()]

Param(
        [ValidateSet("dev", "qa", "prod")]
        [string]
        $Environment,
        [ValidateSet("deploy", "destroy")]
        [string]
        $Action,
        [ValidateSet("enabled")]
        [string]
        $Tag
)

#all errors = terminating
$ErrorActionPreference = "Stop"

#load modules
. "..\modules\load_env_vars.ps1\load_env_vars.ps1"
. "..\modules\update_cmdb.ps1\update_cmdb.ps1"

Set-Location "..\environments\$Environment"

Load-EnvironmentVariables #source environment variables defined in ${env}\runway.yml

Write-Host "Sleeping..." -ForegroundColor Yellow
Start-Sleep 3

Write-Host "Debug env_vars..."
$env:AWS_PROFILE
$env:AWS_DEFAULT_REGION
$env:CI
$env:VPC_ID
$Action

Write-Host "Sleeping..." -ForegroundColor Yellow
Start-Sleep 3


#deploy or destroy the modules defined in ${env}\runway.yml
runway $Action --tag $Tag --debug --verbose 

if ($LastExitCode -ne 0)
{
    Write-Host "Runway command failed, check CloudFormation console for details..." -ForegroundColor Magenta
    Set-Location $PSScriptRoot
    exit
}

try{

Write-Host "Updating CMDB..." -ForegroundColor Yellow
Update-CMDB -AWSProfile $env:AWS_PROFILE -Region $env:AWS_DEFAULT_REGION -VpcId $env:VPC_ID -Action $Action
Set-Location $PSScriptRoot

}

catch{

        Write-Host "Last exit code was..."
        $LASTEXITCODE
        Write-Host "Updating CMDB failed: $_"
        Set-Location $PSScriptRoot

}

#return to script root
Set-Location $PSScriptRoot