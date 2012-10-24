; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{C4DF9B45-7164-4EB1-AEAD-CE1F014CA161}
AppName=SimplyVBUnit 4.0
AppVerName=SimplyVBUnit 4.0
AppPublisher=Kelly Ethridge
AppPublisherURL=https://sourceforge.net/projects/simplyvbunit/
AppSupportURL=https://sourceforge.net/projects/simplyvbunit/
AppUpdatesURL=https://sourceforge.net/projects/simplyvbunit/
DefaultDirName={pf}\SimplyVBUnit 4.0
DefaultGroupName=SimplyVBUnit 4.0
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename=SimplyVBUnitSetup-4.0
Compression=lzma
SolidCompression=yes

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Files]
Source: Compiled\SimplyVBUnit.Framework.dll; DestDir: {sys}; Flags: regserver
Source: Compiled\SimplyVBUnit.Component.ocx; DestDir: {sys}; Flags: regserver
Source: ..\TypeLibrary\SimplyVBUnitType.tlb; DestDir: {sys}; Flags: regtypelib
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: ..\Source\Projects\frmTestRunner.frm; DestDir: {code:GetProjectsDir|{app}}; Languages: 
Source: ..\Source\Projects\UnitTestProject.vbp; DestDir: {code:GetProjectsDir|{app}}
Source: readme.txt; DestDir: {app}; DestName: readme.txt; Flags: isreadme
Source: LICENSE.txt; DestDir: {app}; DestName LICENSE.txt;

[Icons]
Name: {group}\{cm:UninstallProgram,SimplyVBUnit}; Filename: {uninstallexe}

[Code]
var
  TemplateDir: String;

function GetClassesDir(S: String): String;
begin
  RegQueryStringValue(HKCU,'Software\Microsoft\Visual Basic\6.0', 'TemplatesDirectory', TemplateDir);
  Result := TemplateDir + '\Classes\';
end;

function GetProjectsDir(S: String): String;
begin
  RegQueryStringValue(HKCU,'Software\Microsoft\Visual Basic\6.0', 'TemplatesDirectory', TemplateDir);
  Result := (TemplateDir + '\Projects');
end;
