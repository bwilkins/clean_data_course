## Variable descriptions

### File path variables

- `data_location` : data_location describes the local file name of the downloaded zip file.
- `files` : contains the list of paths of all the files extracted from the source zip file.
- `keep_files` : As the original `files` variable contains file paths that are not needed for our analysis, `keep_files` is the list of files with those unnecessary file paths removed. 
- `test_data_point_file`, `test_activity_id_file`, `test_subject_id_file`, `train_data_point_file`, `train_activity_id_file`, `train_subject_id_file`, `feature_names_file`: `activity_names_file` : These all contain a single file path, to better aid reading of table data. Test and training data file paths are needed to be kept separate so that they can be reliably joined together.

### Raw tables

- `feature_map` : The table of column number -to- feature name from the features.txt file.
- `activity_names` : The table containing the mapping from activity id to activity name.
- `test_activity_ids` : The list of activity ids for each individual row of measurement data in the test set.
- `test_subject_ids` : The list of subject ids for each indiviual row of measurement data in the test set.
- `train_activity_ids` : The list of activity ids for each individual row of measurement data in the training set.
- `train_subject_ids` : The list of subject ids for each individual row of measurement data in the training set.

### Composed Data/Tables

- `feature_names` : A character vector that contains the feature names from the feature_map variable, in original order. This is what we use to give the data.frames their column names.
- `test_data_set` : The complete test data set, including subject ids, activity ids and activity names, mapped to the correct measurement row.
- `train_data_set` : The complete training data set, including subject ids, activity ids and activity names, mapped to the correct measurement row.
- `data_set` : The total data set, composed of both the training and test data.frames.

### Extraction Data/Tables

- `interesting_features` : The set of features we are interested in keeping for our final data set
- `columns_to_keep` : The set of columns we want to keep when we subset the total data set. This is also used to reassign column names when appropriate.
- `smaller_data_set` : The result of subsetting `data_set` with `columns_to_keep`.

### Final Data Set

- `agg` : An aggregate data set, containing the mean of each feature we are interested in (see `interesting_features`), grouped by subject id and activity name.
- `final_data_set` : This is the output data set, which is `agg` subset to remove duplicated or invalidated columns, and renamed with correct column names (see `columns_to_keep`). This is written to `tidy_data_set.txt` in the working directory.
