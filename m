Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006612C21F7;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459845; cv=none; b=SqLjzM8In0PN+oXi22WyQc8r71Rj5ZiyrBzLZ8MoPh6NIlJam2u9sxi78pNFn4xmKSda0Z/UVyw5y1/chJ9ryj0xxEeLmJgoMSdb+/vuj4w7nVpOzHEkiaY7fFbJQoRvveu5lGw2820VOkxMikUOnMLcEnRQyYBYRndHZUekQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459845; c=relaxed/simple;
	bh=jlKsbYmNXw2mKKfpRSL8s+FINdKeIGc0OWQxAvSpyOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzVArF9lKTo84e+AgpPLKEB0cQ3tr6GKTgP6KLBzxdZgxbeWKZIje+R8vXvidGWfRwSHNTmpZReyCUhv6mDd8wLVYrRrpOVQd/KfFMk0JviZDTFMJCMyCjNwxui65s8FrI3Oz7kahyrr1bOM26hwo8+a95y1EU/D9LXdEMK450w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU2IEj+K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU2IEj+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE2B1F00A3E;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459843;
	bh=j4QeWZr5VIw92nE193Im+u0gBQiE/2LIDQgcCKVG+x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dU2IEj+KQu9W3noXGiXJZQQA4HNudV3xh2TLRwU1VNt5b4k2SobRvrRoo9GsqJyzw
	 7KFPsTZeovvRfu6kpmwWrXySFVXkFUKqv9nwmo1pJFZ6dMqKY+Dgwh/byLU+gXrM44
	 1MunfzgrYBUrofmwfcWogEpo6VZuo6hHRWUELgoHXDCMjyJ5zPiamFoKluFq+jUyQr
	 R8oyoy53LcM/3ItAQqLREuKHd3teZaxOckkCUppeLMWPK1l8+9AoWlJi+3zgZyyI1J
	 20eMD5J8KNbyZNNtJ4pPuJpwg+AQ2Ju7cM9NpieQHLMlZ/cScVOxWQihwp3ricOK4e
	 Tku+IkW4f+vWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F5DCCE0F7B; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 03/10] rcu-tasks: Dump rcu tasks status when the boot-test failed
Date: Thu, 30 Jul 2026 18:03:54 -0700
Message-Id: <20260731010401.3531631-3-paulmck@kernel.org>
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

This commit adds a dump RCU task status function to rcu tasks tests,
used to obtain more information to help debug when the RCU tasks
boot-time tests failed.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7f7d1e6362178a..d9e1e53f4ccf31 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1453,6 +1453,7 @@ struct rcu_tasks_test_desc {
 	const char *name;
 	bool notrun;
 	unsigned long runstart;
+	void (*gp_dbg)(void);
 };
 
 static struct rcu_tasks_test_desc tests[] = {
@@ -1460,6 +1461,8 @@ static struct rcu_tasks_test_desc tests[] = {
 		.name = "call_rcu_tasks()",
 		/* If not defined, the test is skipped. */
 		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
+		/* Dump rcu tasks status, if test failed. */
+		.gp_dbg = show_rcu_tasks_classic_gp_kthread
 	},
 	{
 		.name = "call_rcu_tasks_trace()",
@@ -1519,6 +1522,8 @@ static int rcu_tasks_verify_self_tests(void)
 		while (tests[i].notrun) {		// still hanging.
 			if (time_after(jiffies, tests[i].runstart + bst)) {
 				pr_err("%s has failed boot-time tests.\n", tests[i].name);
+				if (tests[i].gp_dbg)
+					tests[i].gp_dbg();
 				ret = -1;
 				break;
 			}
-- 
2.40.1

