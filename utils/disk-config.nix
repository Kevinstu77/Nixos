{
  disko.devices = {
    disk = {
      my-disk = {
        #replace with name of drive
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {

            Boot = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            Root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];

                subvolumes = {

                  #Root filesystem
                  "/rootfs" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  #home/personal
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  #Nix store
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  #Swap
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    mountOptions = ["noatime" "nodatacow" "nodatasum"];
                    swap = {
                      swapfile.size = "16G";
                    };
                  };

                };
              };
            };
          };
        };
      };
    };
  };
}
