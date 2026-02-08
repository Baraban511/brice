{
  # See about:policies
  ExtensionUpdate = true;
  ExtensionSettings =
    # You can find the extension ID in the URL of the addon page;
    # Check about:support for extension UUID.
    # Valid strings for installation_mode are "allowed", "blocked",
    # "force_installed" and "normal_installed".
    let
      NewExt = ID: UUID: {
        "${UUID}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${ID}/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    in
      # The // operator merges all of these sets into a single set
      NewExt "ublock-origin" "uBlock0@raymondhill.net"
      // NewExt "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack"
      // NewExt "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}"
      // NewExt "svg-gobbler" "{7962ff4a-5985-4cf2-9777-4bb642ad05b8}"
      // NewExt "dictionnaire-français1" "fr-dicollecte@dictionaries.addons.mozilla.org"
      # // NewExt "private-grammar-checker-harper" "harper@writewithharper.com"
      // {"*".installation_mode = "blocked";};
  # Configure Search engines
  SearchEngines = {
    Default = "Google";
    DefaultPrivate = "Google";
    Remove = [
      "DuckDuckGo"
      "Bing"
      "Qwant"
    ];
    Add = [
      {
        Name = "NixOS Packages";
        Alias = "@np";
        Description = "Search in NixOS Packages";
        Method = "GET";
        IconURL = "https://search.nixos.org/favicon.png";
        URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
      }
      {
        Name = "NixOS Options";
        Alias = "@no";
        Description = "Search in NixOS Options";
        Method = "GET";
        IconURL = "https://search.nixos.org/favicon.png";
        URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
      }
    ];
  };

  # Configure Bookmarks
  NoDefaultBookmarks = true;
  Bookmarks = [
    {
      Title = "Github";
      URL = "https://github.com";
      Favicon = "https://github.com/favicon.ico";
      Placement = "toolbar";
    }
  ];

  # Privacy settings
  DisableTelemetry = true;
  HttpsOnlyMode = "enabled";
  PostQuantumKeyAgreementEnabled = true;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
    Category = "strict";
  };

  # Configure Firefox suggest
  SearchSuggestEnabled = false;
  FirefoxSuggest = {
    WebSuggestions = true;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
    Locked = true;
  };

  # Configure Forms and Autofills
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  DisableFormHistory = true;
  OfferToSaveLogins = false;

  # Disable certain features
  DisablePocket = true;
  DisableSetDesktopBackground = true;
  PasswordManagerEnabled = false;

  # Configure the homepage
  NewTabPage = true;
  Homepage = {
    URL = "about:home";
    Locked = true;
    StartPage = "previous-session";
  };
  FirefoxHome = {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    Stories = false;
    SponsoredPocket = false;
    SponsoredStories = false;
    Snippets = false;
    Locked = true;
  };

  # App update behavior
  DisableAppUpdate = true;

  # Printing behavior
  PrintingEnabled = true;
  UseSystemPrintDialog = false;

  # Skip unnecessary things
  DontCheckDefaultBrowser = true;
  SkipTermsOfUse = true;

  # Enable Picture-in-Picture
  PictureInPicture.Enabled = true;
  PictureInPicture.Locked = true;

  # DNS Prefetching
  NetworkPrediction = true;

  # Configure appearance of the browser
  DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "newtab"
  DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
  SearchBar = "unified"; # alternative: "separate"
  ShowHomeButton = false;

  DefaultDownloadDirectory = "~/";
  PrimaryPassword = false;
  CaptivePortal = true;
  DNSOverHTTPS = {
    Enabled = true;
    ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
    Fallback = true;
    Locked = true;
  };
}
