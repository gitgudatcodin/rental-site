-- ============================================================
-- BOOKING STATUS GUARD — one-time migration
-- Run this in Supabase SQL Editor ONLY if you already ran
-- schema.sql before this guard was added.
-- (Fresh setups don't need it: schema.sql already includes it.)
--
-- Without this, the public "create booking" policy allowed anyone
-- to insert a booking with status = 'confirmed', bypassing the
-- owner's payment confirmation. This restricts public inserts
-- to pending_payment only.
-- ============================================================

drop policy if exists "public create booking" on bookings;
create policy "public create booking" on bookings
  for insert to anon, authenticated with check (status = 'pending_payment');
