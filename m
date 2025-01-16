Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150972361E9;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=muZbBTtw/RIbFDVVJ6mb0FX2bcfL/3VC+6pFg6MEhzvi4OZw9oaHsd0uLljmHIbCVszddjKZNBpD0BWTlRC1tajYI//z/k78K+JLcYAGxixww+OzaffKZXggadIXQDBHlNKgL+CET0ISKdh+RTiC87epndgQU0/8QB2nti0JkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=OQ+//3UxqY/Z/CdiyljxSlA3+2EpSvXeHCw/6tWExb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UYMAuC0g5GG6ReNHmJGt85RgKXk8gU5FjRQ27Q0WFfrhq42XLEBgn7l9DpXMs5vcuHkc0xXbEHV7oKvEPgISTgkOpXV/9FJIie4mSjVN0VMc4bLpailhZpXBRbGxTypMd1TKNy5aWuxdzrZUISnBauPs+n+F7HWTl3xTH9Vf4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLPs4plT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLPs4plT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B002DC4CEE3;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058409;
	bh=OQ+//3UxqY/Z/CdiyljxSlA3+2EpSvXeHCw/6tWExb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLPs4plTRkg8eu+2kqIolyU8l+bLwkWQ+gYmOpaLtrvfk/BnN297A+cCi9MuCCVDP
	 9mX4Iv4jZLtaWZ8BQED6HSjXHSy3hWg71hcNOxkJ+LgrJwTbquKpAPEryrHa1wsUgb
	 PZGNgEhg36b2aIWDR+6IP949SoyK6xvg/q9ZIaJMmT/hQjC8lUuMiVu8rfvWQeIydi
	 wEV4QSuxwYJyt9Hphl78libZ+qmLNdsNVCECs2vK3Gp2xeyCgh9pRgq1Cn2Jo43zf3
	 bMH1HdZzw8ERSge4juNqTpKZxRyDha2PJK1JgEDXbhwZ1grmJdq89KfQkG3vNAdLHr
	 shB4XMUNkIogw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 51B84CE37B6; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/9] rcu: handle unstable rdp in rcu_read_unlock_strict()
Date: Thu, 16 Jan 2025 12:13:22 -0800
Message-Id: <20250116201327.3782963-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

rcu_read_unlock_strict() can be called with preemption enabled
which can make for an unstable rdp and a racy norm value.

Fix this by dropping the preempt-count in __rcu_read_unlock()
after the call to rcu_read_unlock_strict(), adjusting the
preempt-count check appropriately.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  2 +-
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c6c4aee47df2c..9b05db8ff0619 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -95,9 +95,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bb7ca6eb9ef04..b025e95ede053 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -833,8 +833,17 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || in_atomic_preempt_off() || !rcu_state.gp_kthread)
 		return;
+
+	/*
+	 * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+	 * from the local CPU.
+	 *
+	 * The in_atomic_preempt_off() check ensures that we come here holding
+	 * the last preempt_count (which will get dropped once we return to
+	 * __rcu_read_unlock().
+	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
-- 
2.40.1

