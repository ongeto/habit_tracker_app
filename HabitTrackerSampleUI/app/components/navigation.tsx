"use client"

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { Home, User, PlusCircle, BarChart2 } from 'lucide-react'

const navItems = [
  { href: '/home', icon: Home, label: 'Home' },
  { href: '/stats', icon: BarChart2, label: 'Stats' },
  { href: '/profile', icon: User, label: 'Profile' },
]

export function Navigation() {
  const pathname = usePathname()

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200">
      <div className="flex justify-around items-center h-16">
        {navItems.map(({ href, icon: Icon, label }) => (
          <Link
            key={href}
            href={href}
            className={`flex flex-col items-center justify-center w-full h-full ${
              pathname === href ? 'text-blue-600' : 'text-gray-600'
            }`}
            aria-current={pathname === href ? 'page' : undefined}
          >
            <Icon className="h-6 w-6" aria-hidden="true" />
            <span className="text-xs mt-1">{label}</span>
          </Link>
        ))}
        <Link
          href="/create-habit"
          className="flex flex-col items-center justify-center w-full h-full text-blue-600"
        >
          <PlusCircle className="h-6 w-6" aria-hidden="true" />
          <span className="text-xs mt-1">New Habit</span>
        </Link>
      </div>
    </nav>
  )
}

