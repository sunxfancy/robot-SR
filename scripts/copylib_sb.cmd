if not exist .\extlib\include mkdir .\extlib\include
if not exist .\extlib\lib mkdir .\extlib\lib

copy .\build\third-party\sphinxbase\include .\extlib\include
copy .\build\third-party\sphinxbase\bin\Debug\x64\*.lib .\extlib\lib
copy .\build\third-party\sphinxbase\bin\Release\x64\*.lib .\extlib\lib
