import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Recipedia - Connect, Share & Cook Amazing Recipes",
  description: "Join the Recipedia community and discover thousands of delicious recipes from around the world. Share your culinary creations and connect with fellow food enthusiasts.",
  icons: {
    icon: "/cooking-icon.svg",
    shortcut: "/cooking-icon.svg",
    apple: "/cooking-icon.svg",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  );
}
