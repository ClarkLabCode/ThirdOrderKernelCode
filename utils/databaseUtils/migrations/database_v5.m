% We're changing the 'comments' field in the fly table to 
% We're adding the 'pmtVoltage' field to stimulusPresentation
% Adding expression system table
% Adding expressionSystemFlyJoin to join the two
% Added 6/7/2016
conn = connectToDatabase;

%% New comments column in fly table
FlyBackupTableSQLQuery = ['CREATE TABLE flyBackup ('...
    'flyId INTEGER PRIMARY KEY,'...
    'relativePath TEXT,'...
    'genotype TEXT,'...
    'cellType TEXT,'...
    'fluorescentProtein INT,'...
    'surgeon TEXT,'...
    'eye TEXT,'...
    'condition INT,'...
    'behaviorId TEXT UNIQUE,'...
    'overallComments TEXT)']; % new column

exec(conn, FlyBackupTableSQLQuery)

FlyBackupInsertCall = ...
    ['INSERT INTO flyBackup '...
        '(flyId, '...
        'relativePath, '...
        'genotype, '...
        'cellType, '...
        'fluorescentProtein, '...
        'surgeon, '...
        'eye, '...
        'condition, '...
        'behaviorId, '...
        'overallComments) '...
    'SELECT '...
        'flyId, '...'
        'relativePath, '...
        'genotype, '...
        'cellType, '...
        'fluorescentProtein, '...
        'surgeon, '...
        'eye, '...
        'condition, '...
        'behaviorId, '...
        'comments '...
    'FROM fly'];

exec(conn, FlyBackupInsertCall)

FlyDropCall = 'DROP TABLE fly';

exec(conn, FlyDropCall)

FlyBackupRenameCall = 'ALTER TABLE flyBackup RENAME TO fly';

exec(conn, FlyBackupRenameCall)
