# ATSourcing Pro delivery tasks

## Static frontend package

- [x] Keep the supplied ATSourcing Pro interface as `index.html`.
- [x] Add Vercel deployment metadata with safe baseline response headers.
- [x] Document the GitHub and Vercel deployment path.
- [x] Keep credentials and environment files out of version control.

## Supabase foundation

- [x] Create candidate, trial-request, and contact-message tables.
- [x] Add insert-only public RLS policies for the three intake paths.
- [x] Create a private `candidate-cvs` storage bucket with a 10 MB limit and PDF/DOC/DOCX MIME restrictions.
- [x] Add a public upload policy for CV intake without public file reads.

## Backend integration still required

- [ ] Connect the candidate form to Supabase Storage and the `candidates` table.
- [ ] Connect the trial request form to `trial_requests`.
- [ ] Connect the contact form to `contact_messages`.
- [ ] Add server-side notification delivery for recruiter alerts.
- [ ] Add authenticated recruiter/admin access for candidate search, CV access, notes, tags, and pipeline updates.
- [ ] Add rate limiting, CAPTCHA/abuse protection, and server-side validation before accepting public submissions.
- [ ] Add the final privacy policy, data-retention wording, and deletion-request workflow for the jurisdictions in which candidates are recruited.
