-- ═══════════════════════════════════════════════════════════════
-- APEX TRADE — SCHÉMA BASE DE DONNÉES (VERSION CORRIGÉE)
-- Copiez et collez tout ce fichier dans Supabase > SQL Editor > New Query
-- puis cliquez RUN
-- ═══════════════════════════════════════════════════════════════

-- 1. MEMBRES DE L'ÉQUIPE
create table if not exists members (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  email text unique not null,
  role text default 'Observateur' check (role in ('Trader','Analyste','Quant','Observateur')),
  status text default 'pending' check (status in ('active','pending','suspended')),
  pnl numeric default 0,
  trades_count integer default 0,
  avatar text,
  color text default '#566070',
  invited_by uuid,
  created_at timestamptz default now()
);

-- 2. TRADES
create table if not exists trades (
  id uuid default gen_random_uuid() primary key,
  pair text not null,
  direction text check (direction in ('LONG','SHORT')),
  market text check (market in ('crypto','forex','stocks')),
  entry_price numeric not null,
  exit_price numeric,
  tp numeric,
  sl numeric,
  quantity numeric default 1,
  pnl numeric default 0,
  pnl_pct numeric default 0,
  status text default 'open' check (status in ('open','closed','cancelled')),
  ai_engine text,
  confidence integer,
  auto_trade boolean default false,
  member_id uuid,
  created_at timestamptz default now(),
  closed_at timestamptz
);

-- 3. SIGNAUX IA
create table if not exists signals (
  id uuid default gen_random_uuid() primary key,
  pair text not null,
  market text check (market in ('crypto','forex','stocks')),
  direction text check (direction in ('LONG','SHORT')),
  entry_price numeric,
  tp numeric,
  sl numeric,
  confidence integer,
  ai_engine text,
  analysis text,
  executed boolean default false,
  created_at timestamptz default now()
);

-- 4. ALERTES
create table if not exists alerts (
  id uuid default gen_random_uuid() primary key,
  type text check (type in ('signal','trade','member','risk','system')),
  message text not null,
  read boolean default false,
  created_at timestamptz default now()
);

-- 5. CHAT ÉQUIPE
create table if not exists team_chat (
  id uuid default gen_random_uuid() primary key,
  from_name text not null,
  from_avatar text,
  from_color text default '#566070',
  message text not null,
  created_at timestamptz default now()
);

-- 6. PORTFOLIO
create table if not exists portfolio (
  id uuid default gen_random_uuid() primary key,
  asset text unique not null,
  quantity numeric default 0,
  value_usd numeric default 0,
  change_24h numeric default 0,
  color text default '#566070',
  updated_at timestamptz default now()
);

-- 7. PARAMÈTRES GLOBAUX
create table if not exists settings (
  id integer primary key default 1,
  auto_trading boolean default true,
  max_risk_per_trade numeric default 2,
  max_positions integer default 8,
  max_drawdown numeric default 10,
  max_leverage integer default 5,
  active_engines jsonb default '["GPT-Quant","SentimentAI","MacroLens","EarningsBot"]',
  chef_name text default 'Le Continental',
  chef_email text,
  updated_at timestamptz default now()
);

-- 8. DONNÉES INITIALES
insert into settings (id, chef_name) values (1, 'Le Continental') on conflict (id) do nothing;

insert into portfolio (asset, quantity, value_usd, change_24h, color) values
  ('BTC',  0.42, 28736, 3.2,  '#f7931a'),
  ('ETH',  5.80, 22110, -1.4, '#627eea'),
  ('AAPL', 50,   9920,  0.8,  '#a8d8a8'),
  ('NVDA', 10,   10420, 4.2,  '#76b900')
on conflict (asset) do nothing;

insert into alerts (type, message) values
  ('signal', 'GPT-Quant: Signal LONG fort sur BTC — conf. 91%'),
  ('trade',  'Trade NVDA LONG fermé automatiquement: +$6,200 (+6.32%)'),
  ('system', 'Plateforme APEX TRADE démarrée avec succès');

-- 9. SÉCURITÉ — DROP avant recréation pour éviter les doublons
alter table members enable row level security;
alter table trades enable row level security;
alter table signals enable row level security;
alter table alerts enable row level security;
alter table team_chat enable row level security;
alter table portfolio enable row level security;
alter table settings enable row level security;

drop policy if exists "Authenticated full access" on members;
drop policy if exists "Authenticated full access" on trades;
drop policy if exists "Authenticated full access" on signals;
drop policy if exists "Authenticated full access" on alerts;
drop policy if exists "Authenticated full access" on team_chat;
drop policy if exists "Authenticated full access" on portfolio;
drop policy if exists "Authenticated full access" on settings;

create policy "Authenticated full access" on members for all using (auth.role() = 'authenticated');
create policy "Authenticated full access" on trades for all using (auth.role() = 'authenticated');
create policy "Authenticated full access" on signals for all using (auth.role() = 'authenticated');
create policy "Authenticated full access" on alerts for all using (auth.role() = 'authenticated');
create policy "Authenticated full access" on team_chat for all using (auth.role() = 'authenticated');
create policy "Authenticated full access" on portfolio for all using (auth.role() = 'authenticated');
create policy "Authenticated full access" on settings for all using (auth.role() = 'authenticated');
