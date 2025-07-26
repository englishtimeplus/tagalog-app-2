# Stage 1: Dependencies and Build
FROM node:18-alpine AS builder

WORKDIR /app

# Install libc6-compat for some Node.js dependencies
RUN apk add --no-cache libc6-compat

# Copy package.json and lock files
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./

# Install production dependencies (and dev dependencies in a separate step if needed for build tools)
RUN \
  if [ -f "yarn.lock" ]; then yarn install --frozen-lockfile; \
  elif [ -f "package-lock.json" ]; then npm ci; \
  elif [ -f "pnpm-lock.yaml" ]; then pnpm install --frozen-lockfile; \
  else npm ci; \
  fi

# Copy the rest of the application code
COPY . .

# Build the Next.js application
# Ensure 'output: "standalone"' is set in next.config.js
RUN npm run build

# Stage 2: Production Runtime
FROM node:18-alpine AS runner

WORKDIR /app

# Set the NODE_ENV to production
ENV NODE_ENV production

# Copy the standalone output from the builder stage
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/public ./public
# If you have static assets in .next/static that aren't included in standalone, copy them
COPY --from=builder /app/.next/static ./.next/static

# Expose the port Next.js will run on
EXPOSE 3000

# Command to run the Next.js application in standalone mode
CMD ["node", "server.js"]