import React, { useEffect, useRef } from 'react';

declare global {
  interface Window {
    adsbygoogle: any[];
  }
}

export function AdBanner() {
  const adRef = useRef<HTMLDivElement>(null);
  const pushed = useRef(false);

  useEffect(() => {
    if (adRef.current && !pushed.current) {
      const pushAd = () => {
        try {
          if (window.adsbygoogle) {
            (window.adsbygoogle = window.adsbygoogle || []).push({});
            pushed.current = true;
          }
        } catch (error) {
          console.error('Error loading ad:', error);
        }
      };

      // Check if adsbygoogle is available
      if (window.adsbygoogle) {
        pushAd();
      } else {
        // Wait for adsbygoogle to be defined
        const intervalId = setInterval(() => {
          if (window.adsbygoogle) {
            pushAd();
            clearInterval(intervalId);
          }
        }, 50); // Check every 50ms

        // Cleanup interval after 5 seconds if ad doesn't load
        setTimeout(() => clearInterval(intervalId), 5000);
      }
    }
  }, []);

  return (
    <div className="w-full flex justify-center my-8">
      <div
        ref={adRef}
        style={{ minHeight: '90px' }}
        className="w-full max-w-[728px] bg-gray-50"
      >
        <ins
          className="adsbygoogle"
          style={{ display: 'block', width: '728px', height: '90px' }}
          data-ad-client="ca-pub-XXXXX"
          data-ad-slot="XXXXX"
          data-ad-format="auto"
          data-full-width-responsive="true"
        />
      </div>
    </div>
  );
}