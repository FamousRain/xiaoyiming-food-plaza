create table if not exists public.foods (
  id uuid primary key,
  name text not null,
  place text,
  note text,
  status text not null default 'todo' check (status in ('todo', 'eaten')),
  created_at timestamptz not null default now(),
  eaten_date date,
  rating integer check (rating between 1 and 5),
  amount numeric(10, 2) check (amount >= 0),
  photo text
);

alter table public.foods
add column if not exists amount numeric(10, 2) check (amount >= 0);

alter table public.foods
add column if not exists photo text;

alter table public.foods enable row level security;

drop policy if exists "Anyone can read foods" on public.foods;
create policy "Anyone can read foods"
on public.foods
for select
to anon
using (true);

drop policy if exists "Anyone can add foods" on public.foods;
create policy "Anyone can add foods"
on public.foods
for insert
to anon
with check (true);

drop policy if exists "Anyone can update foods" on public.foods;
create policy "Anyone can update foods"
on public.foods
for update
to anon
using (true)
with check (true);

drop policy if exists "Anyone can delete foods" on public.foods;
create policy "Anyone can delete foods"
on public.foods
for delete
to anon
using (true);
