# prosodic_extraction
A set of scripts for prosodic analysis

It includes:

1. extracts_f0_from_points.praat Works for all the files in a folder. Writes in a txt point labels, time of point and F0 on point.&nbsp;Needs a .wav and textgrid with at least 1 point tier. The output is a tab separated file. The format can be wide (all the point from each file in one line) or long (a line by point).

2. extracts_f0_from_points_and_corresponding_label_in_interval_tier</a>:&nbsp;Works for all the files in a folder. Writes in a txt point labels, time of point,&nbsp;F0 on point and label in a matching interval tier.&nbsp;Needs a .wav and textgrid with at least 1 point tier and 1 interval tier. The output is a tab separated file.

3. prosodic_data_extraction.praat: This script finds duration, intensity and 3 F0 (Hz and st) values for each non-empty interval it finds in the tier. It can also extract the corresponding labels for each interval. Then it saves the values in a tab-separated txt, which you can easily open with Excel.

4. ongoing. Extracts entire F0 track for all files in a folder. It will extract the same number of points always, for example 30 points by word. checkds duration in order to do it.(Use it to build GAMM models in R). wide format all file. Long format a line by interval.