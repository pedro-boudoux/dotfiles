{ pkgs, lib, ... }:

let
  inherit (pkgs) firefox;
in
{
  programs.firefox = {
    enable = true;
    package = firefox;

    preferences = {
      "accessibility.typeaheadfind.flashBar" = 0;
      "accessibility.warn_on_browsewithcaret" = false;
      "browser.bookmarks.defaultLocation" = "z9VSVJOm97BU";
      "browser.bookmarks.showMobileBookmarks" = false;
      "browser.contentblocking.category" = "standard";
      "browser.download.lastDir" = "/home/pedro/Downloads";
      "browser.download.panel.shown" = true;
      "browser.eme.ui.firstContentShown" = true;
      "browser.engagement.ctrlTab.has-used" = true;
      "browser.engagement.downloads-button.has-used" = true;
      "browser.engagement.fxa-toolbar-menu-button.has-used" = true;
      "browser.engagement.sidebar-button.has-used" = true;
      "browser.firefox-view.view-count" = 1;
      "browser.migration.version" = 163;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.showSearch" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.enabled" = false;
      "browser.rights.3.shown" = true;
      "browser.search.region" = "CA";
      "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;
      "browser.shell.mostRecentDefaultPromptSeen" = "1764983219";
      "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
      "browser.theme.toolbar-theme" = 0;
      "browser.toolbars.bookmarks.visibility" = "always";
      "browser.urlbar.placeholderName" = "Google";
      "browser.urlbar.placeholderName.private" = "Google";
      "doh-rollout.doneFirstRun" = true;
      "doh-rollout.home-region" = "CA";
      "doh-rollout.skipHeuristicsCheck" = true;
      "dom.forms.autocomplete.formautofill" = true;
      "extensions.formautofill.addresses.enabled" = false;
      "extensions.pictureinpicture.enable_picture_in_picture_overrides" = true;
      "findbar.entireword" = true;
      "layout.css.prefers-color-scheme.content-override" = 0;
      "media.eme.enabled" = true;
      "middlemouse.paste" = false;
      "network.dns.disablePrefetch" = true;
      "network.http.speculative-parallel-limit" = 0;
      "network.prefetch-next" = false;
      "pdfjs.enableAltText" = true;
      "pdfjs.enabledCache.state" = true;
      "places.database.lastMaintenance" = 1769568379;
      "print.printer_Mozilla_Save_to_PDF.print_orientation" = 0;
      "print_printer" = "Mozilla Save to PDF";
      "privacy.bounceTrackingProtection.hasMigratedUserActivationData" = true;
      "privacy.clearOnShutdown_v2.formdata" = true;
      "privacy.purge_trackers.date_in_cookie_database" = "0";
      "privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3" = true;
      "privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs" = true;
      "privacy.userContext.enabled" = true;
      "privacy.userContext.ui.enabled" = true;
      "screenshots.browser.component.last-saved-method" = "copy";
      "sidebar.main.tools" = "aichat,syncedtabs,history,bookmarks";
      "sidebar.new-sidebar.has-used" = true;
      "sidebar.notification.badge.aichat" = true;
      "sidebar.old-sidebar.has-used" = true;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
      "sidebar.visibility" = "hide-sidebar";
    };

    search = {
      default = "Google";
      engines = {
        "Google" = {
          urls = [{
            template = "https://www.google.com/search";
            params = { q = "search" };
          }];
          icon = "${pkgs.firefox}/share/pixmaps/firefox/default.png";
          definedAliases = [ "@g" ];
        };
        "Bing" = {
          urls = [{
            template = "https://www.bing.com/search";
            params = { q = "search" };
          }];
          definedAliases = [ "@b" ];
        };
        "DuckDuckGo" = {
          urls = [{
            template = "https://duckduckgo.com/";
            params = { q = "search" };
          }];
          definedAliases = [ "@d" ];
        };
        "Wikipedia (en)" = {
          urls = [{
            template = "https://en.wikipedia.org/wiki/Special:Search";
            params = { search = "search" };
          }];
          definedAliases = [ "@w" ];
        };
      };
    };
  };
}
