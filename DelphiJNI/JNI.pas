{********************************************
                                                       
       Translation of Sun's jni.h file to Borland      
       Pascal. Most people will prefer to use the      
       object wrappers in JavaVM.Pas
                                            
       Java and Delphi Freelance programming
             jrevusky@bigfoot.com           
                                            
********************************************}

unit jni;

interface

 {jboolean constants}

const JNI_FALSE = 0;
const JNI_TRUE = 1;

const JNI_OK = 0;
const JNI_ERR = -1;

const JNI_COMMIT = 1;
const JNI_ABORT = 2;

type
   jboolean = Shortint;
   jchar = Word;
   jshort = SmallInt;
   jbyte = Byte;
   jint = Integer;
   jsize = jint;
   jlong = Comp;
   jfloat = single;
   jdouble = double;
   
   jobject = Pointer;
   jclass = jobject;
   jthrowable = jobject;
   jstring = jobject;
   jarray = jobject;
   jbooleanArray = jarray;
   jbyteArray = jarray;
   jcharArray = jarray;
   jshortArray = jarray;
   jintArray = jarray;
   jlongArray = jarray;
   jfloatArray = jarray;
   jdoubleArray = jarray;
   jobjectArray = jarray;
   
   PJNIEnv = ^JNIEnv;
   PPJNIEnv = ^PJNIEnv;
   PJBoolean = ^jboolean;
   PJByte = ^jbyte;
   PJValue = ^jvalue;
   PJChar = ^jchar;
   PJShort = ^jshort;
   PJInt = ^jint;
   PJLong = ^jlong;
   PJFloat = ^jfloat;
   PJDouble = ^jdouble;
   PJObject = ^jobject;
   
   TNumType  = (bool, byte, char, short, int, long, float, double, obj);
   
   jvalue = record
      case Kind: TnumType of
         bool: (z: jboolean) ;
         byte: (b: jbyte);
         char: (c: jchar);
         short : (s : jshort);
         int : (i : jint);
         long : (j: jlong);
         float : (f : jfloat);
         double : (d: jdouble);
         obj : (l: jobject);
      end;

     jfieldID = Pointer;
     jmethodID = Pointer;

      JNINativeMethod = packed record
         name, signature : PChar;
         fnPtr : Pointer;
      end;

  PJNINativeMethod = ^JNINativeMethod;

  { JNI Native Method Interface.}

  JNIEnv = ^JNINativeInterface_;

  { JNI Invocation Interface.}

  JavaVM = ^JNIInvokeInterface_;

  PJNIInvokeInterface = ^JNIInvokeINterface_;

  JavaVM_ = packed record
    functions : PJNIInvokeInterface;
    reserved0, reserved1, reserved2 : Pointer;
  end;

  PJavaVM = ^JavaVM;
  PPJavaVM = ^PJavaVM;

   JNINativeInterface_ = packed record
      reserved0, reserved1, reserved2, reserved3 : Pointer;
      GetVersion : function(env : PJNIEnv) : jint ; stdcall;
      DefineClass : function(env : PJNIEnv; const name : PChar; loader : jobject; buf : PJByte; len : jsize) : jclass ; stdcall;
      FindClass : function(env: PJNIEnv; const name : PChar) : jclass ; stdcall;
      reserved4, reserved5, reserved6 : Pointer;
      GetSuperClass : function(env: PJNIEnv; sub, sup : jclass) : jclass ; stdcall;
      IsAssignableFrom : function(env: PJNIEnv; sub, sup : jclass) : jboolean ; stdcall;
      reserved7 : Pointer;
      Throw : function (env: PJNIEnv; obj : jthrowable) : jboolean ; stdcall;
      ThrowNew : function(env : PJNIEnv; clazz: jclass; const msg : PChar) : jint ; stdcall;
      ExceptionOccurred, ExceptionDescribe, ExceptionClear : procedure (env : PJNIEnv) ; stdcall;
      FatalError : procedure(env: PJNIEnv; const msg : PChar) ; stdcall;
      reserved8, reserved9 : Pointer;
      NewGlobalRef : function (env: PJNIEnv; obj : jobject) : jobject ; stdcall;
      DeleteGlobalRef : procedure (env: PJNIEnv; obj : jobject) ; stdcall;
      DeleteLocalRef : procedure (env: PJNIEnv; obj : jobject) ; stdcall;
      IsSameObject : function (env: PJNIEnv; obj1, obj2 : jobject) : jboolean ; stdcall;
      reserved10, reserved11 : Pointer;
      AllocObject : function(env: PJNIEnv; clazz : Jclass) : jclass ; stdcall;
      NewObject : function( env: PJNIEnv; clazz: jclass ; methodID : jmethodID) : jobject ; stdcall;
      NewObjectV : function( env: PJNIEnv; clazz: jclass ; methodID : jmethodID; args : Pointer) : jobject ; stdcall;
      NewObjectA : function( env: PJNIEnv; clazz: jclass ; methodID : jmethodID; args : PJValue) : jobject ; stdcall;
      GetObjectClass : function(env: PJNIEnv; obj: jobject) : jclass ; stdcall;
      IsInstanceof : function(env: PJNIEnv; obj: jobject; clazz : jclass) : jboolean; stdcall;
      GetMethodID : function(env: PJNIEnv; clazz : Jclass; const name, sig : PChar) : jmethodID ; stdcall;
      CallObjectMethod : function (env: PJNIEnv; obj : jobject; methodID : jmethodID) : jobject ; stdcall;
      CallObjectMethodV : function (env: PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jobject ; stdcall;
      CallObjectMethodA : function (env: PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jobject ; stdcall;
      CallBooleanMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jboolean ; stdcall;
      CallBooleanMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jboolean ; stdcall;
      CallBooleanMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jboolean ; stdcall;
      CallByteMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jbyte ; stdcall;
      CallByteMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jbyte ; stdcall;
      CallByteMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jbyte ; stdcall;
      CallCharMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jchar ; stdcall;
      CallCharMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jchar ; stdcall;
      CallCharMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jchar ; stdcall;
      CallShortMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jshort ; stdcall;
      CallShortMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jshort ; stdcall;
      CallShortMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jshort ; stdcall;
      CallIntMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jint ; stdcall;
      CallIntMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jint ; stdcall;
      CallIntMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jint ; stdcall;
      CallLongMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jlong ; stdcall;
      CallLongMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jlong ; stdcall;
      CallLongMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jlong ; stdcall;
      CallFloatMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jfloat ; stdcall;
      CallFloatMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jfloat ; stdcall;
      CallFloatMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jfloat ; stdcall;
      CallDoubleMethod : function (env : PJNIEnv; obj : jobject; methodID : jmethodID) : jdouble ; stdcall;
      CallDoubleMethodV : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) : jdouble ; stdcall;
      CallDoubleMethodA : function (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) : jdouble ; stdcall;
      CallVoidMethod : procedure (env : PJNIEnv; obj : jobject; methodID : jmethodID) ; stdcall;
      CallVoidMethodV : procedure (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : Pointer) ; stdcall;
      CallVoidMethodA : procedure (env : PJNIEnv; obj : jobject; methodID : jmethodID; args : PJValue) ; stdcall;
      CallNonvirtualObjectMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jobject ; stdcall;
      CallNonvirtualObjectMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jobject ; stdcall;
      CallNonvirtualObjectMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jobject ; stdcall;
      CallNonvirtualBooleanMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jboolean ; stdcall;
      CallNonvirtualBooleanMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jboolean ; stdcall;
      CallNonvirtualBooleanMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jboolean ; stdcall;
      CallNonvirtualByteMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jbyte ; stdcall;
      CallNonvirtualByteMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jbyte ; stdcall;
      CallNonvirtualByteMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jbyte ; stdcall;
      CallNonvirtualCharMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jchar ; stdcall;
      CallNonvirtualCharMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jchar ; stdcall;
      CallNonvirtualCharMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jchar ; stdcall;
      CallNonvirtualShortMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jshort ; stdcall;
      CallNonvirtualShortMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jshort ; stdcall;
      CallNonvirtualShortMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jshort ; stdcall;
      CallNonvirtualIntMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jint ; stdcall;
      CallNonvirtualIntMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jint ; stdcall;
      CallNonvirtualIntMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jint ; stdcall;
      CallNonvirtualLongMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jlong ; stdcall;
      CallNonvirtualLongMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jlong ; stdcall;
      CallNonvirtualLongMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jlong ; stdcall;
      CallNonvirtualFloatMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jfloat ; stdcall;
      CallNonvirtualFloatMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jfloat ; stdcall;
      CallNonvirtualFloatMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jfloat ; stdcall;
      CallNonvirtualDoubleMethod : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) : jdouble ; stdcall;
      CallNonvirtualDoubleMethodV : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) : jdouble ; stdcall;
      CallNonvirtualDoubleMethodA : function (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID ; args : PJValue) : jdouble ; stdcall;
      CallNonvirtualVoidMethod : procedure (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID) ; stdcall;
      CallNonvirtualVoidMethodV : procedure (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : Pointer) ; stdcall;
      CallNonvirtualVoidMethodA : procedure (env: PJNIEnv; obj : jobject ; clazz : jclass; methodID : jmethodID; args : PJValue) ; stdcall;
      GetFieldId : function (env: PJNIEnv; clazz : jclass; const name, sig : PChar) : jfieldID ; stdcall;
      GetObjectField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jobject ; stdcall;
      GetBooleanField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jboolean ; stdcall;
      GetByteField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jbyte ; stdcall;
      GetCharField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jchar ; stdcall;
      GetShortField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jshort ; stdcall;
      GetIntField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jint ; stdcall;
      GetLongField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jlong ; stdcall;
      GetFloatField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jfloat ; stdcall;
      GetDoubleField : function (env: PJNIEnv; obj : jobject; fieldID : jfieldID) : jdouble ; stdcall;
      SetObjectField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jobject) ; stdcall;
      SetBooleanField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jboolean) ; stdcall;
      SetByteField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jbyte) ; stdcall;
      SetCharField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jchar) ; stdcall;
      SetShortField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jshort) ; stdcall;
      SetIntField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jint) ; stdcall;
      SetLongField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jlong) ; stdcall;
      SetFloatField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jfloat) ; stdcall;
      SetDoubleField : procedure (env: PJNIEnv; obj: jobject; fieldID : jfieldID; val : jdouble) ; stdcall;
      GetStaticMethodID : function (env: PJNIEnv; clazz : jclass; const name, sig : PChar) : jmethodID ; stdcall;
      CallStaticObjectMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jobject ; stdcall;
      CallStaticObjectMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jobject ; stdcall;
      CallStaticObjectMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jobject ; stdcall;
      CallStaticBooleanMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jboolean ; stdcall;
      CallStaticBooleanMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jboolean ; stdcall;
      CallStaticBooleanMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jboolean ; stdcall;
      CallStaticByteMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jbyte ; stdcall;
      CallStaticByteMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jbyte ; stdcall;
      CallStaticByteMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jbyte ; stdcall;
      CallStaticCharMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jchar ; stdcall;
      CallStaticCharMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jchar ; stdcall;
      CallStaticCharMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jchar ; stdcall;
      CallStaticShortMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jshort ; stdcall;
      CallStaticShortMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jshort ; stdcall;
      CallStaticShortMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jshort ; stdcall;
      CallStaticIntMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jint ; stdcall;
      CallStaticIntMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jint ; stdcall;
      CallStaticIntMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jint ; stdcall;
      CallStaticLongMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jlong ; stdcall;
      CallStaticLongMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jlong ; stdcall;
      CallStaticLongMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jlong ; stdcall;
      CallStaticFloatMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jfloat ; stdcall;
      CallStaticFloatMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jfloat ; stdcall;
      CallStaticFloatMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jfloat ; stdcall;
      CallStaticDoubleMethod : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID) : jdouble ; stdcall;
      CallStaticDoubleMethodV : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) : jdouble ; stdcall;
      CallStaticDoubleMethodA : function (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) : jdouble ; stdcall;
      CallStaticVoidMethod : procedure (env: PJNIEnv; clazz : jclass; methodID : jmethodID) ; stdcall;
      CallStaticVoidMethodV : procedure (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : Pointer) ; stdcall;
      CallStaticVoidMethodA : procedure (env: PJNIEnv; clazz : jclass; methodID : jmethodID; args : PJValue) ; stdcall;
      GetStaticFieldID : function (env: PJNIEnv ; clazz : jclass ; const name, sig : PChar) : jfieldID ; stdcall;
      GetStaticObjectField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jobject ; stdcall;
      GetStaticBooleanField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jboolean ; stdcall;
      GetStaticByteField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jbyte ; stdcall;
      GetStaticCharField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jchar ; stdcall;
      GetStaticShortField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jshort ; stdcall;
      GetStaticIntField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jint ; stdcall;
      GetStaticLongField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jlong ; stdcall;
      GetStaticFloatField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jfloat ; stdcall;
      GetStaticDoubleField : function (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID) : jdouble ; stdcall;
      SetStaticObjectField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jobject) ; stdcall;
      SetStaticBooleanField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jboolean) ; stdcall;
      SetStaticByteField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jbyte) ; stdcall;
      SetStaticCharField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jchar) ; stdcall;
      SetStaticShortField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jshort) ; stdcall;
      SetStaticIntField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jint) ; stdcall;
      SetStaticLongField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jlong) ; stdcall;
      SetStaticFloatField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jfloat) ; stdcall;
      SetStaticDoubleField : procedure (env: PJNIEnv ; clazz : jclass ; fieldID : jfieldID ; value : jdouble) ; stdcall;
      NewString : function (env: PJNIEnv ; const unicode : PJChar ; len : jsize) : jstring ; stdcall;
      GetStringLength : function (env : PJNIEnv ; str : jstring) : jsize ; stdcall;
      GetStringChars : function (env: PJNIEnv ; str : jstring; isCopy : PJBoolean) : PJChar ; stdcall;
      ReleaseStringChars : procedure (env: PJNIEnv ; str : jstring; chars : PJChar) ; stdcall;
      NewStringUTF : function (env: PJNIEnv ; utf : PChar) : jstring ; stdcall;
      GetStringUTFLength : function (env : PJNIEnv ; str : jstring) : jsize ; stdcall;
      GetStringUTFChars : function (env : PJNIEnv ; str : jstring ; isCopy : PJBoolean) : PChar ; stdcall;
      ReleaseStringUTFChars : procedure (env : PJNIEnv ; str : jstring ; chars : PChar) ; stdcall;
      GetArrayLength : function (env : PJNIEnv ; arr : jarray) : jsize ; stdcall;
      NewObjectArray : function (env: PJNIEnv ; len : jsize ; clazz : jclass ; init : jobject) : jobjectArray ; stdcall;
      GetObjectArrayElement : function (env : PJNIEnv ; arr : jobjectArray ; index : jsize) : jobject ; stdcall;
      SetObjectArrayElement : procedure (env : PJNIEnv ; arr : jobjectArray ; index : jsize ; val : jobject) ; stdcall;
      NewBooleanArray : function (env : PJNIEnv ; len : jsize) : jbooleanArray ; stdcall;
      NewByteArray : function (env : PJNIEnv ; len : jsize) : jbyteArray ; stdcall;
      NewCharArray : function (env : PJNIEnv ; len : jsize) : jcharArray ; stdcall;
      NewShortArray : function (env : PJNIEnv ; len : jsize) : jshortArray ; stdcall;
      NewIntArray : function (env : PJNIEnv ; len : jsize) : jintArray ; stdcall;
      NewLongArray : function (env : PJNIEnv ; len : jsize) : jlongArray ; stdcall;
      NewFloatArray : function (env : PJNIEnv ; len : jsize) : jfloatArray ; stdcall;
      NewDoubleArray : function (env : PJNIEnv ; len : jsize) : jdoubleArray ; stdcall;
      GetBooleanArrayElements : function(env : PJNIEnv ; arr :  jbooleanArray ; isCopy : PJBoolean) : PJBoolean ; stdcall;
      GetByteArrayElements : function(env : PJNIEnv ; arr :  jbyteArray ; isCopy : PJBoolean) : PJByte ; stdcall;
      GetCharArrayElements : function(env : PJNIEnv ; arr :  jcharArray ; isCopy : PJBoolean) : PJChar ; stdcall;
      GetShortArrayElements : function(env : PJNIEnv ; arr :  jshortArray ; isCopy : PJBoolean) : PJShort; stdcall;
      GetIntArrayElements : function(env : PJNIEnv ; arr :  jintArray ; isCopy : PJInt) : PJInt ; stdcall;
      GetLongArrayElements : function(env : PJNIEnv ; arr :  jlongArray ; isCopy : PJLong) : PJLong ; stdcall;
      GetFloatArrayElements : function(env : PJNIEnv ; arr :  jfloatArray ; isCopy : PJBoolean) : PJFloat; stdcall;
      GetDoubleArrayElements : function(env : PJNIEnv ; arr :  jdoubleArray ; isCopy : PJBoolean) : PJDouble; stdcall;
      ReleaseBooleanArrayElements : procedure (env : PJNIEnv; arr :  jbooleanArray ; elems : PJBoolean ; mode : jint) ; stdcall;
      ReleaseByteArrayElements : procedure (env : PJNIEnv; arr :  jbyteArray ; elems : PJByte ; mode : jint) ; stdcall;
      ReleaseCharArrayElements : procedure (env : PJNIEnv; arr :  jcharArray ; elems : PJChar ; mode : jint) ; stdcall;
      ReleaseShortArrayElements : procedure (env : PJNIEnv; arr :  jshortArray ; elems : PJShort ; mode : jint) ; stdcall;
      ReleaseIntArrayElements : procedure (env : PJNIEnv; arr :  jintArray ; elems : PJInt ; mode : jint) ; stdcall;
      ReleaseLongArrayElements : procedure (env : PJNIEnv; arr :  jlongArray ; elems : PJLong ; mode : jint) ; stdcall;
      ReleaseFloatArrayElements : procedure (env : PJNIEnv; arr :  jfloatArray ; elems : PJFloat ; mode : jint) ; stdcall;
      ReleaseDoubleArrayElements : procedure (env : PJNIEnv; arr :  jdoubleArray ; elems : PJDouble ; mode : jint) ; stdcall;
      GetBooleanArrayRegion : procedure (env : PJNIEnv ; arr : jbooleanArray ; start, l : jsize ; buf : PJBoolean) ; stdcall;
      GetByteArrayRegion : procedure (env : PJNIEnv ; arr : jbyteArray ; start, l : jsize ; buf : PJByte) ; stdcall;
      GetCharArrayRegion : procedure (env : PJNIEnv ; arr : jcharArray ; start, l : jsize ; buf : PJChar) ; stdcall;
      GetShortArrayRegion : procedure (env : PJNIEnv ; arr : jshortArray ; start, l : jsize ; buf : PJShort) ; stdcall;
      GetIntArrayRegion : procedure (env : PJNIEnv ; arr : jintArray ; start, l : jsize ; buf : PJInt) ; stdcall;
      GetLongArrayRegion : procedure (env : PJNIEnv ; arr : jlongArray ; start, l : jsize ; buf : PJLong) ; stdcall;
      GetFloatArrayRegion : procedure (env : PJNIEnv ; arr : jfloatArray ; start, l : jsize ; buf : PJFloat) ; stdcall;
      GetDoubleArrayRegion : procedure (env : PJNIEnv ; arr : jdoubleArray ; start, l : jsize ; buf : PJDouble) ; stdcall;
      SetBooleanArrayRegion : procedure (env: PJNIEnv; arr :  jbooleanArray; start, len : jsize; buf : PJBoolean) ; stdcall;
      SetByteArrayRegion : procedure (env: PJNIEnv; arr :  jbyteArray; start, len : jsize; buf : PJByte) ; stdcall;
      SetCharArrayRegion : procedure (env: PJNIEnv; arr :  jcharArray; start, len : jsize; buf : PJChar) ; stdcall;
      SetShortArrayRegion : procedure (env: PJNIEnv; arr :  jshortArray; start, len : jsize; buf : PJShort) ; stdcall;
      SetIntArrayRegion : procedure (env: PJNIEnv; arr :  jintArray; start, len : jsize; buf : PJInt) ; stdcall;
      SetLongArrayRegion : procedure (env: PJNIEnv; arr :  jlongArray; start, len : jsize; buf : PJLong) ; stdcall;
      SetFloatArrayRegion : procedure (env: PJNIEnv; arr :  jfloatArray; start, len : jsize; buf : PJFloat) ; stdcall;
      SetDoubleArrayRegion : procedure (env: PJNIEnv; arr :  jdoubleArray; start, len : jsize; buf : PJDouble) ; stdcall;
      RegisterNatives : function ( env: PJNIEnv ; clazz : jclass ; method : PJNINativeMethod; nMethods : jint) : jint ; stdcall;
      UnregisterNatives : function ( env: PJNIEnv ; clazz : jclass) : jint ; stdcall;
      MonitorEnter : function (env: PJniEnv; obj : jobject) : jint ; stdcall;
      MonitorExit : function (env: PJniEnv; obj : jobject) : jint ; stdcall;
      GetJavaVM : function (env: PJNIEnv; vm : PPJavaVM) : jint ; stdcall;
   end;

   JNIEnv_ = packed record
      functions : ^JNINativeInterface_;
      reserved0 : Pointer;
      reserved1 : Array[0..5] of Pointer;
   end;

   JDK1_1InitArgs = packed record
      version : jint;
      properties : ^PChar;
      checkSource, nativeStackSize, javaStackSize, minHeapSize, maxHeapSize, verifyMode : jint;
      classpath : PChar;
      vprintf : function (filePointer : Pointer ; format : PChar ; args : Pointer) : jint ; stdcall;
      exit : procedure(exitCode : jint); stdcall;
      abort : procedure; stdcall;
      enableClassGC : jint;
      enableVerboseGC : jint;
      disableAsyncGC : jint;
      verbose : jint;
      debugging : jboolean;
      debugPort : jint;
  end;

      JDK1_1AttachArgs = packed record
         padding : Pointer;
      end;


   JNIInvokeInterface_ = packed record
      reserved0, reserved1, reserved2 : Pointer;
      DestroyJavaVM : function(vm : PJavaVM) : jint; stdcall;
      AttachCurrentThread : function(vm : PJavaVM ; penv : PPJNIEnv; args : Pointer) : jint; stdcall;
      DetachCurrentThread : function(vm : PJavaVM ; penv : PPJNIEnv; args : Pointer) : jint; stdcall;
   end;

implementation

end.
