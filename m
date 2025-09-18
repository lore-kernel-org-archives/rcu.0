Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8D2F5A19;
	Thu, 18 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191208; cv=none; b=CNe5ntobzOuefElkR0W0YKPXT1lOYV9po6Qq+qH7Vlp6oS5mbmG6HbErH5uoAhh8V0nf7mYFC/kA1pg7jWf5DMnhHNurYzmXpvk+LstemdiYTLChvKTZhhsCFbRXPUr6iHJypyYx3oaDBNvGhO5Uqwj3KjlpB4Mp9GvoTkc1qgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191208; c=relaxed/simple;
	bh=2O4JbyeyNOFGCtQWseGjahocWyWME/uonyjbz+Ok46w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVUBtAN/dEeHVllGazfAZsPUQce4bhIZ345QbCF7QKIBTwF0XAw+9n32h7YTVtc6misfokhJlV5SRMYInAoFaLlJ8YR2qNvNb3LrVGTptX/ybU8Tbsz2SKL+iZlEyGJ6rhiqlGtbGhYxYKkqDZoaR2kkYmhbi+8+68ntXGK4GtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwImpqaX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwImpqaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EF7C4CEFB;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191208;
	bh=2O4JbyeyNOFGCtQWseGjahocWyWME/uonyjbz+Ok46w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwImpqaXeSqK7RNRa7Xs5c/p1sbAcyEksae+NZZqwBK7/ed5JP33ZZDjt9u7OU8C5
	 hnGl9vaK4zdFvuwyolTM3Yi1uxg7HhaLuKZCDxAuHx+aZiOxEAvhTo8bCy6XLtZ/1p
	 wXxvvoO7qREp+kc9Y+VBWmXGN2nY6C4pQt9NtiF1+cf90CCVx1Ve9BVJv78JHRvGDZ
	 Nc23trUlBcASrsMUBZtCcEc4fZkWc/SgGeP7No+6RsH8Ez4MP9EBh+D/giw5TCncTD
	 VpDFl0S3ymeJ7XIdfXuoQIZcgFid2wewM9EvOTGqapryy7bcGUAhcm9Emf8Q4tRpRG
	 6IZ7t3bySBCvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F169CCE10DB; Thu, 18 Sep 2025 03:26:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 6/6] srcu/tiny: Remove preempt_disable/enable() in srcu_gp_start_if_needed()
Date: Thu, 18 Sep 2025 03:26:46 -0700
Message-Id: <20250918102646.2592821-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
References: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

Currently, the srcu_gp_start_if_needed() is always be invoked in
preempt disable's critical section, this commit therefore remove
redundant preempt_disable/enable() in srcu_gp_start_if_needed()
and adds a call to lockdep_assert_preemption_disabled() in order
to enable lockdep to diagnose mistaken invocations of this function
from preempts-enabled code.

Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 6e9fe2ce1075d5..e3b64a5e0ec7e1 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -176,10 +176,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_LAZY
+	lockdep_assert_preemption_disabled(); // Needed for PREEMPT_LAZY
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
-		preempt_enable();
 		return;
 	}
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
@@ -189,7 +188,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
-	preempt_enable();
 }
 
 /*
-- 
2.40.1

