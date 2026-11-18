-- ISW Shirt Sizes: database setup.
-- Run this in the Supabase SQL Editor of a fresh project.
-- BEFORE RUNNING: replace CHANGE_ME below with the password you want the crew to use.

create table public.shirt_sizes (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(btrim(name)) between 1 and 60),
  size text not null check (size in ('S','M','L','XL','2XL','3XL','3XL Tall','4XL','4XL Tall')),
  style text not null check (style in ('Zip','Pullover')),
  color text not null check (color in ('Pink','Black','Orange')),
  created_at timestamptz not null default now()
);

-- Row level security on, with no policies: the public cannot touch the table directly.
alter table public.shirt_sizes enable row level security;
revoke all on public.shirt_sizes from anon, authenticated;

-- Password check (the password lives here, not in the web page).
create or replace function public.shirt_check(p text) returns void
language plpgsql security definer set search_path = '' as $$
begin
  if p is null or encode(sha256(convert_to(p,'utf8')),'hex') <> encode(sha256(convert_to('CHANGE_ME','utf8')),'hex') then
    raise exception 'bad password' using errcode = '28000';
  end if;
end $$;

create or replace function public.shirt_list(p text)
returns table(id uuid, name text, size text, style text, color text)
language plpgsql security definer set search_path = '' as $$
begin
  perform public.shirt_check(p);
  return query select s.id, s.name, s.size, s.style, s.color from public.shirt_sizes s order by s.created_at;
end $$;

create or replace function public.shirt_add(p text, n text, s text, st text, c text) returns void
language plpgsql security definer set search_path = '' as $$
begin
  perform public.shirt_check(p);
  insert into public.shirt_sizes(name, size, style, color) values (btrim(n), s, st, c);
end $$;

create or replace function public.shirt_remove(p text, i uuid) returns void
language plpgsql security definer set search_path = '' as $$
begin
  perform public.shirt_check(p);
  delete from public.shirt_sizes where id = i;
end $$;

revoke all on function public.shirt_check(text) from public, anon, authenticated;
revoke all on function public.shirt_list(text) from public;
revoke all on function public.shirt_add(text, text, text, text, text) from public;
revoke all on function public.shirt_remove(text, uuid) from public;
grant execute on function public.shirt_list(text), public.shirt_add(text, text, text, text, text), public.shirt_remove(text, uuid) to anon;
