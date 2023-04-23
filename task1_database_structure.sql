 -- Creating organizations information
CREATE TABLE organizations (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
) DEFAULT CHARSET=utf8;

 -- Creating user information
CREATE TABLE users (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(100) NOT NULL,
  password VARCHAR(64) NOT NULL, -- SHA-256, the hashed password will be 64 characters long
  email VARCHAR(100) NOT NULL
) DEFAULT CHARSET=utf8;

 -- Creating modules information
CREATE TABLE modules (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL
) DEFAULT CHARSET=utf8;

-- creating organizations the user has access, relation table 
CREATE TABLE user_organization (
  user_id INT UNSIGNED NOT NULL,
  organization_id INT UNSIGNED NOT NULL,
  PRIMARY KEY ( user_id, organization_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, 
  FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

-- creating modules the user has access, relation table 
CREATE TABLE user_module (
  user_id INT UNSIGNED NOT NULL,
  module_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, module_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (module_id) REFERENCES modules(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8;

-- Add indexes to improve query performance
CREATE INDEX idx_users_id ON users (id);
CREATE INDEX idx_organizations_id ON organizations (id);
CREATE INDEX idx_modules_id ON modules (id);
CREATE INDEX idx_user_organization_user_organization_id ON user_organization (organization_id, user_id);
CREATE INDEX idx_user_module_user_module_id ON user_module (user_id, module_id);
/*

In this task I have used MySQL database for table creation as from the interview I have noticed that this technology is used.

I will list the following steps to perform this task:

  1. Created four main tables: users, organizations, modules, and two access tables as user_organization and user_module.
     The users table stores all the users and their IDs, along with email and password for authentication purposes. 
     The organizations table stores all the organizations and their IDs.  
     The modules table stores all the available modules and their IDs.
     The user_organization table creates a many-to-many relationship between users and organizations, where each user can have access to multiple organizations and each organization can be accessed by multiple users. 
     The user_module table creates a many-to-many relationship between users and modules, where each user can have access to multiple modules and each module can be accessed by multiple users.

  2. The FOREIGN KEY constraints ensure that the IDs stored in the access tables reference valid entries in their corresponding tables.
     We can easily add more records for future growth by the structure which is made.

  3. Indexes should be created for Primary Keys in the main tables and also for the foreign key which are used in the relation tables. 
     I have used composite index for table user_organization and user_model which can be handled by queries to speed the searching and also for support queries that search for all users associated with a particular organisations or modules. 

  4. Used ON DELETE CASCADE parameter, it means that if a record in the main table is deleted, all the related records in the relation table will also be deleted automatically. 
     As this parameter is not set we need firstly delete the rows from the relation table and after from the main table which I think is time consuming.
     Like an example could be if you delete a record from the users table with the primary key value of 7, then all the corresponding records in the user_orgnanization and user module table that have an user_id value of 7 will also be deleted automatically.

  5. Used “UNSIGNED” keyword to define ID columns as a non-negative value which can be usefull for some performance benefits.
  
*/
