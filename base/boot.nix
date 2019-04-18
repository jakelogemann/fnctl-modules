{ config, lib, pkgs, ... }:

let
  enabled = config.fnctl2.enable;
  staticModules = lib.concatLists [


    [ /* Device Modules */
      "ahci"         # NixOS Default
      "ata_piix"     # ATA Device Support
      "ehci_pci"     # NixOS Default
      "sd_mod"       # SystemD Modules Loader.
      "xhci_pci"     # NixOS Default
      "btusb"        # Bluetooth via USB
      "usbhid"       # USB Input Device.
      "coretemp"     # CPU Temp
    ]


    [ /* Network Modules */
      "br_netfilter"
      "btintel"      # Bluetooth
      "cfg80211"     # 802.11 wireless
      "e1000e"       # Ethernet.
      "iwlwifi"      # WiFi
      "mac80211"     # 802.11 Wireless
      "macvlan"
      "macvtap"
      "tap"
      "tun"
      "veth"
      "virtio_net"
      "vxlan"
    ]

    [ /* Filesystems */
      "btrfs"
      "ext3" "ext4"
      "fuse"
      "cifs"
      "ntfs"
      "ecryptfs"
      "isofs"
      "hfs" "hfsplus"   # Crapple FS.
      "xfs"
    ]

    [ /* Trusted Process Module (TPM) */
      "tpm"
      "tpm_tis"
    ]
  ];

in {
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  config = lib.mkIf enabled {

    hardware.cpu.intel.updateMicrocode = true;
  # boot.kernelPackages = lib.mkForce pkgs.linuxPackages_4_20;
    boot.kernelModules = staticModules;

    /* Disables webcam.
    * TODO: Document this. */
    boot.blacklistedKernelModules = [ "uvcvideo" ];

    boot.kernelParams = [
      # Sets up console colors.
      #               _BG_,                              _FG_                                    BFG
      # "vt.default_red=0xFF,0xBC,0x4F,0xB4,0x56,0xBC,0x4F,0x00,0xA1,0xCF,0x84,0xCA,0x8D,0xB4,0x84,0x68"
      # "vt.default_grn=0xFF,0x55,0xBA,0xBA,0x4D,0x4D,0xB3,0x00,0xA0,0x8F,0xB3,0xCA,0x88,0x93,0xA4,0x68"
      # "vt.default_blu=0xFF,0x58,0x5F,0x58,0xC5,0xBD,0xC5,0x00,0xA8,0xBB,0xAB,0x97,0xBD,0xC7,0xC5,0x68"
    ];

    boot.initrd = {
      network.enable         = true;
      /* remove the fsck that runs at startup. It will always fail to run, stopping
      * your boot until you press */
      checkJournalingFS      = false;
      availableKernelModules = staticModules;
      kernelModules          = staticModules;
    };

    # Enable the Plymouth splash screen
    boot.plymouth = {
      enable = true;
      theme  = "breeze"; # default, can be changed and/or set to an image
    };
  };
}
