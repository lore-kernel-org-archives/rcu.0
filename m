Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFB34B1A3;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=lNu2xDmxh7aU4nxd7B0uV/gA5xuKJ0X/ZjfqzAGlYccXNEyoV4Chi24CcycURCXEXbBuEXbeo4yv35d/euS8aSR0cUFnfVA2GE5X5Zsz/rG/AzFbUJlA3qf9DK28aIp5HBLwpvy/8B1PPSawSc9wjZVXpIj5kQTa0Q5lSaRGYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=BK4yD7eyeQ0mHbL7KbeZ8Mx12t+bQxDXJ6lt6IBpXBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F388LORCc04P/wM2WCcqKJuOz+b4gO5Sy275UCg5xpkC9yS253R4Ujshif5V/uLDdu6Xim/edyo+2S6Mn/Xf0sj1rYzRiZ/Cai7cuBTvmjvtrzUpBXzRe+389XzrMbs+W+20XVve6Loq5ebZe1GkmGjc0Jt007l+9n1qarIPo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAvkoYk2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAvkoYk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7263BC116C6;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=BK4yD7eyeQ0mHbL7KbeZ8Mx12t+bQxDXJ6lt6IBpXBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAvkoYk2CcJVzgorkbzUvypit15MwLpUqJl/7tfiunIa12HGN5nZgFfkphZhk2KEu
	 jfODpm1TqXr6qQzQ0AuTlMwkQ/uqj6GE7uXaoJvAjRWbbNzY45GHVkczETgoEbVdPV
	 1rucAZpM7ChQ6Wuo5gZBLApOaupy3wsh7yvylFbeFcTNnfN3co3HtEffizhBD3qcAt
	 VEszxKC9IO1QKa51+tjuYUF2z89qyGbilox7Do0yjyR3F8bXjeisshIWj1bXXUvJL2
	 e26umtlPglL9G16iTKEo7nJBX2vpuGgaGvChJwZ94JXy19utTaxin9FqV0hLlNN5c2
	 ba2/5UlwhCnOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A133ACE0F8F; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 11/16] rcu: Mark diagnostic functions as notrace
Date: Wed,  5 Nov 2025 12:32:11 -0800
Message-Id: <20251105203216.2701005-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_lockdep_current_cpu_online(), rcu_read_lock_sched_held(),
rcu_read_lock_held(), rcu_read_lock_bh_held(), rcu_read_lock_any_held()
are used by tracing-related code paths, so putting traces on them is
unlikely to make anyone happy.  This commit therefore marks them all
"notrace".

Reported-by: Leon Hwang <leon.hwang@linux.dev>
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c   | 2 +-
 kernel/rcu/update.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31690ffa452a..8ddd07fed363 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4021,7 +4021,7 @@ bool rcu_cpu_online(int cpu)
  * RCU on an offline processor during initial boot, hence the check for
  * rcu_scheduler_fully_active.
  */
-bool rcu_lockdep_current_cpu_online(void)
+bool notrace rcu_lockdep_current_cpu_online(void)
 {
 	struct rcu_data *rdp;
 	bool ret = false;
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c912b594ba98..dfeba9b35395 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -117,7 +117,7 @@ static bool rcu_read_lock_held_common(bool *ret)
 	return false;
 }
 
-int rcu_read_lock_sched_held(void)
+int notrace rcu_read_lock_sched_held(void)
 {
 	bool ret;
 
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
  * Note that rcu_read_lock() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_held(void)
+int notrace rcu_read_lock_held(void)
 {
 	bool ret;
 
@@ -367,7 +367,7 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_held);
  * Note that rcu_read_lock_bh() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_bh_held(void)
+int notrace rcu_read_lock_bh_held(void)
 {
 	bool ret;
 
@@ -377,7 +377,7 @@ int rcu_read_lock_bh_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
-int rcu_read_lock_any_held(void)
+int notrace rcu_read_lock_any_held(void)
 {
 	bool ret;
 
-- 
2.40.1

