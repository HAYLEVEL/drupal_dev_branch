# Plan to Launch SQL Instance with Existing Backup on GCP

---

## 1. Prepare Your Backup File

- Ensure your backup file is in `.sql` format or a compatible compressed format (`.gz`, `.zip`, `.tar`).
- If the backup is on your local system, upload it to a Google Cloud Storage (GCS) bucket for easier restoration.

---

## 2. Create a Google Cloud Storage Bucket (if needed)

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Navigate to **Cloud Storage** > **Buckets** and create a new bucket.
3. Upload your SQL backup file to this bucket.
4. Set the necessary permissions on the bucket so your Cloud SQL instance can access it.

---

## 3. Launch a New Cloud SQL Instance

1. In the Cloud Console, navigate to **SQL** > **Create instance**.
2. Choose the database engine (MySQL, PostgreSQL, etc.) that matches your backup.
3. Specify the instance settings:
   - **Instance ID**: Choose a unique identifier.
   - **Region**: Choose a region close to your application or users.
   - **Database Version**: Ensure this matches your backup compatibility requirements.
4. Configure any additional settings, such as machine type, storage capacity, and networking options.

---

## 4. Import the Backup into the Cloud SQL Instance

1. Go to the Cloud SQL instance you created.
2. In the **Overview** page of your SQL instance, select **Import**.
3. Choose your GCS bucket and select the backup file.
4. Specify the target database for the import; create the database beforehand if it doesn exist.

**Note**: The import process may take time depending on the backup size.

---

## 5. Verify the Database Restoration

- Once the import is complete, verify that all data has been restored correctly.
- Connect to your new Cloud SQL instance.
- Check that tables and data align with your expectations from the backup.

---

## 6. Configure Connectivity and Security

- If your application needs to connect to the SQL instance, configure **IP allowlisting** or use **private IP** for connectivity.
- Enable SSL/TLS if needed for encrypted connections.
- Set up any necessary **Firewall rules** if your SQL instance is in a VPC.

---

## 7. Connect Drupal to new database

- After importing the database enshure that mysql user exist with right permission or create it and grant all necessary privileges.
```
mysql -h some_host -u root -p
CREATE USER 'new_user'@'%' IDENTIFIED BY 'new_password';
GRANT ALL PRIVILEGES ON imported_db.* TO 'new_user'@'%';
FLUSH PRIVILEGES;
EXIT;
```
- Change database connection configuration in settings.php file.
- Ensure that your site works with the migrated database.

---
