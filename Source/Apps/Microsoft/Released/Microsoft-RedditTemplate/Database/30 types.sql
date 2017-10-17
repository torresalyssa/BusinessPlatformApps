-- Drop types
-- would prefer not to use sys tables, but INFORMATION_SCHEMA views don't seem to have what we need
IF EXISTS(SELECT * FROM SYS.TYPES WHERE NAME='DocumentIdTable' AND IS_USER_DEFINED=1)
	DROP TYPE reddit.DocumentIdTable;
IF EXISTS(SELECT * FROM SYS.TYPES WHERE NAME='DOC_ID' AND IS_USER_DEFINED=1)
	DROP TYPE reddit.DOC_ID;

-- Create a specific datatype for document IDs
IF NOT EXISTS(SELECT * FROM SYS.TYPES WHERE NAME='DOC_ID' AND IS_USER_DEFINED=1)
BEGIN
	EXEC('CREATE TYPE [reddit].[DOC_ID] FROM VARCHAR(64) NOT NULL');
END

IF NOT EXISTS(SELECT * FROM SYS.TYPES WHERE NAME='DocumentIdTable' AND IS_USER_DEFINED=1)
BEGIN
	EXEC('CREATE TYPE [reddit].[DocumentIdTable] AS TABLE ([id] [reddit].[DOC_ID] NOT NULL)');
END
