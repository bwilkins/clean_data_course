## How the script works

The script starts off by downloading the source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and saving it locally as source_data.zip. If you already have the data downloaded as source_data.zip, it will skip this step.

I've chosen to filter filenames from the output of unzip, rather than hardcode locations.

After extracting the data from the source zip, it will then proceed to compose feature names and compose the test and training data sets separately, as to correctly align activity and subject identifiers.

The data sets are then concatenated into one big data set, which is then filtered down to contain only the subjects, activities, and mean() and std() measurements, creating a smaller data set.

From the smaller data set, an aggregated mean is calculated, grouped by subject id and activity name. After subsetting and renaming the columns, this is our final data set.

The final data set is then written out to a file named tidy_data_set.txt


