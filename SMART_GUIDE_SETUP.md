# Smart Guide System Setup

This document describes how to set up the Smart Guide System for sharing digital guides via QR codes.

## 1. Database Setup
You need to run the `guide_system_schema.sql` migration to create the necessary tables and storage buckets.

1. Go to Supabase SQL Editor.
2. Open or copy the content of `guide_system_schema.sql`.
3. Run the SQL.

This will create:
- `smart_guides` table
- `smart_guide_files` table
- `guide-files` storage bucket (Public)
- RLS policies for public read and public write (for admin simplicity in this setup)

## 2. Default Access
- **Admin Page**: Go to `/admin` and click on "Smart Guides" card.
- **Public Page**: Go to `/guides`.

## 3. Usage
### Adding Guides (Admin)
1. Navigate to `/admin` -> "Smart Guides".
2. Click "Add Topic" to create a new category/question (e.g., "Weight Loss Plateau").
3. Once created, click the arrow to expand the topic.
4. Click "Upload File" to add files (PDFs, Images) to that topic.

### Viewing Guides (Public)
1. Share the link `https://peptalk.ph/guides` (or your domain).
2. Users can search for topics or browse the list.
3. Clicking a topic expands it to show downloadable files.

## 4. Updates
- You can edit topic titles or delete them.
- Deleting a topic deletes all associated files from storage and database.
- You can delete individual files from a topic.
