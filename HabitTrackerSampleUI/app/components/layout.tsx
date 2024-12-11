import { Inter } from 'next/font/google'
import { Navigation } from './navigation'

const inter = Inter({ subsets: ['latin'] })

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <div className={`min-h-screen bg-gray-100 ${inter.className}`}>
      <header className="bg-blue-600 text-white py-4 px-4 shadow-md">
        <h1 className="text-xl font-bold">HabitTracker</h1>
      </header>
      <main className="container mx-auto px-4 py-6 pb-32">
        {children}
      </main>
      <Navigation />
    </div>
  )
}

