{R, pkgs}:
let

  Rdepends = with pkgs.rPackages; [
  Rcpp
  RcppArmadillo
  ddalpha
  ];

  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in
RmkDerive {

  name = "r-curveDepth";

  version = "0.1.0.8";

  src = pkgs.fetchurl {
  urls = ["https://cran.r-project.org/src/contrib/curveDepth_0.1.0.8.tar.gz"];
    sha256 =  "0291adf4qch0z4h8rlk7nzgrn5yp6hfqjnj59nkrpg50vli4nlf4";
  };

  depends = sysdepends ++ Rdepends;
}
