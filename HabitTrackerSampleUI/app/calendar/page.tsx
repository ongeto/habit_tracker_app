"use client"

import { useState } from 'react'
import Layout from '../components/layout'
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Calendar } from "@/components/ui/calendar"

export default function CalendarScreen() {
  const [date, setDate] = useState<Date | undefined>(new Date())

  // Mock data for completed habits
  const completedDates = [
    new Date(2023, 5, 1),
    new Date(2023, 5, 2),
    new Date(2023, 5, 5),
    new Date(2023, 5, 7),
    new Date(2023, 5, 8),
    new Date(2023, 5, 9),
    new Date(2023, 5, 12),
    new Date(2023, 5, 15),
    new Date(2023, 5, 18),
    new Date(2023, 5, 19),
    new Date(2023, 5, 22),
    new Date(2023, 5, 25),
    new Date(2023, 5, 28),
  ]

  return (
    <Layout>
      <div className="max-w-md mx-auto">
        <Card>
          <CardHeader>
            <CardTitle className="text-2xl font-bold text-center text-blue-600">Habit Calendar</CardTitle>
          </CardHeader>
          <CardContent>
            <Calendar
              mode="single"
              selected={date}
              onSelect={setDate}
              className="rounded-md border"
              modifiers={{
                completed: completedDates,
              }}
              modifiersStyles={{
                completed: { backgroundColor: '#4ade80', color: 'white' },
              }}
            />
          </CardContent>
        </Card>
        <div className="mt-4 flex justify-center items-center space-x-4">
          <div className="flex items-center">
            <div className="w-4 h-4 bg-green-400 rounded-full mr-2"></div>
            <span className="text-sm text-gray-600">Completed</span>
          </div>
          <div className="flex items-center">
            <div className="w-4 h-4 bg-gray-200 rounded-full mr-2"></div>
            <span className="text-sm text-gray-600">Not Completed</span>
          </div>
        </div>
      </div>
    </Layout>
  )
}

