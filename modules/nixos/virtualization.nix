{pkgs, ...}: {
  programs.dconf.enable = true;
  programs.virt-manager.enable = true;

  users.users.ai.extraGroups = ["libvirtd"];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
