let
  colbyslim = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILTBz7V/hSj4BGu4Li2gv6bRI9voy2unjpThNom5lb3P root@colbyslim";
in
{
  "colbys-password.age".publicKeys = [ colbyslim ];
}
