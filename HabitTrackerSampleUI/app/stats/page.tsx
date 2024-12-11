"use client"

import { useState } from 'react'
import Layout from '../components/layout'
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Calendar } from "@/components/ui/calendar"
import { PieChart, Pie, Cell, ResponsiveContainer, Legend } from 'recharts'

const habitCategories = [
  { name: 'Health', value: 35, color: '#FF6384' },
  { name: 'Productivity', value: 45, color: '#36A2EB' },
  { name: 'Personal', value: 20, color: '#FFCE56' },
]

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

export default function StatsScreen() {
  const [date, setDate] = useState<Date | undefined>(new Date())

  return (
    <Layout>
      <div className="space-y-6">
        <Card>
          <CardHeader>
            <CardTitle className="text-xl font-bold text-blue-600">Habit Categories</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={200}>
              <PieChart>
                <Pie
                  data={habitCategories}
                  cx="50%"
                  cy="50%"
                  labelLine={false}
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {habitCategories.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={entry.color} />
                  ))}
                </Pie>
                <Legend />
              </PieChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-xl font-bold text-blue-600">Habit Calendar</CardTitle>
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
            <div className="mt-4 flex justify-center items-center space-x-4">
              <div className="flex items-center">
                <div className="w-4 h-4 bg-green-400 rounded-full mr-2" aria-hidden="true"></div>
                <span className="text-sm text-gray-600">Completed</span>
              </div>
              <div className="flex items-center">
                <div className="w-4 h-4 bg-gray-200 rounded-full mr-2" aria-hidden="true"></div>
                <span className="text-sm text-gray-600">Not Completed</span>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </Layout>
  )
}

