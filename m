Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469C235C15;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631892; cv=none; b=kG8uT+feaHi946U2e03WUGTMxMwyqhvukZZSyBbOVVbmeAJSZY6zpA9x25JzA4Td0xGPiZiTznYUvc1NNXkuAETDac5seX96rQ2kG5SYR2IotYPX0mhx8dpiwVa0NmQSboBz28dTHhclrzUM8zP8OSXBBb03jhXWPV48A8MJCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631892; c=relaxed/simple;
	bh=58Vf7rQ9Ye1ZnF11F3AKbtRYHEgqBK/0woCbX8EkJYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpmjGXXxM+v6eMhWruYiWy+ubudGLpn+4hYans6jD2VcmtSZJeplHCtrzro8xLLUStdZ394b/uDXWIKsQc41Eel/NMdvkmIwNeiP8UyWunM1Wm1hX7V8Ric0XOu7GdO6R4SfbOpF+IyHpwlvUFWhTixlWOMXn21GUc73XfMSC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5m6LcCY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5m6LcCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D084C4CEF6;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631892;
	bh=58Vf7rQ9Ye1ZnF11F3AKbtRYHEgqBK/0woCbX8EkJYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5m6LcCY0fMTsbvQBiYf/XRYgqwdq8ytPquDE20krnwpOaMuDoNA3pU22YsjdDDnZ
	 qZXcgvsjhtD+gBnQ8yDYjS4VS6fjlWdJl6rB5AULiAk+z6VU7XRZ1Erge+x3cg8QZ+
	 EauQkjvmZHffohcA36ck217NllK1h3t+XMzy//q5dO28AHqw8Z0xOpCEv0PyyYc3q5
	 n0KfEYbJrbBQVyMkmn23Msfg6NKF0jum/ogCx79YAMGx8lSCX2c4/IsjUyGDzJXMq9
	 ezhz6fIZr5+49jOKebZnnkMOlyezx6eL3B/CSfbVT/+86jhNLL1nOIKIHKNXep3/VQ
	 /4JxIbu5B11ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9EE36CE1389; Mon, 10 Mar 2025 11:38:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 7/9] rcutorture: Comment invocations of tick_dep_set_task()
Date: Mon, 10 Mar 2025 11:38:07 -0700
Message-Id: <20250310183809.3576320-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_torture_reader() and rcu_torture_fwd_prog_cr() functions
run CPU-bound for extended periods of time (tens or even
hundreds of milliseconds), so they invoke tick_dep_set_task() and
tick_dep_clear_task() to ensure that the scheduling-clock tick helps
move grace periods forward.

So why doesn't rcu_torture_fwd_prog_nr() also invoke tick_dep_set_task()
and tick_dep_clear_task()?  Because the point of this function is to test
RCU's ability to (eventually) force grace periods forward even when the
tick has been disabled during long CPU-bound kernel execution.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6d808c70349c4..3042a7950fe23 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2410,7 +2410,7 @@ rcu_torture_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	if (irqreader && cur_ops->irq_capable)
 		timer_setup_on_stack(&t, rcu_torture_timer, 0);
-	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	do {
 		if (irqreader && cur_ops->irq_capable) {
 			if (!timer_pending(&t))
@@ -3260,7 +3260,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
 	rfp->rcu_launder_gp_seq_start = gps;
-	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
+	tick_dep_set_task(current, TICK_DEP_BIT_RCU);  // CPU bound, so need tick.
 	while (time_before(jiffies, stopat) &&
 	       !shutdown_time_arrived() &&
 	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
-- 
2.40.1

