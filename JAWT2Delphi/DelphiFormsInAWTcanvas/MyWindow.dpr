{ History:
   8Mar2000 - first creation based on the Object Pascal demo (that was itself created from JavaWorld tip 13)
            - added message (uncomment to see it) when "paint" is invoked
            - made it to show forms inside a Java container (however only GraphicControls are supported inside them, not windowed controls)
}

library MyWindow;
 uses math,
  jni,
  windows,
  messages,
  javasoft_jawt,
  javasoft_jawt_md,
  sysutils,
  testForm in 'testForm.pas' {Form1},
  paintCode in 'paintCode.pas';

////////////////////////////////////////////////////////////////

exports
 Java_MyWindow_paint name 'Java_MyWindow_paint';

begin
end.

