function Load-EnvironmentVariables {

        #'runway envvars' returns an array of environment variables defined in ${env}\runway.yml
        #typical envvars include AWS_PROFILE and AWS_DEFAULT_REGION.
        #$_ denotes an environment variable declaration in the envvars array
        #For example, $envvars[0] = $env:AWS_PROFILE = "vcoredev", $envvars[1] = $env:AWS_REGION = "us-west-1", etc.)    
    
         Write-Host "Loading environment variables..." -ForegroundColor Yellow
         (runway envvars) | ForEach-Object { Write-Output -InputObject $_; Invoke-Expression -Command $_ }
             
    }