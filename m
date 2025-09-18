Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1E2F547D;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191395; cv=none; b=MmdpVWiALG60/KnIIxIs/1DxrhboLylFMMoYtdYCdStb9XcNq58X5Qp2KW7OZ/VTSaFFL9chXAWxc3WE0tea7Qpob5mddfUhg9XO1tUfC3las0XLMPb78eGPMJOnxeqRtFPZxH6Cdn/x9PjqcUbFtdhcj/x57ZqOWQkPVCFnXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191395; c=relaxed/simple;
	bh=gE4Rji/8SJ+UEZVXQUf6+/Ok6DOW5KtjWyQ+ski3jFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOeAXstMAeSavKa3FG3MdHYIglROuUMllub2wouzeiyVW+spYvhM7pEehJJuWJHa/x9lrxkfXP1utaMQN+tbWMVn4HEzGn8wmA9I10HxpS7ycPDLB29GrqmDWlR6rkcSYbejHkdsCZ+knuQYTfkls8zfKRae3wvCvLv09iHOdE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIViwuEX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIViwuEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A61DC4AF09;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191395;
	bh=gE4Rji/8SJ+UEZVXQUf6+/Ok6DOW5KtjWyQ+ski3jFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIViwuEXmwdCNUF+WLGTO3++WKGxHnF2I8VkZv8VX9wgn7ZAz3H2F73YBrBaTtay7
	 FpL+V7DxRRoqFA38MFKOQ282aols4vyUPBO6fqHUZphltERqiNHGxA4jOU1t1JAFrv
	 yYsvvFquQUgE8a2hg8VbCVzXUqv/AZlUHygmV+Qg6yH7VPokS1JI1Ju8v/Fep7+o4n
	 JsSXL1OJq5U/zupqxRKr3Lr5nxGJuDRwLPVzVBoSzx17cN1wjjyFDEeH3b1iPiuF/Y
	 mdgq9b6ikpqVLTJYlVzEt/IjezuN38Awz7Y6riiPpAkmLw4cR0S0zAZU/jglkzSiBz
	 eAgBsRcpXmjAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCA85CE10F9; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 07/11] rcutorture: Delay forward-progress testing until boot completes
Date: Thu, 18 Sep 2025 03:29:48 -0700
Message-Id: <20250918102952.2593045-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
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

