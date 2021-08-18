#author: Ioana Onut Brännström


### First download the webin-cli-3.7.0.jar from https://github.com/enasequence/webin-cli/releases

webin=	#local path for the webin-cli-3.7.0.jar file
inputMANIFEST= #path for the manifest file. Examples can be found: https://ena-docs.readthedocs.io/en/latest/submit/general-guide.html
inputDIR= #path of the directory where the file to be submitted is
java -jar $webin -userName=Webin-xxxx -password=xxxx -context=genome -manifest=$inputMANIFEST -inputDir=$inputDIR -submit  #change to the appropriate webin id and password