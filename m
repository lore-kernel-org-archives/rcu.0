Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFA3815D9;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406766; cv=none; b=sT+zeUCEmo2QI8CXk2iSIY65jXsMjtzUOe/+zQ1J+mAbHs6IScunolLYzk3HQ8vR8AAHeDAI5+ZyTexFsD8rLjjg5wRJ//G5fWvQwlA3l0c47gLff4ZDZ4oH7Q2Y929u8KFTJ7/64w8iRat6zCfAn4rBSv1b1hDMc7gSsyStIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406766; c=relaxed/simple;
	bh=J0wYQ50gsUU0Ru89vem3fIl3bxPR7s2bo6Pn3zVgVf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcTXYqEBVgQ8j3a0D3DNO5b+nUlacRDjo6mnWLnnP7BzQrLGdugpNR0TkgUaIzazBh47nZcXEYyWxtdhhBaaIs0LJaA/cM2E/Rz27lAp+u0hdrPRG+GHHcDXuooS2eo1ps05rbcnA28JBJe71WGGy6A2PP8nT7vea3RbPJZRQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfBHDMiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfBHDMiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484421F000FF;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=HlLTms0SIrGtX0vl91J1YxHZxSv2uke6WEWJX0uQFn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfBHDMiCnWGQOEN/bC6NC0KHhuQsbzZ7WDBTCxw7U7EC4XfnEuEbtcJfNoXpidTpa
	 SIqFJtrviXdwI/4HnEEjAoxdalg/5eS1eAumc5a0tgFZYxVZla577+3gYx85VeD3Lq
	 qPffkcpc7lO2MjcSKhRy3pjYQdiWwMdU+8QoUOhAo7EW8oKjYGikX8qfzP8rXphpIB
	 O3lq9oSMa5nPIgsR/fZs1hDx4CmdElUKsqj0lq1NvkKAmwYEk3hHPt+QSilOlHndqO
	 NwZ7Y1pfdES4HD7mTQu6V9LxT1bZtHVtytc0lfcus9N1+Y4Y77686QoDe3U5DFrER/
	 yL3uZhIyq/kxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 10BD4CE0D79; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 01/21] srcutiny: Make a Tiny SRCU grace period imply an RCU grace period
Date: Wed,  7 Oct 2026 13:59:04 -0700
Message-Id: <20261007205924.1983367-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In non-preemptible kernels, a Tiny SRCU grace period implies an RCU
grace period because any context switch suffices.  But in preemptible
kernels, it is possible for a Tiny SRCU grace period to elapse without
a corresponding RCU grace period.

Which was OK until RCU Tasks Trace was re-implemented in terms
of SRCU-fast, which in Tiny SRCU is implemented as SRCU, which is
already fast.  And RCU Tasks Trace grace periods are required to imply
RCU grace periods.  This commit therefore adds a synchronize_rcu(),
but only in preemptible kernels.

Because preemptible Tiny SRCU is not in mainline, this added call to
synchronize_rcu() will not slow anything down:  The comparison would
instead be with TREE SRCU.  But if this added call ever becomes a problem,
the Tiny SRCU srcu_struct structure could track whether or not this is for
SRCU-fast, and to add the synchronize_rcu() only in the SRCU-fast case.
However, at the moment, this is seen as unnecessary complexity.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutiny.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 5de9a69058383..32b37d63d58aa 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -159,6 +159,8 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
+	if (IS_ENABLED(CONFIG_PREEMPTION))
+		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period
 	do {
 		// Deadlock issues prevent __srcu_read_unlock() from
 		// doing an unconditional wakeup, so polling is required.
-- 
2.40.1

