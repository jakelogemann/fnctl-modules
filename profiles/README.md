NixOS Profiles
==============

Contains several *_partial_* NixOS configuration fragments for inclusion in
host configurations. These are mainly useful as a conveinience when
bootstrapping a VM, ISO or even new host.

> In some cases, it may be desirable to take advantage of commonly-used,
> predefined configurations provided by nixpkgs, but different from those
> that come as default. This is a role fulfilled by NixOS's Profiles, which
> come as files living in `<nixpkgs/nixos/modules/profiles>`. That is to say,
> expected usage is to add them to the imports list of your
> `/etc/configuration.nix` as such:
>
> ~~~nix
> imports = [
>  <path/to/modules/profiles/profile-name.nix>
> ];
> ~~~
>
> Even if some of these profiles seem only useful in the context of install
> media, many are actually intended to be used in real installs.
>
> -- [_NixOS's manual (Ch 31. "Profiles")_][nixos-profiles]:


[nixos-profiles]: https://nixos.org/nixos/manual/index.html#ch-profiles
