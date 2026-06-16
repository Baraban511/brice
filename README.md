# brice

My Nixos configuration and ricing. It's a work in progress (forever i think).
If you find any bugs or security issues, please reach out to me.


https://github.com/user-attachments/assets/10218ec8-67ab-4316-af46-8a8dbebfef14


## Structure
- [nixos](./nixos): Nix configuration for my machines.
- [bell](./bell): My quickshell configuration.
- [secrets](./secrets): My secrets management configuration.

## To do
- [ ] Rework unsplash wallpaper
- [ ] Remove symbolic links as much as possible
- [ ] Better use of wallust
- [ ] Configure IIO light sensor
- [ ] Use more of hyprland 
- [ ] Better README
- [ ] Bluetooth and wifi over quickshell

+ find new fun things to do
## Installation
```sudo nixos-generate-config --show-hardware-config```
```sudo nixos-rebuild switch --flake /home/barab/brice/```
For it to work, you need an [Unsplash api key](https://unsplash.com/developers).
## Secrets
Secrets are handled by [agenix](https://github.com/ryantm/agenix)

# bell
My quickshell configuration.

```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                                                %%
%%                                                                                                %%
%%                                                                                                %%
%%   %%%%%%%%%%%           %%%%       %%%%%%%%%%%          %%%%        %%%%%%%%%%%                %%
%%   %%%%%%%%%%%%%         %%%%       %%%%%%%%%%%%%        %%%%        %%%%%%%%%%%%               %%
%%   %%%       %%%%       %%%%%%      %%%%      %%%%      %%%%%%       %%%       %%%              %%
%%   %%%       %%%%       %%%%%%%     %%%%      %%%%      %%%%%%%      %%%       %%%              %%
%%   %%%      %%%%       %%%  %%%     %%%%      %%%%     %%%  %%%      %%%     %%%%%              %%
%%   %%%%%%%%%%%%%%     %%%%  %%%%    %%%%      %%%%    %%%%  %%%%     %%%%%%%%%%%%%              %%
%%   %%%       %%%%%    %%%    %%%    %%%%%%%%%%%%%     %%%    %%%     %%%       %%%%%            %%
%%   %%%         %%%%  %%%%%%%%%%%%   %%%%%%%%%%%      %%%%%%%%%%%%    %%%         %%%            %%
%%   %%%         %%%%  %%%%%%%%%%%%%  %%%%   %%%%      %%%%%%%%%%%%%   %%%         %%%            %%
%%   %%%%%%%%%%%%%%%  %%%        %%%  %%%%     %%%    %%%        %%%   %%%%%%%%%%%%%%%   %%%%     %%
%%   %%%%%%%%%%%%%%  %%%%        %%%% %%%%      %%%%  %%%        %%%%  %%%%%%%%%%%%%     %%%%     %%
%%                                                                                                %%
%%                                                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
