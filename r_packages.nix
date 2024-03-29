{pkgs}:
with pkgs.rPackages; [#All  R packages that I use in my code.
        #SDMs and CLMS
        gradientforest
        #(pkgs.callPackage ./packages/multabund.nix {myRPackages = myRPackages;})
        Rborist
        ranger

        #personal packages
        phil_rutilities
        phil_rmethods
        rphildyerphd
        gfbootstrap
        castcluster

        #Image processing
        EBImage

        #provenance
        targets
        crew
        crew_cluster
        rdtLite
        provSummarizeR
        provViz
        provParseR
        drake
        visNetwork
        networkD3
        semver

        #Maths and statistics
        # emmix 
        # EMMIXcskew
        #(pkgs.callPackage ./packages/emmix_mfa.nix {})
        mclust
        mixtools
        NbClust
        vegan
        fields
        anocva
        kernlab
        WGCNA
        apcluster
        tnet
        interp
        akima
        # mvpart
        #clusterCrit #currently broken
        Hotelling
        ICSNP
        rrcov
        #clustsig # currently broken
        Rfast
        fpc
        indicspecies

        ## Publishing, static and interactive
        shiny
        DT
        shinythemes
        shinyWidgets
        magick
        markdown
        httpgd
        bib2df


        #data sources
        sdmpredictors
        wdpar # makes use of insecure PhantomJS, nix no longer supports it.
        #robis#removed from CRAN
        #seaaroundus #removed from CRAN
        ncdf4
        mapdata
        planktonr

        #simulated data
        coenocliner
        coenoflex
        MixSim

        #Plotting
        ggthemes
        ggraph
        # maptools
        ggplot2
        ellipse
        ggcorrplot
        ggforce
        gganimate
        plotly
        RColorBrewer
        R_devices
        quantreg
        tmap
        ascii
        ggh4x
        fitdistrplus

        #Data manipulation
        tidyverse
        data_table
        sf
        sp
        # rgeos
        rlist
        lutz
        lubridate
        # ClimateOperators
        raster
        terra
        stars


        #Parallel processing
        foreach
        doParallel
        doRNG
        future
        future_apply
        future_callr
        future_batchtools
        furrr
        doFuture
        randomForestSRC
        snow
        SOAR
        bigmemory
        GPUmatrix
        float #float32 matricies are extremely fast on GPU
        torch
        tensorflow
        sqldf
        ff
        clustermq 
        (Rmpi.overrideDerivation(attrs:{
          configureFlags  = ["--with-Rmpi-include=${pkgs.openmpi}/include"
              "--with-Rmpi-libpath=${pkgs.openmpi}/lib"
              "--with-Rmpi-type=OPENMPI"];
        }))
        #doMPI #installation breaks, do to issues in mpi setup,
                #possibly because R is in a container but
                #nixos-update is called from the host OS
                #used install.packages()

        #Reproducible research
        R_cache #reduce re-evaluation of function calls
        archivist #store results, could be important for tracking outputs in JSON
        packrat
        renv
        callr

        # Storage formats
        qs
        fst
        feather
        jsonlite
        yaml
        mongolite

        #Support tools
        devtools
        roxygen2
        rmarkdown
        knitr
        microbenchmark
        bench
        assertthat
        pryr
        profvis
        proftools
        profr
        caTools
        qwraps2
        skimr
        janitor
        stringr
        here
        formatR
        r_import

        #vim support
        nvimcom
        languageserver
        lintr

        #Fixing nixpkgs
        fftwtools

        ##fixing RcppArmadillo
        RcppArmadillo

        #Prioritizr
        lwgeom
        rfishbase
        readr
        kader
        # rgdal
        exactextractr
        # VoCC
        prioritizr
        prioritizrdata
        # gurobi
        slam
        rnaturalearth
        patchwork
        spatstat
        mapview
        remotes
        gridExtra
        gridGraphics
        lpsymphony
        #Rsymphony
        units
        reldist
        codetools

]
