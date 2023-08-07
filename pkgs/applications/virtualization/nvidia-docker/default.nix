{ stdenv, lib, fetchFromGitHub, callPackage }:
stdenv.mkDerivation rec {
  pname = "nvidia-docker";
  version = "2.13.0";

  src = fetchFromGitHub {
    owner = "NVIDIA";
    repo = pname;
    rev = "v${version}";
    sha256 = "sPafh2FFj68pHHe9+fKk2PFYhVxp9lZhgpu361GhLfM=";
  };

  buildPhase = ''
    mkdir bin

    cp nvidia-docker bin
    substituteInPlace bin/nvidia-docker --subst-var-by VERSION ${version}
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/nvidia-docker $out/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/NVIDIA/nvidia-docker";
    description = "NVIDIA container runtime for Docker";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ cpcloud ];
  };
}
