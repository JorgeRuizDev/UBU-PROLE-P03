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
Write-Host "JAVACC OK" -ForegroundColor Blue

# Compile

javac *.java

if(-NOT $?){
	Write-Host "Compilation Process Failed" -ForegroundColor Red
	exit_me
}
Write-Host "COMPILE OK" -ForegroundColor Blue

Set-Location .\..

# Generate JJDOC HTML:
jjdoc .\src\source.jj

# Run
if ($args.length -lt 1){
    java -cp .\src compiler
}
else{

    (java -cp .\src Compiler .\input_files\$args) | Tee-Object -file out.txt

}
