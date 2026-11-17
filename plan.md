# ATSourcing Pro deployment plan

## Scope

Package the supplied single-page ATSourcing Pro frontend for GitHub and Vercel, then prepare a Supabase-backed recruitment data layer without exposing private credentials in browser code.

## Implementation approach

The first deployment keeps the supplied HTML as `index.html` and uses its existing Tailwind CDN and Google Fonts CDN dependencies, so Vercel can serve it as a static site with no build step. The current frontend interactions remain intact while the backend is prepared separately.

The Supabase phase uses three insert-only public submission tables and a private CV storage bucket. Public browser access is limited by Row Level Security; candidate searching, CV access, pipeline management, and notifications will be handled by authenticated server-side code in a later phase.

## Project structure

- `index.html`: supplied ATSourcing Pro frontend and current UI interactions.
- `vercel.json`: static deployment headers.
- `supabase/schema.sql`: database tables, RLS policies, and private CV bucket.
- `README.md`: setup, deployment, and security instructions.
- `TODO.md`: outstanding integration work.

## Design direction

- Probability 0.06 — clean SaaS operations console: restrained blue accents, crisp cards, and clear conversion paths.
- Probability 0.04 — editorial recruitment workspace: larger typography, paper-like sections, and stronger narrative hierarchy.
- Probability 0.03 — premium hiring infrastructure: deeper contrast, tighter spacing, and more enterprise-oriented surfaces.

Chosen direction: clean SaaS operations console, because it matches the supplied frontend and keeps candidate and recruiter actions immediately legible.

Core principles: clarity before decoration; trust through transparent consent and privacy language; low-friction submissions; and visible separation between public intake and protected recruiter operations.

Color philosophy: the existing blue is the product's action and trust color, supported by white space and dark text for a calm, professional recruitment workflow.

Layout paradigm: long-form landing page with focused conversion panels, followed by a dedicated candidate-intake view.

Signature elements: rounded blue action controls, light-blue trust surfaces, and structured form cards.

Interaction philosophy: every submission should give immediate feedback, while persistence and admin operations remain protected behind the backend.

Animation: retain the supplied subtle hover, scroll, modal, and toast transitions; avoid motion that competes with form completion.

Typography system: Inter for the entire interface, with bold weights for product claims and normal weights for explanatory copy.

Brand essence: an organized talent database for recruiters and candidates; clear, practical, dependable.

Brand voice: direct and reassuring. Example lines: “Your CVs. One Organized Talent Database.” and “Submit your CV for relevant future opportunities.”

Wordmark and logo: preserve the supplied ATSourcing Pro wordmark and blue folder/database mark until a separate logo asset is requested.

Signature brand color: `#2875CF`.
