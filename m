Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661930FF30;
	Sat, 19 Sep 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776065; cv=none; b=Ig2pM3iytAREt6KEkE2YecxRdzuZWzmVoMawozkdWCDGOcA+P57FgUW2SIgJfjlujbm4m/GluJyltz9v27sl1j6RsrJ0FyYjgA1F5rx94ntNxAbGSLJgXTtAUeebt9FvVpCXXPl4IgSHUz/F62MgbXHJD55AHAPKecp0+woPPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776065; c=relaxed/simple;
	bh=XiSl73I6+4XqMuEmxfKbAq5XKf5lAeiWzHHxXUOm194=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ruzg6QUzBnP8ZXE8UPja8tf2YjaQ47ANTdAJ6oL4EuyHwvdYz6rB95iUBbiJQFOYCLAfvZNStt5G0zzISR8Z30oqyA0ckkemx+AfoVb8IUVpKzFei/l0GPNTujmgNapkvuwCBWjuivY/DIXmbpdjriyKAKGg3Pa3yFvMctsFcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlsnF9Ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlsnF9Ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCDA1F00901;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=UmDKeRHtz9aIYS5as4tQ44sYTzTTc8UaWHSpjHDxzjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nlsnF9Ww9udD0n2SFoYJYgnTHpKzu2DKAy7QadBgLZBZ3YRJvolnCSIaYhK/YxBKG
	 SzPuMz3wcyHSrjdfMWpcaDrYhh0uOkza/yrkPlGvRdXjYT8DmkMe/DuOlyOS/pHBx5
	 RKzLv3KuYphjRUqCj89qkN5gqJUE80YnGtn4PxnkMGzDIw/f3kq5V2ojsy0oHGXPVc
	 cTGBSlOref8S0rnUDKUuUil/ozSWt8hG2VW4BxQeGVuaRr12VyL2znhQdECRzipiTA
	 2QMKy0Fk5jxKqNjx/ySaJlynYio9CizKSR0PzS8DEAivZklgrZCVhDm+YingpDKYdS
	 cwSsUtslnM7Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 74CCACE0E0B; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 15/28] hazptrtorture: Add the ability to disable the writer kthread
Date: Fri, 18 Sep 2026 17:00:43 -0700
Message-Id: <20260919000056.3132131-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a hazptrtorture.nwriters module parameter that, when set
to zero, disables hazard-pointer update-side activity.

[ paulmck: Apply Breno Leitao feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index ece38f444be6..045ab6fc7ba2 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -36,6 +36,7 @@ torture_param(int, irq_acquire, -1,
 torture_param(int, kthread_do_pending_ms, -1,
 	      "Delay between cleanups for deferred hazard pointers (ms), zero to disable");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
+torture_param(bool, nwriters, 1, "Number of hazard-pointer writer threads, 0 or 1");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
 torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
@@ -657,14 +658,14 @@ static void
 hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" TORTURE_FLAG
-		 "--- %s: nreaders=%d "
+		 "--- %s: nreaders=%d nwriters=%d "
 		 "defer_modulus=%d irq_acquire=%d kthread_do_pending_ms=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
 		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
-		 torture_type, tag, nrealreaders,
+		 torture_type, tag, nrealreaders, nwriters,
 		 defer_modulus, irq_acquire, kthread_do_pending_ms,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
@@ -824,9 +825,11 @@ static int __init hazptr_torture_init(void)
 			goto unwind;
 	}
 
-	firsterr = torture_create_kthread(hazptr_torture_writer, NULL, writer_task);
-	if (torture_init_error(firsterr))
-		goto unwind;
+	if (nwriters) {
+		firsterr = torture_create_kthread(hazptr_torture_writer, NULL, writer_task);
+		if (torture_init_error(firsterr))
+			goto unwind;
+	}
 
 	firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval, NULL);
 	if (torture_init_error(firsterr))
-- 
2.40.1

