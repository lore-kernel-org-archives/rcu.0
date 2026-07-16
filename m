Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343726A08F;
	Thu, 16 Jul 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161424; cv=none; b=pXbE53k3Alie4kXaJme6A/d1FHfp+dHelauShzTesrhVSUKeDdpT4Wpdycsn1xsfdo7fQDt0jdwD24HL4+cADMAj2nuHErScV/NtbMpdOwUNd/5POtei0iIm0Z5SMxwC9pHsvIMd1KkrvuYrOXs24GbjpI4hcf6CF7PN2196cQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161424; c=relaxed/simple;
	bh=4jgfWSLikRl+xWI4uR47lD18fbt/PJOvWfRxbxP4RVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKVilWE+T8QTTOb4e9gI2xTfBkQzUw83qQuAJYN3dsZ0dUMjjPp0kUsU3bP54PeZ9KMnGCHVnWN1Z1ewCfZsxZdRycnHnlUPMJ+BUGXPO6nSchgWs5WzvUhNEg5l2MOoK6880BAT2LQc+rATeiF0tdHe2k+SzOAfXr4K5TPqm4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXfKpjSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXfKpjSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D581F01558;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=+mEC86hot4V+7/tf7mFraSyiFAtQI54l1HezUFxzJGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oXfKpjSMdHCUduckooQW+IoOHw+JlfZkM9Zs66xhm68B2gefUU3Eo8Ay69F/fQKH8
	 FZEBL4kOP7muY3XKu2Xu3bHswThIEWQwtp7qOw0kBQoPGrsj7bBaHeB/W5cWXxLc/g
	 FqArb4PERJEOOez6QGyMPPRelNYBJXrCs+u0yINikIh4xJ0AgO/AcaBKlMlXagNVS7
	 EB164RoxAaJKYDOWnj/WoAqCi86DKRAubv0pwNhehkPThvoXvGqbn978a8YHtYzkG8
	 GEQjPt7/n46vagKa+8TqvZgEFNgJVLLZwTDKvQKPvIb0ZRPTA5KILWrpcx54LRv2tG
	 i1N68VvUKfgCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 057EBCE0E2A; Wed, 15 Jul 2026 17:23:41 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 08/10] rcu-tasks: Apply READ_ONCE() and WRITE_ONCE() to fix data race
Date: Wed, 15 Jul 2026 17:23:37 -0700
Message-Id: <20260716002339.11717-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that rcutorture tests readers from interrupt handlers, KCSAN spotted
an additional data race.  This commit therefore fixes it by applying
READ_ONCE() and WRITE_ONCE().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index cee89e51e45cbb..fd3ddeb6aa3bd2 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -95,10 +95,13 @@ static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
  */
 static inline void rcu_read_lock_trace(void)
 {
+	int n;
 	struct task_struct *t = current;
 
 	rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
-	if (t->trc_reader_nesting++) {
+	n = READ_ONCE(t->trc_reader_nesting);
+	WRITE_ONCE(t->trc_reader_nesting, n + 1);
+	if (n) {
 		// In case we interrupted a Tasks Trace RCU reader.
 		return;
 	}
@@ -119,12 +122,15 @@ static inline void rcu_read_lock_trace(void)
  */
 static inline void rcu_read_unlock_trace(void)
 {
+	int n;
 	struct srcu_ctr __percpu *scp;
 	struct task_struct *t = current;
 
 	scp = t->trc_reader_scp;
 	barrier();  // scp before nesting to protect against interrupt handler.
-	if (!--t->trc_reader_nesting) {
+	n = READ_ONCE(t->trc_reader_nesting) - 1;
+	WRITE_ONCE(t->trc_reader_nesting, n);
+	if (!n) {
 		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
 			smp_mb(); // Placeholder for more selective ordering
 		__srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
-- 
2.40.1

