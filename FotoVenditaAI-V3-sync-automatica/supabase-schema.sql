-- Esegui in Supabase > SQL Editor, con il tuo progetto personale.
create table if not exists public.products (
 id text primary key,
 user_id uuid not null references auth.users(id) on delete cascade,
 payload jsonb not null,
 updated_at timestamptz not null default now()
);
create index if not exists products_user_id_idx on public.products(user_id);
alter table public.products enable row level security;
create policy "owner_select" on public.products for select to authenticated using (auth.uid() = user_id);
create policy "owner_insert" on public.products for insert to authenticated with check (auth.uid() = user_id);
create policy "owner_update" on public.products for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
-- Non inserire la service_role key nell'app.
