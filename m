Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D2306D5F;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330122; cv=none; b=ch4tswwvdUAxPRZ8eF55P2HkG0DHaoZPcLeaJG9yf+UhcKMH/DHdpgAADo3fcsM17fwVMrHjYbV0c7JzCeZv36rdSXAhBxjZuxU70IvX4nZfxY3GE62gWrLMiKt6pQpPgXrmGk/rjw0tZDxSJ1q/jGAjP+hDmS3Og6H7DKw7AMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330122; c=relaxed/simple;
	bh=5+6cap8BHuj7LD+F6jHOG4xWIftMKuTGrdQG1g1VuNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVBZlZcJVIReFHUkLeRIzLlqOv2iKed8tH5TzH6+9vt2BGdpo9R40bpSGMSYyJSIKgu5DgNoi23nmXkeGiIgF25MMO7rL8dbu7QO5HqSC1VYbEQqr0xowCEIcJN+Sp4A+N1wEeyLDJ3/4Voav3Rdq0BdbCenZYQUIhl5q7PDOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6DwVI9B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6DwVI9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB44C4AF0D;
	Wed,  1 Oct 2025 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330122;
	bh=5+6cap8BHuj7LD+F6jHOG4xWIftMKuTGrdQG1g1VuNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6DwVI9BxTl3oHt6mA0HcILf8ik6GGSoZ0OLMhSbPeoGtYBlGknaaIg6sYgLEEguR
	 wPtFMJUy87rjzytPd91EVFqoMrnOS0Yw64gp0VE0nDUS2jOQFZNfxQ+u6WeUaJYHN6
	 dZ1iz9q8Wi+AUUKU7bKpetA+ezX3VJX8XKptL919h58Bgs798QdmpIGLyVsNHi2qdi
	 JtazPj6Fx34F4JOxe1x1gYbpEfNcdMUlbuFiz2iyCaTFjPipUCs42ItPGJCDizjE0x
	 wQERutENschQzUoKLXZLgF0YvesXC6RK02dOW9wfpP8j6z7/hSNkqEJk9WDDgUoFDf
	 JUcGle4fbQ2ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 970E1CE158E; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 21/21] rcu: Mark diagnostic functions as notrace
Date: Wed,  1 Oct 2025 07:48:32 -0700
Message-Id: <20251001144832.631770-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
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
index 31690ffa452afe..8ddd07fed36334 100644
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
index c912b594ba987f..dfeba9b3539508 100644
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

