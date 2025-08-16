Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C82AE68;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302921; cv=none; b=sgmNR2u60pIZsh5k/FpThwyI87KWBuoNRgsEj7WC404V+ge9Y4Wp4V/jeVXTBpVnCu70gecukvoUWUhwttCvg8nnATV+g9KtsJ4SckXoEL5XxJVh0YpvP/9RGhGh+7+f1B9gRBFz0wtb6pj5DJtdlnpAn1DzGQhuwiO9sQ49trY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302921; c=relaxed/simple;
	bh=gE4Rji/8SJ+UEZVXQUf6+/Ok6DOW5KtjWyQ+ski3jFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLrSqfuqAZRzLSiN63s2SIcSQURO94yizR9Ih5cRZ9dWUXk3i4hoSHMkHXNqz4xcg2ml278vCjSMQmmGvbkOOsgDdR83eqt7/Tq8LJq4ztqkmBz5xuZD1bQGegGEJNfbrT7+WLpYx16LkBPkEAtUcz4K1oY59hcFbkSBJ1gLhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqfBJCEZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqfBJCEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C624C4CEEB;
	Sat, 16 Aug 2025 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302920;
	bh=gE4Rji/8SJ+UEZVXQUf6+/Ok6DOW5KtjWyQ+ski3jFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqfBJCEZihQj/iBL4EZ4cH5ZINwZArRGA28BiyakR/xh7Nmm/zpVlwSxUmRYLNBPn
	 6YbqoBuSk8pUnaDHhANmYorbzIpUUU0vijld56W5Ehy0a8FXbM8AfI335Dup7otkiy
	 coA564Hfxb9tDC/k+OOg8bg3qAJanRAcwFRoOp4JVJwRG12BHPUyXh75idqkbt+Ale
	 J8W4kyjBE1lgSbJDewpbgB7FnMdD2yD4WINvU8pv5DQ4Pnmwmo7fWeyjGFzcY/5B/u
	 ipa0cVw9a27eQg8pMmK+j9MoMrlf6T0CQ8feeSqaD5RGvqcgktKbEgJDFJ0xk32yN4
	 BxcNiifObvkAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 220BBCE10F4; Fri, 15 Aug 2025 17:08:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 7/7] rcutorture: Delay forward-progress testing until boot completes
Date: Fri, 15 Aug 2025 17:08:37 -0700
Message-Id: <20250816000837.2622858-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
References: <8758bcc6-901f-4828-b2fc-aa9f90e85451@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forward-progress testing can hog CPUs, which is not a great thing to do
before boot has completed.  This commit therefore makes the CPU-hotplug
operations hold off until boot has completed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1578d330565752..b8a684459381f2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3457,6 +3457,8 @@ static int rcu_torture_fwd_prog(void *args)
 	int tested_tries = 0;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fwd_progress task started");
+	while (!rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ / 10);
 	rcu_bind_current_to_nocb();
 	if (!IS_ENABLED(CONFIG_SMP) || !IS_ENABLED(CONFIG_RCU_BOOST))
 		set_user_nice(current, MAX_NICE);
-- 
2.40.1

