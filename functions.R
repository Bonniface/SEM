abbreviate_df_columns <- function(data) {
  # Iterate over each column
  for (col in 1:ncol(data)) {
    # Get the column name
    col_name <- colnames(data)[col]
    
    # Split the column name into words
    words <- strsplit(col_name, " ")[[1]]
    
    # Extract the first letter of each word and combine them
    abbreviation <- paste0(substr(words, 1, 1), collapse = "")
    
    # Rename the column with the abbreviation
    colnames(data)[col] <- abbreviation
  }
  
  return(data)
}
abbreviate_columns <- function(data) {
  # Create a data frame to store the column names
  column_names <- data.frame(
    Previous_Name = colnames(data),
    Abbreviation = character(ncol(data)),
    stringsAsFactors = FALSE
  )
  
  # Iterate over each column
  for (col in 1:ncol(data)) {
    # Get the column name
    col_name <- colnames(data)[col]
    
    # Split the column name into words
    words <- strsplit(col_name, " ")[[1]]
    
    # Extract the first letter of each word and combine them
    abbreviation <- paste0(substr(words, 1, 1), collapse = "")
    
    # Store the abbreviation in the data frame
    column_names$Abbreviation[col] <- abbreviation
    
    # Rename the column with the abbreviation
    colnames(data)[col] <- abbreviation
  }
  
  return(column_names)
}
fillMissingValues <- function(data) {
  for (col in names(data)) {
    if (is.numeric(data[[col]])) {
      # For numerical variables, fill missing values with the mean
      data[[col]][is.na(data[[col]])] <- mean(data[[col]], na.rm = TRUE)
    } else {
      # For character variables, fill missing values with the most frequent value
      mode_value <- names(table(data[[col]]))[which.max(table(data[[col]]))]
      data[[col]][is.na(data[[col]])] <- mode_value
    }
  }
  return(data)
}
