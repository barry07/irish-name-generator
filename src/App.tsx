import React, { useState, useEffect } from 'react';
import { Baby, Loader2, Shuffle } from 'lucide-react';
import {
  FacebookShareButton,
  TwitterShareButton,
  WhatsappShareButton,
  FacebookIcon,
  TwitterIcon,
  WhatsappIcon,
} from 'react-share';
import { supabase } from './lib/supabase';
import type { IrishName } from './lib/supabase';
import { AdBanner } from './components/AdBanner';

function App() {
  const [generatedName, setGeneratedName] = useState<IrishName | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isConnected, setIsConnected] = useState(false);

  // Check Supabase connection on mount
  useEffect(() => {
    async function checkConnection() {
      try {
        const { error } = await supabase.from('irish_names').select('count');
        if (error) throw error;
        setIsConnected(true);
      } catch (err) {
        console.error('Supabase connection error:', err);
        setIsConnected(false);
        setError('Unable to connect to the database. Please check your internet connection and try again.');
      }
    }
    checkConnection();
  }, []);

  const generateName = async () => {
    if (!isConnected) {
      setError('Database connection is not available. Please try again later.');
      return;
    }

    setLoading(true);
    setError(null);
    
    try {
      const { data, error: supabaseError } = await supabase
        .rpc('get_random_name')
        .single();

      if (supabaseError) {
        console.error('Supabase error:', supabaseError);
        if (supabaseError.message.includes('connection')) {
          throw new Error('Network connection error. Please check your internet connection and try again.');
        }
        throw new Error(supabaseError.message || 'Failed to generate name. Please try again.');
      }

      if (!data) {
        throw new Error('No names available in the database.');
      }

      setGeneratedName(data);
    } catch (err) {
      console.error('Error generating name:', err);
      setError(err instanceof Error ? err.message : 'Failed to generate name. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  // Get the canonical URL for sharing
  const shareUrl = typeof window !== 'undefined' 
    ? new URL(window.location.pathname, window.location.origin).toString()
    : 'https://irish-baby-names.netlify.app/';

  // Create a descriptive share message
  const shareTitle = generatedName 
    ? `I found this beautiful Irish name: ${generatedName.name} - meaning "${generatedName.meaning}". Generate your own Irish baby name!`
    : 'Discover beautiful Irish baby names with meanings using this generator!';

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50 to-green-100">
      <div className="max-w-2xl mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <div className="flex items-center justify-center mb-4">
            <Baby className="w-12 h-12 text-green-600" />
          </div>
          <h1 className="text-4xl font-bold text-gray-800 mb-4">
            Irish Baby Name Generator
          </h1>
          <p className="text-gray-600">
            Discover beautiful Irish names for your little one
          </p>
        </div>

        <AdBanner />

        <div className="bg-white rounded-xl shadow-xl p-8 mb-8">
          <button
            onClick={generateName}
            disabled={loading || !isConnected}
            className="w-full bg-green-600 hover:bg-green-700 text-white font-semibold py-3 px-6 rounded-lg flex items-center justify-center gap-2 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {loading ? (
              <Loader2 className="w-5 h-5 animate-spin" />
            ) : (
              <Shuffle className="w-5 h-5" />
            )}
            Generate Name
          </button>

          {error && (
            <div className="mt-4 p-4 bg-red-50 text-red-700 rounded-lg">
              {error}
            </div>
          )}

          {generatedName && (
            <div className="mt-8 text-center">
              <h2 className="text-3xl font-bold text-gray-800 mb-2">
                {generatedName.name}
              </h2>
              <p className="text-gray-600 mb-2">{generatedName.meaning}</p>
              <span className="inline-block bg-green-100 text-green-800 text-sm px-3 py-1 rounded-full">
                {generatedName.gender === 'boy' ? 'Boy' : 'Girl'}
              </span>

              <div className="mt-6 flex items-center justify-center gap-4">
                <FacebookShareButton url={shareUrl} quote={shareTitle} hashtag="#IrishBabyNames">
                  <FacebookIcon size={32} round />
                </FacebookShareButton>
                <TwitterShareButton url={shareUrl} title={shareTitle} hashtags={['IrishBabyNames', 'BabyNames']}>
                  <TwitterIcon size={32} round />
                </TwitterShareButton>
                <WhatsappShareButton url={shareUrl} title={shareTitle}>
                  <WhatsappIcon size={32} round />
                </WhatsappShareButton>
              </div>
            </div>
          )}
        </div>

        <AdBanner />

        <div className="text-center text-sm text-gray-500">
          <p>
            Celebrating Irish Heritage • Perfect for New Parents
          </p>
        </div>
      </div>
    </div>
  );
}

export default App;