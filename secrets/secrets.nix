let
  Lenovo-Slim-Pro-7 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHZLWSFB3lHTzJ96T12czsPv5DVMU2MFDEABavhdHXb root@Lenovo-Slim-Pro-7";
in
{
  "colbys-password.age".publicKeys = [ Lenovo-Slim-Pro-7 ];
}
