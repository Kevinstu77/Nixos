let
  Lenovo_Slim_Pro_7 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHZLWSFB3lHTzJ96T12czsPv5DVMU2MFDEABavhdHXb root@Lenovo-Slim-Pro-7";
  Hp_Omen_16_Max = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHibrJXn5hgl0GoP7MLkLHoCaFiehsbMd3zKuPXk/hmU root@Hp-Omen-16-Max";

  # 💡 Paste the exact text from running: cat ~/.ssh/id_ed25519.pub
  colbys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARUesxzL/8nfVaEjnimgT42wOL1tf/2vytQ0SdZgI38 Hp-Omen-16-Max";
in
{
  # 💡 Add 'colbys' to the list so you can edit the file locally
  "colbys-password.age".publicKeys = [ Lenovo_Slim_Pro_7 Hp_Omen_16_Max colbys ];
}
