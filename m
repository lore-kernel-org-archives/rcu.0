Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CB39E6CD
	for <rcu@vger.kernel.org>; Sun, 30 Aug 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788083779; cv=none; b=Jo16m8wGLz65dyF5U4jyfzzyuctxb49CCMwuw3obYwtT3gR5fDgfaO64rW/jGh50IjLS3azRF2xHurgkO3piV7XEpZK3PjydQyz4Y/ju1ms1D2MXd/fAIMGvdw8zGTl6IljKIr4YzGHbCR4XyWluQArg4sfw3c1CsDUcQmLwJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788083779; c=relaxed/simple;
	bh=XzNmT6UqYUaI3bzKr5Gekq2xyab52rqTypKA733dS5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+CEGo2JKExPDLdB1xmxg/YV3QssmFsU+mlsjrfE+pNj9WMr+tI5qQJJ3SKs7MMcAFtSDYqdI6UAjo6V7DhBwFBuWzOfUrfQTxYmgXQBCormqonzmaFYnKSTz/ZyU7Z40eeSP5oUb4KuBbZramkKpVSmM1SfGBdJssPlYr5ZS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8WQDK1r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8WQDK1r"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2054725a91.1
        for <rcu@vger.kernel.org>; Sun, 30 Aug 2026 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788083778; x=1788688578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ln/5bDFiIG/k0+oCaFFVx/O89bQKJL6QY77jSm0UJxY=;
        b=B8WQDK1reLgJ/RJ7YCc3IAtxr1kGLRO7IBi+1Baa5zlgwziMAQpnnU0dB87FcG4NPu
         gYMTikAVb7UBlyLZ5Hi9DrCjEnPYfuoR6BPSS4YZ7uQYquzfqYI2JnjPlhivYN1UDC3r
         L0BZJdnS9plufdtH7bq5BaJLuIgL3uBIqNAItzGzUWy9fV/SSXIlVO/juBad6xX2YnVq
         InDBkLnaQLXOfYO2qrjp99FD/NpYxB+EDS+O8qDtmaJi/gYbde3240+t0Le+eJsbV54u
         aAVBY/W0kVdGY2BZrnxYkCByP8b1e6eveg4XWQ3Pl9ZUruK3+Rzl87NNpbzr63k4xZg8
         Yekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788083778; x=1788688578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ln/5bDFiIG/k0+oCaFFVx/O89bQKJL6QY77jSm0UJxY=;
        b=kuS2UX7BZzgZXuXxJwGQ9aPxbWlMVIwJIRCJBeiQec6FCK73/skGCv+rjpQcZ7IO2L
         DABxXY7HFZX/zIYUCNqhd9l0Q+oykaIs09mfoSsTjLq3ENO2CCy1fKSUwkAr/W2SBovM
         2Y/YbyP3H3H2wYDXRMF+Jw55N57pYKZqBgvayU/Hhy1KgqdflFQc5V1IsUW2HukLwOWB
         2MuM0jR1d9TURv0MV+5hrTrLuLZBugbmZv6xhDqocwodZYRqx7VSo9KW1PmJhIfK5hDT
         hF6YKKO3J/aoU4N4eVIcWl3/+m+4KcO5nzRJb31bB7beMdErIiWR/PR/Vg9147airJo6
         uRzA==
X-Forwarded-Encrypted: i=1; AKwUvBxM+h8CwU2fJbo8C1JUEjMvB4PjHQcYN6GWE6gVZ0GeynHrx0H2oKTDVSGmdGXmD2cQcV8=@vger.kernel.org
X-Gm-Message-State: AFuF++nLiKjEfVf841uCIVjNzffIDhjz4jx8HClSlIxP6kUMm9AR97jR
	no69S75WL2d8Ish1p3qpXe8RsvpK4rzA8AUKtfsQH7YNi5iJj/Be3XQp
X-Gm-Gg: AYBFou0GZXY42Vsjch+Ax+gSAghHwkRPmKmWYCk9iCnIdn32Y02N9p6B+HpqFOEui7Q
	Ou7h6OfqvXvk4B3Ka/x/tXF1gd7NZ6EfOo/hepyL58aH3ogGZ+Q4OmtAcf8AKwAjxqo+bPMuplp
	lvjHU77RYKRkdG5K3B6HWWyq+vSfQbmBJaqnbyeEuZWKQawS1alOv6/AQYh+KAHaEOGXWojit6p
	bJuQKYL//zF9HstW/LTwN8UQu0IxZqaHbxZTngcmFB4wcxtyGOGQk59OfMspOUjH0/1Toq5LCD3
	Z45GKBgNzEu7gZE7i/emQZBASf0I5Ft1KzBn3zn1styTV1PDvar0GxHb74Sbl5/hNJbKMxZCN9k
	5Vad9T9IbHGhHviGi/d6hD3mNCzO2eHbL7zCUMv9mYenKRaJaFTQNpJT2+AjOSwksqy1nm82AO9
	fG7MCmEkWkHbp8oyzdTFKTYZI8KcWjicgKv/gH1ErkxSZZRym9dmCSctMn1Po+E4RDyS8fzzlCq
	O9PpSVKv6QCrn9JInn/klTh7Cg=
X-Received: by 2002:a17:90a:da83:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-396d0de796fmr31299768a91.4.1788083777574;
        Sun, 30 Aug 2026 02:56:17 -0700 (PDT)
Received: from shpark-MS-7E27.tailee9dcb.ts.net ([218.49.81.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc0c703sm10888092a91.9.2026.08.30.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:56:17 -0700 (PDT)
From: Sunho Park <shpark061104@gmail.com>
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	frederic@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunho Park <shpark061104@gmail.com>,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
Subject: [PATCH v2] srcu: Fix WARN_ON() for rcu_segcblist_n_cbs() in cleanup_srcu_struct()
Date: Sun, 30 Aug 2026 18:56:05 +0900
Message-ID: <20260830095605.3560267-1-shpark061104@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WARN_ON() added by commit 78a38cbf6f20 ("srcu: Queue sdp->work
when the delay timer is successfully deleted") uses rcu_segcblist_n_cbs()
to detect callbacks that srcu_barrier() failed to wait for. However, the
->len counter is decremented only at the end of srcu_invoke_callbacks(),
after the invoking loop has finished. Since srcu_barrier() can return
right after the barrier callback is invoked, cleanup_srcu_struct() can see
a non-zero n_cbs even though the cblist is already physically empty,
falsely triggering the WARN_ON() together with a still-pending delay_work
timer.

This can be triggered as follows, as seen in the syzbot report against
kvm_destroy_vm() -> cleanup_srcu_struct(&kvm->srcu):

1. call_srcu(&kvm->srcu, &bus->rcu, __free_bus) starts SRCU grace
   period GP1.

2. GP1 ends: a delay timer is armed and sdp->work is queued, but
   sdp->work has not run yet.

3. Another call_srcu(&kvm->srcu, &bus->rcu, __free_bus) call invokes
   srcu_segcblist_advance(), which moves the GP1 callback to
   RCU_DONE_TAIL, and starts SRCU grace period GP2.

4. srcu_barrier() is called. It queues its barrier callback after the
   GP2 callback and waits for srcu_invoke_callbacks() to invoke it.

5. GP2 ends: another delay timer is armed, and the sdp->work queued in
   step 2 begins to run. Its srcu_invoke_callbacks() call invokes
   srcu_segcblist_advance() again, moving the GP2 and barrier callbacks
   to RCU_DONE_TAIL as well, and then invokes all of them. However,
   rcu_segcblist_add_len(), which updates srcu_cblist's ->len, has not
   run yet at this point.

6. srcu_barrier() returns once its callback has been invoked, and
   cleanup_srcu_struct() starts running. It finds the delay timer
   armed in step 5 still pending and srcu_cblist's ->len still
   non-zero (because step 5 has not reached rcu_segcblist_add_len()
   yet), and WARN_ON() fires even though every callback has actually
   been invoked.

Use rcu_segcblist_empty(), which checks the actual head of the cblist,
instead of rcu_segcblist_n_cbs(), which checks the racy ->len counter.
Callbacks that have genuinely not been invoked yet still leave the list
non-empty, so the WARN_ON() still catches callers that skip srcu_barrier()
or queue callbacks after it.

Link: https://lore.kernel.org/rcu/e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev/T/#t
Reported-by: syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4faf7db59e11f6fd1ab
Fixes: 78a38cbf6f20 ("srcu: Queue sdp->work when the delay timer is successfully deleted")
Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Sunho Park <shpark061104@gmail.com>
---
v2: Describe the exact interleaving of call_srcu()/srcu_barrier()/
    srcu_invoke_callbacks() that triggers the false-positive WARN_ON(),
    per Zqiang. No code change from v1.
Link: https://lore.kernel.org/rcu/1b9d3ddaa26ba6a8ac2ad4c586c2d19a5c1f927e@linux.dev/T/#t
---

 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ed204b3f4b84..ad27880dd690 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -704,7 +704,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		// Call srcu_barrier() before this cleanup_srcu_struct()
 		// to avoid triggering this WARN_ON().
 		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
-			    rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
+			    !rcu_segcblist_empty(&sdp->srcu_cblist)) &&
 		    rcu_cpu_beenfullyonline(sdp->cpu))
 			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
-- 
2.43.0

