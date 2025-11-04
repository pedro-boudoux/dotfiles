{pkgs, lib, ...}:

{
    programs.zed-editor = {
        enable = true;

        extensions = [
            "nix"
            "toml"
            "lua"
            "basher"
            "darcula-dark"
            "kdl"
            "material-icon-theme"
            "java"
            "typst"
        ];

        extraPackages = [pkgs.nixd];

        userSettings = {
            vim_mode = true;
            icon_theme = "Material Icon Theme";
            theme = {
                mode = "dark";
                light = "default";
                dark = "Darcula Dark";
            };
            ui_font_size = lib.mkForce 16;
            relative_line_numbers = true;
            buffer_font_family = "MartianMono Nerd Font Mono";
            ui_font_family = "MartianMono Nerd Font Mono";
        };
    };
}
