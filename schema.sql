-- ATSourcing Pro initial Supabase schema
-- Run this in Supabase SQL Editor.
-- Public users may INSERT submissions only. Read/update/delete operations should be performed by authenticated server-side admin code.

create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

create table if not exists public.candidates (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  email text not null,
  phone text not null,
  country text not null,
  region text not null,
  date_of_birth date not null,
  primary_role text,
  cv_path text not null,
  cv_original_name text not null,
  cv_size_bytes bigint not null,
  consent_storage boolean not null default false,
  consent_communications boolean not null default false,
  status text not null default 'new' check (status in ('new', 'screening', 'shortlisted', 'interview', 'placed', 'rejected', 'withdrawn')),
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now()),
  constraint candidates_storage_consent check (consent_storage = true)
);

create index if not exists candidates_email_idx on public.candidates (lower(email));
create index if not exists candidates_country_idx on public.candidates (country);
create index if not exists candidates_status_idx on public.candidates (status);
create index if not exists candidates_created_at_idx on public.candidates (created_at desc);

create table if not exists public.trial_requests (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  email text not null,
  phone text not null,
  country text not null,
  company_name text not null,
  position text not null,
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists trial_requests_created_at_idx on public.trial_requests (created_at desc);

create table if not exists public.contact_messages (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  email text not null,
  topic text not null,
  message text not null,
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists contact_messages_created_at_idx on public.contact_messages (created_at desc);

create or replace trigger candidates_set_updated_at
before update on public.candidates
for each row execute function public.set_updated_at();

alter table public.candidates enable row level security;
alter table public.trial_requests enable row level security;
alter table public.contact_messages enable row level security;

-- Anonymous/public visitors can submit, but cannot read submissions through the browser.
drop policy if exists candidates_public_insert on public.candidates;
create policy candidates_public_insert
on public.candidates
for insert
to anon, authenticated
with check (consent_storage = true);

drop policy if exists trial_requests_public_insert on public.trial_requests;
create policy trial_requests_public_insert
on public.trial_requests
for insert
to anon, authenticated
with check (true);

drop policy if exists contact_messages_public_insert on public.contact_messages;
create policy contact_messages_public_insert
on public.contact_messages
for insert
to anon, authenticated
with check (true);

-- Private bucket for uploaded CVs. Files are not publicly readable.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'candidate-cvs',
  'candidate-cvs',
  false,
  10485760,
  array[
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
  ]
)
on conflict (id) do update set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

-- Public users can upload CVs, but cannot list, read, update, or delete files.
drop policy if exists candidate_cvs_public_insert on storage.objects;
create policy candidate_cvs_public_insert
on storage.objects
for insert
to anon, authenticated
with check (bucket_id = 'candidate-cvs');

-- No SELECT policy is intentionally created for public users.
-- Add tightly scoped authenticated/admin policies when the admin dashboard is implemented.
