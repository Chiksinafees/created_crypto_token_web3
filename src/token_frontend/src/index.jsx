import { createRoot } from "react-dom/client";
import React from "react";
import App from "./components/App";
import { AuthClient } from "@dfinity/auth-client";

const init = async () => {
  const authClient = await AuthClient.create();

  if (await authClient.isAuthenticated()) {
    handleAuthenticate(authClient);
  } else {
    await authClient.login({
      identityProvider: "https://identity.ic0.app/#authorize",
      onSuccess: () => {
        handleAuthenticate(authClient);
      },
    });
  }

  async function handleAuthenticate(authClient) {
    const container = document.getElementById("root");
    const root = createRoot(container);
    root.render(<App />);
  }
};

init();
