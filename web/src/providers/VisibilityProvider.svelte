<script lang="ts">
  import { useNuiEvent } from '../utils/useNuiEvent';
  import { fetchNui } from '../utils/fetchNui';
  import { onMount } from 'svelte';
  import { visibility } from '../store/stores';

  let isVisible: boolean;

  visibility.subscribe((visible) => {
    isVisible = visible;
  });

  useNuiEvent<boolean>('setVisible', (visible) => {
    visibility.set(visible);
  });


</script>

<main>
  {#if isVisible}
    <slot />
  {/if}
</main>
