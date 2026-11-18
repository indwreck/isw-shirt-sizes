# ISW Shirt Sizes

Crew hoodie size collector with a PDF order sheet. One page (`index.html`) plus a Supabase database.

Live page (when published): https://indwreck.github.io/isw-shirt-sizes/

## Using it again next year

1. **Database.** Open the Supabase project "ISW Shirt Sizes".
   - If it says paused, click Restore project. Supabase only keeps paused free projects for about 90 days.
   - If the project is gone, create a new one and run `supabase/schema.sql` in the SQL Editor (replace `CHANGE_ME` with the new password first).
2. **Clear last year's names.** In the SQL Editor run: `delete from public.shirt_sizes;`
3. **If you made a new Supabase project,** update `API` and `KEY` near the top of the script in `index.html` with the new project URL (`.../rest/v1/rpc/`) and its anon (public) key.
4. **Change the password** (optional): in the SQL Editor, re-run the `shirt_check` function from `schema.sql` with the new password.
5. **Publish.** GitHub: Settings, Pages, Deploy from a branch, `main`, `/ (root)`.
6. **Take it down again** when done: Settings, Pages, unpublish.

## What to review each year

- Colors and writing colors (`COLORS`, `WRITING` in `index.html`).
- Long sleeve T-shirt rule: 3 per hoodie by size, Medium 1 per hoodie, each size rounded up to the next half dozen (PDF code in `index.html`).
- Job site employees order Orange (note on the form and the PDF).

No names or passwords are stored in this repo.
