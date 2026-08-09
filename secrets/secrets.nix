let
  Lenovo-Slim-Pro-7 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHZLWSFB3lHTzJ96T12czsPv5DVMU2MFDEABavhdHXb root@Lenovo-Slim-Pro-7";
  Hp-Omen-16-Max = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYJZrO0ObtYp95qf5jbTzgTt7m5lYk/s78Y+u5YnMTz Hp-Omen-16-Max";

in
{
  "colbys-password.age".publicKeys = [ Lenovo-Slim-Pro-7 Hp-Omen-16-Max ];
}
