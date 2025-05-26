setInterval(async () => {
    (await navigator.serviceWorker.ready).active.postMessage('keepAlive');
  }, 20e3);