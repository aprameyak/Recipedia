# CookingApp Web Admin

A beautiful and modern web application for cooking enthusiasts, featuring recipe discovery, user management, and comprehensive support features.

## Features

- 🏠 **Home Page**: Featured recipes, categories, and hero section
- 🔒 **Privacy Policy**: Comprehensive privacy information and data handling
- 🆘 **Support Center**: FAQ, contact information, and help resources
- 🎨 **Modern Design**: Clean, responsive design matching the CookingApp mobile app
- 📱 **Mobile Responsive**: Optimized for all device sizes
- 🎯 **User-Friendly**: Intuitive navigation and clear information architecture

## Tech Stack

- **Framework**: Next.js 15 with App Router
- **Styling**: Tailwind CSS 4
- **Language**: TypeScript
- **Icons**: Lucide React
- **Deployment**: Ready for Vercel, Netlify, or any static hosting

## Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd cookingappadmin
```

2. Install dependencies:
```bash
npm install
# or
yarn install
```

3. Run the development server:
```bash
npm run dev
# or
yarn dev
```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Project Structure

```
cookingappadmin/
├── app/
│   ├── globals.css          # Global styles and CSS variables
│   ├── layout.tsx           # Root layout with metadata
│   ├── page.tsx             # Home page
│   ├── privacy/
│   │   └── page.tsx         # Privacy policy page
│   └── support/
│       └── page.tsx         # Support center page
├── public/
│   └── cooking-icon.svg     # App icon
├── package.json
└── README.md
```

## Pages

### Home Page (`/`)
- Hero section with call-to-action
- Featured recipes showcase
- Recipe categories
- Footer with contact information

### Privacy Policy (`/privacy`)
- Comprehensive privacy information
- Data collection and usage policies
- User rights and contact information

### Support Center (`/support`)
- FAQ section
- Contact information with email: aprameyakannan@gmail.com
- Help categories
- Additional resources

## Design System

The web app uses a consistent design system matching the CookingApp mobile app:

### Colors
- **Primary**: #2E7D32 (Deep Green)
- **Secondary**: #FF6B35 (Orange)
- **Accent**: #4CAF50 (Light Green)
- **Background**: #F5F5F5 (Light Gray)
- **Surface**: #FFFFFF (White)

### Typography
- **Font**: Inter (Google Fonts)
- **Headings**: Poppins (for consistency with mobile app)

## Customization

### Adding New Pages
1. Create a new folder in `app/` with the page name
2. Add a `page.tsx` file with your component
3. Update navigation in the header component

### Styling
- Use Tailwind CSS classes for styling
- Custom CSS variables are defined in `globals.css`
- Follow the existing design patterns for consistency

### Content Updates
- Update recipe data in the home page component
- Modify FAQ items in the support page
- Edit privacy policy content as needed

## Deployment

### Vercel (Recommended)
1. Push your code to GitHub
2. Connect your repository to Vercel
3. Deploy automatically

### Other Platforms
The app can be deployed to any static hosting platform:
- Netlify
- AWS S3 + CloudFront
- GitHub Pages
- Any VPS with nginx

## Contact

For support or questions about this web app:
- **Email**: aprameyakannan@gmail.com
- **Response Time**: 24-48 hours

## License

This project is part of the CookingApp ecosystem. All rights reserved.

---

Built with ❤️ for cooking enthusiasts everywhere.
