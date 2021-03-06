﻿using System;

namespace Shapes
{
    public class Circle : Shape
    {
        public double Radius { get; set; }

        public Circle(double radius)
        {
            this.Radius = radius;
        }

        public override double CalculatePerimeter()
        {
            return (2 * Math.PI) * Radius;
        }

        public override double CalculateArea()
        {
            return Math.PI * (Radius * Radius);
        }

        public override string Draw()
        {
            return base.Draw() + " Circle";
        }
    }
}
