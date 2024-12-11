"use client"

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import Layout from './components/layout'

export default function SplashScreen() {
  const router = useRouter()

  useEffect(() => {
    const timer = setTimeout(() => {
      router.push('/login')
    }, 3000)

    return () => clearTimeout(timer)
  }, [router])

  return (
    <Layout>
      <div className="flex flex-col items-center justify-center h-screen">
        <div className="w-24 h-24 bg-blue-500 rounded-full animate-pulse mb-4"></div>
        <h1 className="text-3xl font-bold text-blue-600 mb-2">HabitTracker</h1>
        <p className="text-gray-600">Cultivate positive habits, one day at a time</p>
      </div>
    </Layout>
  )
}

