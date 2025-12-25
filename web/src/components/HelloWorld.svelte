<script lang="ts">

  const prompts = [
    'bicycles',
    'traffic lights',
    'crosswalks',
    'fire hydrants',
    'stairs',
    'buses',
    'motorcycles',
    'bridges',
    'chimneys'
  ];

  let prompt = prompts[Math.floor(Math.random() * prompts.length)];

  let images = Array.from({ length: 9 }, (_, i) => ({
    id: i,
    selected: false,
    src: 'https://picsum.photos/200?random=' + Math.random()
  }));

  let loading = false;
  let error = false;
  let fadeOut = false;

  function toggle(img) {
    if (loading) return;

    images = images.map(i =>
      i.id === img.id ? { ...i, selected: !i.selected } : i
    );
  }

  function refresh() {
    error = false;
    prompt = prompts[Math.floor(Math.random() * prompts.length)];
    images = Array.from({ length: 9 }, (_, i) => ({
      id: i,
      selected: false,
      src: 'https://picsum.photos/200?random=' + Math.random()
    }));
  }

  async function verify() {
    loading = true;
    error = false;

    await new Promise(r => setTimeout(r, 1500));

    loading = false;
    error = true;

    setTimeout(() => {
      fadeOut = true;
      setTimeout(() => {
        refresh();
        fadeOut = false;
      }, 400);
    }, 1200);
  }

  function skip() {
    refresh();
  }
</script>

<div class="wrapper">
  <div class="captcha" class:fade-out={fadeOut}>
    <div class="header">
      <div class="recaptcha-logo">
        <span>🔄</span>
        <span>reCAPTCHA</span>
      </div>
      <button class="close-btn" on:click={skip}>✕</button>
    </div>

    <div class="instruction-box">
      <strong>Select all squares with</strong>
      <div class="prompt-text">{prompt}</div>
      <div class="sub-text">If there are none, click skip</div>
    </div>

    <div class="grid">
      {#each images as img, i}
        <div
          class="tile"
          class:selected={img.selected}
          class:loading={loading}
          on:click={() => toggle(img)}
          style="animation-delay: {i * 0.05}s"
        >
          <img src={img.src} alt="" draggable="false" />
          {#if img.selected}
            <div class="check">✓</div>
          {/if}
          {#if loading}
            <div class="tile-loading"></div>
          {/if}
        </div>
      {/each}
    </div>

    <div class="controls">
      <button class="action-btn secondary" on:click={skip} disabled={loading}>
        SKIP
      </button>

      <button class="action-btn primary" on:click={verify} disabled={loading}>
        {#if loading}
          <div class="spinner"></div>
        {:else}
          VERIFY
        {/if}
      </button>
    </div>

    {#if error}
      <div class="error-banner">
        ❌ Please try again
      </div>
    {/if}

    <div class="footer">
      <div class="privacy-terms">
        <a href="#">Privacy</a>
        <span>-</span>
        <a href="#">Terms</a>
      </div>
    </div>
  </div>
</div>

<style>
  .wrapper {
    position: fixed;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.65);
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
  }

  .captcha {
    width: 400px;
    background: #1e1e1e;
    border-radius: 4px;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
    overflow: hidden;
    animation: slideIn 0.3s ease-out;
    transition: opacity 0.3s ease, transform 0.3s ease;
  }

  .captcha.fade-out {
    opacity: 0;
    transform: scale(0.95);
  }

  @keyframes slideIn {
    from {
      opacity: 0;
      transform: translateY(-20px) scale(0.95);
    }
    to {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
  }

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 16px;
    border-bottom: 1px solid #333;
    background: #252525;
  }

  .recaptcha-logo {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #e0e0e0;
    font-size: 14px;
    font-weight: 500;
  }

  .close-btn {
    background: none;
    border: none;
    color: #888;
    font-size: 20px;
    cursor: pointer;
    padding: 4px 8px;
    line-height: 1;
    transition: color 0.2s;
  }

  .close-btn:hover {
    color: #fff;
  }

  .instruction-box {
    padding: 16px;
    background: #1e1e1e;
    border-bottom: 1px solid #333;
  }

  .instruction-box strong {
    display: block;
    color: #e0e0e0;
    font-size: 14px;
    margin-bottom: 4px;
  }

  .prompt-text {
    color: #1a73e8;
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 4px;
  }

  .sub-text {
    color: #999;
    font-size: 12px;
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 0;
    background: #1e1e1e;
    padding: 16px;
  }

  .tile {
    position: relative;
    aspect-ratio: 1;
    border: 2px solid #2a2a2a;
    cursor: pointer;
    overflow: hidden;
    transition: all 0.2s ease;
    animation: fadeInTile 0.4s ease-out backwards;
  }

  @keyframes fadeInTile {
    from {
      opacity: 0;
      transform: scale(0.9);
    }
    to {
      opacity: 1;
      transform: scale(1);
    }
  }

  .tile:hover:not(.loading) {
    border-color: #1a73e8;
    z-index: 1;
  }

  .tile img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }

  .tile.selected {
    border-color: #1a73e8;
  }

  .check {
    position: absolute;
    inset: 0;
    background: rgba(26, 115, 232, 0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 48px;
    color: white;
    font-weight: bold;
    animation: checkAppear 0.2s ease-out;
  }

  @keyframes checkAppear {
    from {
      opacity: 0;
      transform: scale(0.5);
    }
    to {
      opacity: 1;
      transform: scale(1);
    }
  }

  .tile-loading {
    position: absolute;
    inset: 0;
    background: rgba(0, 0, 0, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .controls {
    display: flex;
    gap: 8px;
    padding: 12px 16px;
    background: #252525;
    border-top: 1px solid #333;
  }

  .action-btn {
    border: none;
    padding: 10px 16px;
    border-radius: 3px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    transition: all 0.2s;
    text-transform: uppercase;
  }

  .action-btn.secondary {
    background: #2a2a2a;
    color: #4da3ff;
    border: 1px solid #3a3a3a;
    flex: 0 0 auto;
    min-width: 50px;
  }

  .action-btn.secondary:hover:not(:disabled) {
    background: #333;
    border-color: #4da3ff;
  }

  .action-btn.primary {
    background: #4da3ff;
    color: #000;
    flex: 1;
    justify-content: center;
  }

  .action-btn.primary:hover:not(:disabled) {
    background: #3d8edb;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.4);
  }

  .action-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .spinner {
    width: 16px;
    height: 16px;
    border: 2px solid rgba(0, 0, 0, 0.3);
    border-top-color: #000;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
  }

  @keyframes spin {
    to { transform: rotate(360deg); }
  }

  .error-banner {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    padding: 10px 16px;
    background: #3d1f1f;
    color: #ff6b6b;
    font-size: 13px;
    border-top: 1px solid #333;
    animation: slideDown 0.3s ease-out;
  }

  @keyframes slideDown {
    from {
      max-height: 0;
      opacity: 0;
    }
    to {
      max-height: 50px;
      opacity: 1;
    }
  }

  .footer {
    padding: 10px 16px;
    background: #252525;
    border-top: 1px solid #333;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .privacy-terms {
    display: flex;
    gap: 8px;
    font-size: 11px;
    color: #999;
  }

  .privacy-terms a {
    color: #4da3ff;
    text-decoration: none;
  }

  .privacy-terms a:hover {
    text-decoration: underline;
  }
</style>