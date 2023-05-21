{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    slam
  ];

  sysdepends = with pkgs;[
    gurobi
  ];

  rev = "0000000000000000000000000000000000000000";


in

pkgs.RmkDerive {

  name = "r_gurobi";

  version = "${pkgs.gurobi.version}";

  src = with lib; fetchTarball {
    url = "http://packages.gurobi.com/${versions.majorMinor pkgs.gurobi.version}/gurobi${pkgs.gurobi.version}_linux64.tar.gz";
    sha256 = "0vinrqggzswn3skqkp77ayawpga23mybxzyd694zmkd47cxxykp0";
  }+ "/linux64/R/gurobi_10.0-1_R_4.2.3.tar.gz"; #hard coded, but not easy to predict, depends on exact R version and exact gurobi version, but may not correspond to system versions of either

  rev = rev;

  depends = sysdepends ++ Rdepends;
}
