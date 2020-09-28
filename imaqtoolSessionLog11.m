vid = videoinput('winvideo', 1, 'RGB24_640x480');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

preview(vid);

start(vid);

stoppreview(vid);

preview(vid);

start(vid);

stoppreview(vid);

preview(vid);

start(vid);

stoppreview(vid);

preview(vid);

vid.FramesPerTrigger = Inf;

start(vid);

stoppreview(vid);

stop(vid);

