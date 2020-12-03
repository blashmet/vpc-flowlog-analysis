[CmdletBinding()]
param(
        [Parameter()]
        [string]$Environment,
        [Parameter()]
        [string]$DeployCommand,
        [Parameter()]
        [string]$Tag

     )

##stop on any errors
$ErrorActionPreference = "Stop"

##load environment variables defined in ${env}\runway.yml
. "..\modules\load_env_vars.ps1\load_env_vars.ps1"

cd ..\environments\$Environment

Load-EnvironmentVariables

##provision or destroy the modules defined in ${env}\runway.yml
runway $DeployCommand --tag $Tag --debug --verbose

##return to script root
cd $PSScriptRoot