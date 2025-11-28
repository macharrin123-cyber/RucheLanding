-- SQL to create the email waitlist table in Supabase
-- Run this in your Supabase SQL Editor

CREATE TABLE email_waitlist (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  language VARCHAR(2) DEFAULT 'en',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Enable Row Level Security
ALTER TABLE email_waitlist ENABLE ROW LEVEL SECURITY;

-- Create a policy that allows anyone to insert emails
CREATE POLICY "Allow public email insertion" 
ON email_waitlist 
FOR INSERT 
TO anon 
WITH CHECK (true);

-- Create a policy that allows reading (optional, for admin purposes)
CREATE POLICY "Allow public read" 
ON email_waitlist 
FOR SELECT 
TO anon 
USING (true);

-- Create an index on email for faster lookups
CREATE INDEX idx_email_waitlist_email ON email_waitlist(email);
CREATE INDEX idx_email_waitlist_created_at ON email_waitlist(created_at DESC);
