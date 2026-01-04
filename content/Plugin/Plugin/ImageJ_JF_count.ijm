run("Close All");
analyzeVideo();
cleanUp();


function cleanUp() {
    requires("1.30e");
    if (isOpen("Results")) {
         selectWindow("Results"); 
         run("Close" );
    {
    if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" );
    }
    while (nImages()>0) {
          selectImage(nImages());  
          run("Close");
    }
}

function analyzeVideo() {

run("Movie (FFMPEG)...", "choose= mydir use_virtual_stack first_frame=0 last_frame=-1");
if (isOpen(1)) {
	mydir = getDir("image");
	Imgname1 = getTitle();
	run("Duplicate...", "ignore duplicate");
	
	run("8-bit");
	
	setAutoThreshold("Li");
	setOption("BlackBackground", true);
	run("Convert to Mask", "method=Li background=Light calculate black");
	
	run("Fill Holes","stack");
	Erode_count = 3;
	Dilate_count = 2;
	
	for (i = 0; i < Erode_count; i++) {
	run("Erode","stack");
	}
	
	for (i = 0; i < Dilate_count; i++) {
	run("Dilate","stack");
	}
	
	run("Analyze Particles...", "size=50000-Infinity display summarize stack");
	Imgname2 = getTitle();
	selectWindow("Summary of " + Imgname2);
	saveAs("txt", mydir +File.separator+ Imgname1 + ".txt");
	run("Close");	
	
		selectWindow("Results");
		Plot.create("Plot of Results", "x", "Area");
		Plot.add("Line", Table.getColumn("Area", "Results"));
		Plot.setStyle(0, "blue,#a0a0ff,1.0,Line");

}

}

