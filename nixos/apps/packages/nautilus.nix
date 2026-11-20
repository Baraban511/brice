{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nautilus # File manager
    ffmpeg-headless # For thumbnail support of videos in Nautilus
    ffmpegthumbnailer # For thumbnail support of videos in Nautilus
    evince # For thumbnail support of pdf in Nautilus
    libgsf # For thumbnail support of opendocuments in Nautilus
    libheif # HEIC image support for Nautilus
    libheif.out # For thumbnail support of HEIC images in Nautilus
  ];
  environment.pathsToLink = [
    "share/thumbnailers"
  ]; # Allow usage of thumbnailers in nautilus
}
