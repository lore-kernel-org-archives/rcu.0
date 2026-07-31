Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057B2DEA86;
	Fri, 31 Jul 2026 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459847; cv=none; b=llVY9f0bO81QevwRkFVjcROx7T1sl44IW1coCZru8Bc12barrh2TEWwYxxIneKcvqpXumMQsXgZeAwKRd0Mr4rMrOuZJZLAeuIP3EDi2jhZ//9CsZhyeK52kNZzrxYI+dU0IA4shv2M9ZyggzT608eB6Bjh3vaKveEHtcV3niUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459847; c=relaxed/simple;
	bh=jk/3LupnUbkgwyeTdBT3jbri03SneHqbqDFyGn7XhbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NxHDBLog76MyL8rk3BHojDrU+zwogihLxmDUoGFfPB9Xkt6Jo7DrnSw73hXupDldwIeAG6emORUUSg2zNuxO0ANfMOr5Na/1Jcmk5NBqUy61Vm9KIv9TYz7ybFWAqrq483q8/iihQRFqPxwG0TK2X6eiX/fhS/5TCNK6B9J+tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH8CYFKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH8CYFKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EE41F00ADF;
	Fri, 31 Jul 2026 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459844;
	bh=Qr0BZEAvHLD5EZAEoOzzrj7YVcEO6epGSKpP9H+vH8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GH8CYFKHvJdPy286y5/UKGyUXt6N5zcNbl90VUizWAy3uDQOYCQedMuxD/dU4FtE6
	 gpjJoXwb3bRPEYBdDxguxOJ9P0YCwwTxxIZ0rkPlyzgs0t2AxjvXjpNlXxID35NRzD
	 cIkm4a/DS6q8iIf3e79XGBh87IgdSMhO3v4/pP24zOrhNMZVL2Xk/lfZ4QPDzOCRTN
	 nMFe5mlJwbfwSLpB++EwwLn+V0c/Mc/J0v5VidSMNaVh2cjYksMweJbDRkBlQu9tzl
	 EwoYUbSHCOaLJHc7ajtTYvxOwJlZnfVgDG6j09C6aD5FgfZBr8azSfYSaxmWksvJDv
	 E25rZrgaYdWKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1B4DCE14DB; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 10/10] rcu-tasks: Fix some comments for call_rcu_tasks() and call_rcu_tasks_rude()
Date: Thu, 30 Jul 2026 18:04:01 -0700
Message-Id: <20260731010401.3531631-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The comments for call_rcu_tasks() and call_rcu_tasks_rude() referred
to "RCU read-side critical sections", which is ambiguous. specify
"rcu-tasks" and "rcu-tasks rude" respectively to match the actual
flavor being described.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fce57d90db1a60..851ac225770c78 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1179,7 +1179,7 @@ static void tasks_rcu_exit_stall(struct timer_list *unused)
  * @func: actual callback function to be invoked after the grace period
  *
  * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
+ * period elapses, in other words after all currently executing rcu-tasks
  * read-side critical sections have completed. call_rcu_tasks() assumes
  * that the read-side critical sections end at a voluntary context
  * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into idle,
@@ -1365,8 +1365,8 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * @func: actual callback function to be invoked after the grace period
  *
  * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks_rude()
+ * period elapses, in other words after all currently executing rude
+ * rcu-tasks read-side critical sections have completed. call_rcu_tasks_rude()
  * assumes that the read-side critical sections end at context switch,
  * cond_resched_tasks_rcu_qs(), or transition to usermode execution (as
  * usermode execution is schedulable). As such, there are no read-side
@@ -1390,7 +1390,7 @@ static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
  *
  * Control will return to the caller some time after a rude rcu-tasks
  * grace period has elapsed, in other words after all currently
- * executing rcu-tasks read-side critical sections have elapsed.  These
+ * executing rude rcu-tasks read-side critical sections have elapsed. These
  * read-side critical sections are delimited by calls to schedule(),
  * cond_resched_tasks_rcu_qs(), userspace execution (which is a schedulable
  * context), and (in theory, anyway) cond_resched().
-- 
2.40.1

