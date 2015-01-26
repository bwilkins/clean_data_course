library(httr)

select <- function(selector, li) {
  li[regexec(selector, li) > -1]
}

ignore <- function(selector, li) {
  li[regexec(selector, li) == -1]
}

data_location <- 'source_data.zip'

# Ignoring common case where we've already downloaded the file
try(GET('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
        write_disk(data_location, overwrite = FALSE)))

files <- unzip(data_location)

#filter unwanted/unneeded files from list
keep_files <- ignore('Inertial|README', files)

# grab useful files for later
test_data_point_file <- select('X_test', keep_files)
test_activity_id_file <- select('y_test', keep_files)
test_subject_id_file <- select('subject_test', keep_files)

train_data_point_file <- select('X_train', keep_files)
train_activity_id_file <- select('y_train', keep_files)
train_subject_id_file <- select('subject_train', keep_files)

feature_names_file <- select('features.txt', keep_files)
activity_names_file <- select('activity_labels.txt', keep_files)


# Load in data
feature_map <- read.table(feature_names_file, sep=' ', as.is=TRUE)
feature_names <- feature_map[,2]

activity_names <- read.table(activity_names_file, as.is=TRUE, col.names=c('activity_id', 'activity_name'))

test_activity_ids <- read.table(test_activity_id_file, col.names='activity_id')
test_subject_ids <- read.table(test_subject_id_file, col.names='subject_id')

# create test data set
test_data_set <- read.table(test_data_point_file)
names(test_data_set) <- feature_names
test_data_set <- cbind(test_subject_ids, test_data_set)
test_data_set <- cbind(test_activity_ids, test_data_set)
test_data_set <- merge(activity_names, test_data_set, by='activity_id')

# create training data set
train_activity_ids <- read.table(train_activity_id_file, col.names='activity_id')
train_subject_ids <- read.table(train_subject_id_file, col.names='subject_id')

train_data_set <- read.table(train_data_point_file)
names(train_data_set) <- feature_names
train_data_set <- cbind(train_subject_ids, train_data_set)
train_data_set <- cbind(train_activity_ids, train_data_set)
train_data_set <- merge(activity_names, train_data_set, by='activity_id')

# join the two data sets together
data_set <- rbind(test_data_set, train_data_set)


# select the features we want to keep
interesting_features <- select('mean[(][)]|std[(][)]', feature_names)
columns_to_keep <- append(c('subject_id', 'activity_name'), interesting_features)

# create a smaller data set with only the features we're interested in
smaller_data_set <- subset(data_set, select=columns_to_keep)

# create our final data set of averages per subject and activity
agg <- aggregate(smaller_data_set, list(smaller_data_set$subject_id, smaller_data_set$activity_name), mean)
final_data_set <- subset(agg, select=append(c('Group.1', 'Group.2'), interesting_features))
names(final_data_set) <- columns_to_keep

write.table(final_data_set, 'tidy_data_set.txt', row.names=FALSE)