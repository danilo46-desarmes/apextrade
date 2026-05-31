-- Rendre toutes les tables accessibles publiquement (sans connexion)
DROP POLICY IF EXISTS "Authenticated full access" ON members;
DROP POLICY IF EXISTS "Authenticated full access" ON trades;
DROP POLICY IF EXISTS "Authenticated full access" ON signals;
DROP POLICY IF EXISTS "Authenticated full access" ON alerts;
DROP POLICY IF EXISTS "Authenticated full access" ON team_chat;
DROP POLICY IF EXISTS "Authenticated full access" ON portfolio;
DROP POLICY IF EXISTS "Authenticated full access" ON settings;
DROP POLICY IF EXISTS "Public access" ON members;
DROP POLICY IF EXISTS "Public access" ON trades;
DROP POLICY IF EXISTS "Public access" ON signals;
DROP POLICY IF EXISTS "Public access" ON alerts;
DROP POLICY IF EXISTS "Public access" ON team_chat;
DROP POLICY IF EXISTS "Public access" ON portfolio;
DROP POLICY IF EXISTS "Public access" ON settings;

CREATE POLICY "Public access" ON members FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Public access" ON trades FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Public access" ON signals FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Public access" ON alerts FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Public access" ON team_chat FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Public access" ON portfolio FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Public access" ON settings FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);
