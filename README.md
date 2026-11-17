# ATSourcing Pro

ATSourcing Pro is a static frontend for CV collection, talent-database messaging, trial requests, and contact enquiries.

## Current state

- `index.html` contains the supplied ATSourcing Pro frontend.
- The current forms are frontend-only demo flows: they show confirmation messages but do not persist data yet.
- `supabase/schema.sql` contains the initial database and private CV-storage schema for the backend phase.
- No secrets are committed to this repository.

## Deploy the frontend to Vercel

1. Create a repository named `atsourcing-pro` on GitHub.
2. Push this project to the repository:

   ```bash
   git init
   git add .
   git commit -m "Prepare ATSourcing Pro frontend"
   git branch -M main
   git remote add origin https://github.com/YOUR-USERNAME/atsourcing-pro.git
   git push -u origin main
   ```

3. In Vercel, select **Add New Project**, import the GitHub repository, and use these settings:
   - Framework preset: **Other**
   - Build command: leave blank
   - Output directory: `.`
4. Deploy.

The site uses Tailwind and Google Fonts from CDNs, so no frontend build step is required for this first deployment.

## Create the Supabase backend

1. Create a Supabase project.
2. Open **SQL Editor** and run [`supabase/schema.sql`](supabase/schema.sql).
3. The schema creates insert-only public submission paths for candidates, trial requests, and contact messages, plus a private `candidate-cvs` storage bucket.
4. Keep the Supabase **service-role key** server-side only. Never place it in `index.html`, browser JavaScript, GitHub, or Vercel client-side environment variables.
5. In the backend phase, wire the three form handlers to Supabase using either:
   - a small Vercel serverless API / Edge Function, or
   - the Supabase browser client with the public anon key and the included RLS policies.

## Backend data flow to implement next

- Candidate form: upload the CV to the private bucket, then insert the candidate profile and CV metadata.
- Trial form: insert a trial request and notify the recruiter through a protected server-side workflow.
- Contact form: insert the enquiry and notify the recruiter through a protected server-side workflow.
- Admin area: use authenticated server-side access to search candidates, review CVs, and update pipeline status.

## Environment variables for the backend phase

Store these in Vercel or Supabase server-side settings, not in the repository:

```text
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
```

The service-role key must only be used in server-side code.
