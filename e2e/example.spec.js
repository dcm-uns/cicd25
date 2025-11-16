// test de Playwright para verificar que el contador funcione bien
import { test, expect } from '@playwright/test';
test('contador incrementa al hacer clic en el botón', async ({ page }) => {
  await page.goto('http://localhost:5173/');
  const button = page.getByRole('button', { name: /count is/i });
  await expect(button).toHaveText('count is 0');
  await button.click();
  await expect(button).toHaveText('count is 1');
  await button.click();
  await expect(button).toHaveText('count is 2');
});

