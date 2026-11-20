{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wxmaxima
    vscode
    (python3.withPackages (ps:
      with ps; [
        # jupyter
        # notebook
        numpy
        matplotlib
        ipykernel # Nécessaire pour VSCode
        pip
      ]))
  ];
}
