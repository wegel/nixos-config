# initially from https://github.com/gvolpe/nix-config/blob/6feb7e4f47e74a8e3befd2efb423d9232f522ccd/home/programs/browsers/firefox.nix
{ pkgs, lib, systemConfig, inputs, ... }:

let
  inherit (systemConfig) hidpi;

  extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
    bitwarden
    ublock-origin
    vimium
    adsum-notabs
    darkreader
    # auto-accepts cookies, use only with privacy-badger & ublock-origin
    i-dont-care-about-cookies
    link-cleaner
    privacy-badger
    unpaywall
  ];

  userChrome = ''
    #identity-box, #tabbrowser-tabs, #TabsToolbar {
        visibility: collapse !important;
    }

    /* "Auto-hide" address bar unless focused (e.g. Ctrl-L) or tab bar is hovered. */
    :root {
        --address-bar-height: 40px;
        --browser-offset: calc(-1 * (var(--address-bar-height) + 1px));
    }
    #navigator-toolbox-background {
        position: absolute !important;;
    }
    #navigator-toolbox-background ~ #browser {
        margin-top: var(--browser-offset) !important;
    }
    #navigator-toolbox-background:hover, #navigator-toolbox-background:focus-within {
        z-index: 9001 !important;
    }
  '';

  # DPI settings
  dpiSettings = {
    "layout.css.devPixelsPerPx" = if hidpi then "-1.0" else "0.7";
  };

  # ~/.mozilla/firefox/PROFILE_NAME/prefs.js | user.js
  settings = {
    "app.normandy.first_run" = false;
    "app.shield.optoutstudies.enabled" = false;

    # disable updates (pretty pointless with nix)
    "app.update.channel" = "default";

    "browser.contentblocking.category" = "standard"; # "strict"
    "browser.ctrlTab.recentlyUsedOrder" = false;

    "browser.download.useDownloadDir" = false;
    "browser.download.viewableInternally.typeWasRegistered.svg" = true;
    "browser.download.viewableInternally.typeWasRegistered.webp" = true;
    "browser.download.viewableInternally.typeWasRegistered.xml" = true;

    #"browser.link.open_newwindow" = true;

    "browser.search.region" = "CA";
    "browser.search.widget.inNavBar" = true;

    "browser.shell.checkDefaultBrowser" = false;
    "browser.startup.homepage" = "about:blank";
    "browser.tabs.loadInBackground" = true;
    "browser.urlbar.placeholderName" = "Google";
    "browser.urlbar.showSearchSuggestionsFirst" = false;

    # disable all the annoying quick actions
    "browser.urlbar.quickactions.enabled" = false;
    "browser.urlbar.quickactions.showPrefs" = false;
    "browser.urlbar.shortcuts.quickactions" = false;
    "browser.urlbar.suggest.quickactions" = false;

    "distribution.searchplugins.defaultLocale" = "en-US";

    "doh-rollout.balrog-migration-done" = true;
    "doh-rollout.doneFirstRun" = true;

    "dom.forms.autocomplete.formautofill" = false;

    "general.autoScroll" = true;
    "general.useragent.locale" = "en-US";

    "extensions.activeThemeID" = "catppuccin-mocha-blue";

    "extensions.extensions.activeThemeID" = "catppuccin-mocha-blue";
    "extensions.update.enabled" = false;
    "extensions.webcompat.enable_picture_in_picture_overrides" = true;
    "extensions.webcompat.enable_shims" = true;
    "extensions.webcompat.perform_injections" = true;
    "extensions.webcompat.perform_ua_overrides" = true;

    "print.print_footerleft" = "";
    "print.print_footerright" = "";
    "print.print_headerleft" = "";
    "print.print_headerright" = "";

    "privacy.donottrackheader.enabled" = true;

    # Yubikey
    "security.webauth.u2f" = true;
    "security.webauth.webauthn" = true;
    "security.webauth.webauthn_enable_softtoken" = true;
    "security.webauth.webauthn_enable_usbtoken" = true;

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };
in
{
  programs.firefox = {
    enable = true;
    #package = pkgs.firefox;
    package = pkgs.firefox.override {
      cfg = {
        extensions = [
          "uBlock0@raymondhill.net"
          "vimium@philc.ca"
          "adsum-notabs@adsumnetworks.net"
          "darkreader@darkreader.org"
          "i-dont-care-about-cookies@frankgoossens.be"
          "link-cleaner@link-cleaner.github.io"
          "privacy-badger@eff.org"
          "unpaywall@unpaywall.org"
        ];
      };
    };

    profiles = {
      main = {
        id = 0;
        isDefault = true;
        inherit extensions settings userChrome;
      };

      comm = {
        id = 1;
        inherit extensions settings userChrome;
      };
    };
  };
}
