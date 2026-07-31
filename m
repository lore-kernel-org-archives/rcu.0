Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D922F12AC;
	Fri, 31 Jul 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460045; cv=none; b=EYrEEFVxr0yTZxFkBspHVOJxe+ok17u7mSKN8J7FmQ9Fkh373Z6zRjKSnIEIFkpbtYkCDDjtHyI584lC733zZzUFktyV1eQ53zXDyA7fQDBuhUogZQcQcPjAP/ZZLOujLdlMWST+XxT2WmyOXPGRi1tMzo84f5gjb55hRM0jwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460045; c=relaxed/simple;
	bh=BB5sW4xR5cpKTwcmvKnd6sfUwur4VOAHzm+2rCO3EU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fa+bGw7nB/uuZFlDbdeX01/e+L5lFJ0NCzBNeODo3kKaTgq9TCyYTkj1asLbCzU6oNIWgRLY+oQuC37izOxmBn58YD64UQYpYoHijGHE3tDDzh3ed1nTmySwguERotg0oKpF5eSIcfwtLKI1VSn2ACbAMc1Psmf/WL+DHY/9bgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtSoeuld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtSoeuld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD2D1F0155C;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460041;
	bh=qt6e3ZgbAv+xQA516URUtKOKW8d2o3oi46XTeo6iNws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DtSoeuldACLUdyjjxqI2YrvTVU3W+Ax1ZWV3VvkzTD6SdZCHKONlkAJd2AZ5oeJtQ
	 E/1+gzp9MYUR7SGvkhGMxXc+y4nHuLULGHK7oo3kVv9ME5nV//LBqFQWJ96bybPgS2
	 kom1zqi7Vj8m47baY/PwLp6iYcSy47mzw1KkU5YhpgK0vhxFOg8RxFLom+7Ra0sj+4
	 GcSy0m8AsVUyh35NXcy5GavZ+/7fWrX1bFdVp5JttllgKHDi0kTIVYhNahq8hfNXLU
	 9Zffsz/GsqhhQK8Fev+p9XOxsiP1x5zv9EVL7V66Tz2tZWc1odxpo6vww2U2B27kKK
	 Tl4llbt27LYsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A0729CE19A4; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 13/13] rcutorture: Make {,s}rcu_read_delay() better handle forward-progress testing
Date: Thu, 30 Jul 2026 18:07:19 -0700
Message-Id: <20260731010719.3531912-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_read_delay() and srcu_read_delay() functions are suppose to
avoid (or at least to minimize) read-side delays during call_rcu()-based
forward-progress testing.  Although rcu_read_delay() does account for
this by testing rcu_fwd_cb_nodelay, it only does so in some cases, and
srcu_read_delay() does not bother at all.  And rcutorture testing does
occasionally turn up the MIN_FWD_CBS_LAUNDERED failure when running
forward-progress tests on Tree SRCU flavors.

This commit therefore makes both rcu_read_delay() and srcu_read_delay()
take an immediate exit if rcu_fwd_cb_nodelay is set.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 46d97055c2fcde..9c7b293d1cafbd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -469,12 +469,14 @@ rcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	unsigned long longdelay_ms = 300;
 	unsigned long long ts;
 
-	/* We want a short delay sometimes to make a reader delay the grace
-	 * period, and we want a long delay occasionally to trigger
-	 * force_quiescent_state. */
+	// If there is a forward-progress test in flight, don't delay.
+	if (atomic_read(&rcu_fwd_cb_nodelay))
+		return;
 
-	if (!atomic_read(&rcu_fwd_cb_nodelay) &&
-	    !(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
+	// We want a short delay sometimes to make a reader delay the grace
+	// period, and we want a long delay occasionally to trigger
+	// force_quiescent_state.
+	if (!(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
 		started = cur_ops->get_gp_seq();
 		ts = rcu_trace_clock_local();
 		if ((preempt_count() & HARDIRQ_MASK) || softirq_count())
@@ -766,6 +768,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	const long uspertick = 1000000 / HZ;
 	const long longdelay = 10;
 
+	// If there is a forward-progress test in flight, don't delay.
+	if (atomic_read(&rcu_fwd_cb_nodelay))
+		return;
+
 	// We want there to be long-running readers, but not all the time.
 	// The !rcu_preempt_depth() is for RCU Tasks Trace.
 
-- 
2.40.1

