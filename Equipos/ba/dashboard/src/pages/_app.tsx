import "@/styles/theme.css";
import "primeicons/primeicons.css";
import "@/styles/globals.css";
import type { AppProps } from "next/app";
import type { AppType } from "next/app";
import { trpc } from "../utils/trpc";
import { PagesProgressBar as ProgressBar } from "next-nprogress-bar";
import { SessionProvider } from "next-auth/react";
import { Layout } from "@/components";

const MyApp: AppType = ({ Component, pageProps }: AppProps) => {
  return (
    <SessionProvider>
      <Layout>
        <Component {...pageProps} />
        <ProgressBar
          height="4px"
          color="#00ff7b"
          options={{ showSpinner: false }}
          shallowRouting
        />
      </Layout>
    </SessionProvider>
  );
};

export default trpc.withTRPC(MyApp);
