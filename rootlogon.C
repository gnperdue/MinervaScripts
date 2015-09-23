{
  std::cout << "Setting up according to $HOME/.rootlogon.C" << std::endl;

  if (gSystem->Getenv("PLOTUTILSROOT")) {
    std::cout << "Configuring for PLOTUTILS for MINERvA " << gSystem->Getenv("MINERVA_RELEASE") << std::endl;

    gInterpreter->AddIncludePath( gSystem->ExpandPathName("$PLOTUTILSROOT") );

    string newpath = string(gROOT->GetMacroPath()) + ":" + string(gSystem->ExpandPathName("$PLOTUTILSROOT")) + "/PlotUtils";
    gROOT->SetMacroPath( newpath.c_str() );

    gSystem->Load( "libCintex.so" );  // needed to process the dictionaries for the objects
    Cintex::Enable();

    gSystem->Load( gSystem->ExpandPathName("$PLOTUTILSROOT/$CMTCONFIG/libplotutils.so") );
  }
  //  if( gSystem->Getenv("ANA_PLOT_DIR") ) {
  //    gInterpreter->AddIncludePath( gSystem->ExpandPathName("$ANA_PLOT_DIR") );
  //    gSystem->Load( gSystem->ExpandPathName("$ANA_PLOT_DIR/lib/libccplotoverlay.so") );
  //    gSystem->Load( gSystem->ExpandPathName("$ANA_PLOT_DIR/lib/libccplotutils.so") );
  //    gSystem->Load( gSystem->ExpandPathName("$ANA_PLOT_DIR/lib/libccacceptance.so") );
  //    gSystem->Load( gSystem->ExpandPathName("$ANA_PLOT_DIR/lib/libccplot2d.so" ) );
  //  }

  gROOT->SetStyle("Plain");

  // Set the size of the default canvas: 600x500 looks almost square.
  gStyle->SetCanvasDefH(500);
  gStyle->SetCanvasDefW(600);
  gStyle->SetCanvasDefX(10);
  gStyle->SetCanvasDefY(10);

  // Borders
  gStyle->SetCanvasBorderMode(0);
  gStyle->SetPadBorderMode(0);

  // Color Scheme - Black & White
  gStyle->SetCanvasColor(0);
  gStyle->SetPalette(1);
  gStyle->SetFrameBorderMode(0);
  gStyle->SetFuncColor(2);
  gStyle->SetAxisColor(1, "xyz");
  gStyle->SetLabelColor(1,"xyz");
  gStyle->SetPadColor(kWhite);
  gStyle->SetStatColor(0);
  gStyle->SetStatTextColor(1);
  gStyle->SetTitleColor(1);
  gStyle->SetTitleTextColor(1);

  // Fonts
  int style_label_font=62;                      // Helvetica, see: http://root.cern.ch/root/html/TAttText.html
  gStyle->SetLabelFont(style_label_font,"xyz");
  gStyle->SetLabelSize(0.045,"xyz");
  gStyle->SetLabelOffset(0.015,"xyz");
  gStyle->SetStatFont(style_label_font);
  gStyle->SetTitleFont(style_label_font,"xyz"); // axis titles
  gStyle->SetTitleFont(style_label_font,"h");   // histogram title
  gStyle->SetTitleSize(0.05,"xyz");             // axis titles
  gStyle->SetTitleSize(0.05,"h");               // histogram title
  gStyle->SetTitleOffset(1.15,"x");
  gStyle->SetTitleOffset(1.15,"y");
  gStyle->SetStripDecimals(kFALSE);             // if we have 1.5 do not set 1.0 -> 1
  gStyle->SetTitleX(0.12);                      // spot where histogram title goes
  gStyle->SetTitleW(0.9);                       // width computed so that title is centered
  TGaxis::SetMaxDigits(2);                      // restrict the number of digits in labels

  // Set tick marks and turn off grids.
  gStyle->SetNdivisions(510,"xyz");
  gStyle->SetPadTickX(1);
  gStyle->SetPadTickY(1);
  gStyle->SetTickLength(0.02,"xyz");
  gStyle->SetPadGridX(0);
  gStyle->SetPadGridY(0);

  // Line Widths
  gStyle->SetFrameLineWidth(2);
  gStyle->SetLineWidth(2);
  gStyle->SetHistLineWidth(2);

  // Marker Styles
  gStyle->SetMarkerStyle(20);

  // Stats
  gStyle->SetOptStat(0000);
  gStyle->SetOptFit(0000);

  // Margins
  gStyle->SetPadTopMargin(0.15);
  gStyle->SetPadBottomMargin(0.15);
  gStyle->SetPadLeftMargin(0.15);
  gStyle->SetPadRightMargin(0.15);

  // Titles
  gStyle->SetOptTitle(1);  // 0 for off
  gStyle->SetTitleBorderSize(0);

  // Errors
  gStyle->SetEndErrorSize(3);
  gStyle->SetErrorX(0.5);

  // Finally...
  gROOT->ForceStyle();
}

