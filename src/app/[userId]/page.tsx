import { auth } from "@/server/auth";
import { redirect } from "next/navigation";
import MyPage from "@/app/mypage/page";

interface UserPageProps {
  params: {
    userId: string;
  };
}

export default async function UserPage({ params }: UserPageProps) {
  const session = await auth();

  if (!session) {
    redirect("/login");
  }

  // 현재 로그인한 사용자의 ID와 URL의 userId가 일치하는지 확인
  if (session.user.id !== params.userId) {
    redirect("/");
  }

  // 실제로는 MyPage 컴포넌트를 렌더링
  return <MyPage />;
} 