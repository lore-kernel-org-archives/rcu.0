Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129113B783;
	Fri, 16 Aug 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791082; cv=none; b=MOUJvSM33Z4hErcu6UE100JlnZySCM6tT8KQMjvVzO4uxDI+4HTk8/FOuNUM6cR/1rdj+63NkjXgfckVoEsnBJ8QaoKlfbG+BoTioEHNpNBR4p84YgHPQxugk+y4CzNZbgxt18hlLEn/TYKMODQ5HKxGQZ/105PoGEYBfi02nDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791082; c=relaxed/simple;
	bh=7Xy0bxjgRFCmWJzteGxUb/ixG8Cfyekq5uFhtPDLC6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTdsC9SmBfKzIT4HX8dVukjGf/7srULWIy6HkNNMqp6MrKwifCvvUwLldphEl5qUbDMhwmUtf22M1T4fcU6E+I5IC0CcVqYvGy31Gxm9oGj3jGmZSsFaFOOTuZbQAFeujpPJdOf8/tJ+Q6woLnM8PUq/ikknVNct6xQjg9RiyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbSmrq1R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbSmrq1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AF9C32782;
	Fri, 16 Aug 2024 06:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791082;
	bh=7Xy0bxjgRFCmWJzteGxUb/ixG8Cfyekq5uFhtPDLC6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbSmrq1RDIAuTG17t/CA5X3mHTHDEb95mUeeZwTSa4l4jxRjvdCi4EDuXQn2oRxeL
	 PQLX1vtBPko4iTsQLBErWZbFWI6SboD+utowuaKvMJbKaDA2/uYG1eldkYilwsDGq0
	 dXYOPkOVANsCsmIeHksgCVlFlr1qGIJVWbMXtSOPsXeP5S2jzTVD65aTOHWraqLb8T
	 Giire4YMzybzR9EbybDOq65j49qULhiZLqoCNiWrfTWyf+hhzOi8fAvK9a3CgP84hw
	 uIZARzRpxeUoY3pconbn0OIxudoyOaz2DBhjT1HZEetwzJ5QJsSn60qV4f9WUjFU6G
	 aQ505Xut1UvWA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 08/12] rcu/tasks: Update rtp->tasks_gp_seq comment
Date: Fri, 16 Aug 2024 12:19:17 +0530
Message-Id: <20240816064921.57645-8-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rtp->tasks_gp_seq grace-period sequence number is not a strict count,
but rather the usual RCU sequence number with the lower few bits tracking
per-grace-period state and the upper bits the count of grace periods
since boot, give or take the initial value.  This commit therefore
adjusts this comment.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9fb8bb0afff7..127018280618 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -65,7 +65,7 @@ struct rcu_tasks_percpu {
  * @init_fract: Initial backoff sleep interval.
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
- * @tasks_gp_seq: Number of grace periods completed since boot.
+ * @tasks_gp_seq: Number of grace periods completed since boot in upper bits.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
  * @n_ipis_fails: Number of IPI-send failures.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
-- 
2.40.1

