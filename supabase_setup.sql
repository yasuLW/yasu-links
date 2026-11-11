-- ========================================================
-- LEAN & WAVS • ANALYTICS DATABASE SETUP FOR SUPABASE
-- Proyecto: zibvkfgcltdullmlugqb
-- ========================================================

-- 1. Crear la tabla de eventos de analíticas
CREATE TABLE IF NOT EXISTS public.analytics_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    page_id TEXT NOT NULL,         -- Identificador del landing: "yasu", "leanandwavs", etc.
    event_type TEXT NOT NULL,      -- "view" (visita) o "click" (clic en botón)
    platform TEXT,                 -- "spotify", "apple_music", "youtube_channel", "soundcloud", "instagram", "video_play", "share"
    device TEXT,                   -- "mobile" o "desktop"
    referrer TEXT,                 -- Origen de la visita (Instagram, TikTok, directo, etc.)
    user_agent TEXT                -- Datos técnicos del navegador
);

-- 2. Habilitar seguridad de nivel de fila (RLS)
ALTER TABLE public.analytics_events ENABLE ROW LEVEL SECURITY;

-- 3. Permitir que cualquier visitante de tus landing pages pueda registrar visitas y clics (INSERT)
CREATE POLICY "Permitir insercion anonima de eventos"
    ON public.analytics_events
    FOR INSERT
    TO anon
    WITH CHECK (true);

-- 4. Permitir lectura de eventos para el panel de control (SELECT)
CREATE POLICY "Permitir lectura para el panel de control"
    ON public.analytics_events
    FOR SELECT
    TO anon
    USING (true);

-- 5. Crear índices para consultas ultra-rápidas
CREATE INDEX IF NOT EXISTS idx_analytics_page_id ON public.analytics_events(page_id);
CREATE INDEX IF NOT EXISTS idx_analytics_created_at ON public.analytics_events(created_at);
CREATE INDEX IF NOT EXISTS idx_analytics_event_type ON public.analytics_events(event_type);
CREATE INDEX IF NOT EXISTS idx_analytics_platform ON public.analytics_events(platform);
