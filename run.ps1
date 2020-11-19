Write-Host "Keep the files you want to use as input inside the input_files folder" -ForegroundColor Red
Write-Host ""

function exit_me{
	Set-Location .\..
	exit
}


Set-Location .\src

# Generate .java files
javacc source.jj;

if(-NOT $?){
	Write-Host "JAVACC Failed" -BackgroundColor Red
	exit_me
}

# Compile

javac *.java

if(-NOT $?){
	Write-Host "Compilation Process Failed" -BackgroundColor Red
	exit_me
}

Set-Location .\..

# Run
java -cp .\src Compiler $args[0]
