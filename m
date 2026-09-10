Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B4514761
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059666; cv=none; b=YorsAdPESigUp9g5V6bCgKmeBvOXTqpVXI6Hs+89QwTA0H1m7VTOsAhPbx36xSkjfrsp7Er8Jjr8UHAfQj+MPJw/r/dBDL7xlYAM2vPfrfgHN7kwz8S50W+qq9EKIKo8g9GMsGUed3CGnZWrx2lOr2uomH4TSXhnxhB25GGpKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059666; c=relaxed/simple;
	bh=VgnchaCc2vX6JqnZYdkH5HmBZPbqNielW9yPIGJDnOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cyt4EcCV+FcqkJd29JVo0UFZ/lAjFYGBtSmbbI/ATilW4N3x+kYBjp6L96xRdw6lbmUWFWaUR7sF/RBTit12neqCMsXDCJsXQISB4untedDRgErBCjC6McWA/ve629F/KCcfToxKQBp4MD/FlV3R6hR+/wLyfi0NvFhqfmbKg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJmg5zpq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJmg5zpq"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so1445618a91.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789059657; x=1789664457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1R78kwUbbRM80m6M3DLzus90cypEj7C20j5fyE9J8w=;
        b=KJmg5zpqq3q/4Kluxx45d6F/mVlBpzfe/HankEVPYtvPqqrMFODx8DzRH209RCmMvA
         lLma8U1xI/xmfjNwWJnhmk/X6bkhGYvvVZsU+xmyXiEI+Ax/XwCJUSMeeOS/f/+QW1rq
         gG/XscmTTQZxVwtSFakyq+mLMs2ZQ9kVRvex/RI1aMe6da9nrvYNafMP5fsi9vxj0+V+
         gNUr6qzaa77yX/0AdL8vdKbQMGW5Q1fl+xHOhvUfeQVjxIsyI3rvXBRWLFLJV+NVBU5S
         CqFzW7U22FoGgEVTlNEwG8B8DrcKBp9pMRFvuCzRn8IfR2JqNrC295RO5wpPttfgtO/u
         eb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059657; x=1789664457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1R78kwUbbRM80m6M3DLzus90cypEj7C20j5fyE9J8w=;
        b=rSzZkayrJpX8huY7UA8BL+rZcRlOGIpAW1h5bVyy6kUhTV0X75CE8BV94RJVAuArHT
         oOTlH+nfSX3HLISQwUy/h3a2zEDdr8Rl27SiV9ybkxBx2LU6nTlxJqzN/CEDtGvucdHZ
         LwWDTfuM5DrUmMw8RSGp+8Byl0FFkZtC+Rbcj2rE843iM4XWoTUjOlN27ly7FCe3si57
         gV7B22IxZwyjrEh6xS7ksMGtJJGyRw7uVg3UMF/aPiQsHW5wzb1xAnyIcTJxPnjC9e/v
         Q4bM/fPeC8OCLtGCJTY7tx2nJ1hwKkjcCjMa9RI1sS5Onlog78DlnE2ZighsndgcCyZ/
         nGog==
X-Forwarded-Encrypted: i=1; AKwUvByky/fUG1U70QozUhJS7XdIPP06YjqzXkKa/dIWWWSoORkLNOaIFtns6/k6+9Xt+OokcIM=@vger.kernel.org
X-Gm-Message-State: AFuF++nsWBbTzaxziqUytAUh5do+SD5+FCzQ/1ir3bQ3cJ9TJ2/Jxgmv
	uAVvPUv7KGSPMRdb1UySe5RM68buAvrdojoVT+DOWtScmweZwqeQSJ83
X-Gm-Gg: AYBFou23wq/Tk3bxJuh5n/fvs0Gd8oCxs0HAYhVTOy+cbKq1/84zOLWSPieqv3qJnRp
	2vwzBbgfTXqQNjerN2f/+F2bN/sZ86RAGybo9NP9xeZQ5yk0hYDD/qD2D1tCeXjU10Xwb4BMSaN
	BALOsp3+9ILJjEJV7BtiK+/0nDoZG+emVdVYS5GJ8HcsW1HNWwgKG4CQMih284hVjE2kLJuqTyq
	48WIcy0I6W2Mv3nlyTN1J2kYOMufvb7yKqHSB3gWGF7b+BzEA0kh2ZNGV6BMom+EtNA1m2Iw4aJ
	4weCSX7B7ZBDOYJrNi3scnRNx2JnmFzj+E77NNmynZv4xVI41ZVQoLQgXQXqAqOceRn0PqBhbFN
	aX7fzG8inxpZ4qUbTbb6cyRTdM1IrD9PJxsU/RHQ2PEvWzsJOglRmWnvAiL6H0al7DcorudAc/y
	cCN7+P1Q4OZdo5ToqZe42RKlYfWAMRHs6UnymTvk1mSQICl69+++blBF3dr7IvhlIvYvexEq49y
	mN6SegLhDHIpNK45u+xxNJ5ti8bogdw5yr5KRvYKu6eEf740BW4BmWm+ogePnOl8JjZNbifbP2a
	/4mm8VwEsSF21i/vqMpxo4tRSVbW260XC/Lruz/4kPTHMxKSp9rCL6ungDdNc0M=
X-Received: by 2002:a17:90b:1c02:b0:398:9bd3:d6d6 with SMTP id 98e67ed59e1d1-39d98140f92mr240590a91.16.1789059656557;
        Thu, 10 Sep 2026 10:00:56 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm568538a91.0.2026.09.10.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:00:54 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: paulmck@kernel.org,
	urezki@gmail.com,
	harry@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	surenb@google.com,
	vbabka@kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] rcu: make userspace barrier hook drain kvfree_rcu work
Date: Fri, 11 Sep 2026 01:00:40 +0800
Message-ID: <20260910170040.344864-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910170040.344864-1-matthias.goergens@gmail.com>
References: <20260910101112.1648978-1-matthias.goergens@gmail.com>
 <20260910170040.344864-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The bcachefs ktest allocation-leak check writes rcutree.do_rcu_barrier
before reading /proc/allocinfo. While testing bcachefs performance
changes, small objects released with kfree_rcu() remained visible after
repeated writes to the hook and 20 seconds of waiting, causing otherwise
clean tests to fail their leak check.

The test assumes a stronger contract than the hook currently documents:
rcu_barrier() waits for ordinary callbacks, but does not flush objects
still held in kfree_rcu() batching or per-CPU SLUB sheaves. The retained
population eventually fell as a sheaf filled; there is no evidence here
of unbounded growth or OOM.

Changing the hook to drain kvfree_rcu() work let the same unmodified
bcachefs workload pass its allocation check. All eight checkpoints in
one VM, after 50 through 400 option changes, reported zero retained
reconcile_scan objects. This motivated the separate private-cache
reproducer used to isolate the incomplete drain from bcachefs.

Calling kvfree_rcu_barrier() from rcu_barrier_throttled() was proposed
when the former API was added in 2024, to restore a clean baseline
between userspace benchmark runs. The discussion concluded that keeping
the existing hook name, adding the second operation and documenting both
was the safest compatibility choice, but the follow-up was not added.

Add that drain and document the stronger test interface. Keep the
explicit rcu_barrier() so the hook's ordinary-callback contract does not
depend on kvfree_rcu_barrier() reaching an ordinary barrier internally.

Do not reuse the ordinary rcu_barrier() sequence as an early-completion
check while throttling: an unrelated ordinary barrier does not establish
that kvfree_rcu() work was drained. Retain the existing start-rate limit.

Four fresh VM pairs with the full private-cache fixture retained the
queued object without the patch (60 to 60 active objects) and drained it
with the patch (60 to 59). A separate ordinary-callback regression test
passed on both kernels.

Link: https://lore.kernel.org/all/20240820155935.1167988-1-urezki@gmail.com/
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++---
 kernel/rcu/tree.c                             | 27 ++++++++++++-------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..244a53166249 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5699,9 +5699,10 @@ Kernel parameters
 			there is an ongoing too-long CSD-lock wait.
 
 	rcutree.do_rcu_barrier=	[KNL]
-			Request a call to rcu_barrier().  This is
-			throttled so that userspace tests can safely
-			hammer on the sysfs variable if they so choose.
+			Request that deferred kfree_rcu() objects and
+			ordinary call_rcu() callbacks be drained.  This is
+			throttled so that userspace tests can safely hammer
+			on the sysfs variable if they so choose.
 			If triggered before the RCU grace-period machinery
 			is fully active, this will error out with EAGAIN.
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 96848fc1f02b..014e28ec3bd3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3989,12 +3989,12 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
 static unsigned long rcu_barrier_last_throttle;
 
 /**
- * rcu_barrier_throttled - Do rcu_barrier(), but limit to one per second
+ * rcu_barrier_throttled - Drain deferred RCU frees, but rate-limit starts
  *
- * This can be thought of as guard rails around rcu_barrier() that
- * permits unrestricted userspace use, at least assuming the hardware's
- * try_cmpxchg() is robust.  There will be at most one call per second to
- * rcu_barrier() system-wide from use of this function, which means that
+ * This can be thought of as guard rails around the deferred-free barriers
+ * that permit unrestricted userspace use, at least assuming the hardware's
+ * try_cmpxchg() is robust.  There will be at most one drain operation started
+ * per sixteenth of a second from use of this function, which means that
  * callers might needlessly wait a second or three.
  *
  * This is intended for use by test suites to avoid OOM by flushing RCU
@@ -4011,18 +4011,25 @@ static void rcu_barrier_throttled(void)
 {
 	unsigned long j = jiffies;
 	unsigned long old = READ_ONCE(rcu_barrier_last_throttle);
-	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
 
 	while (time_in_range(j, old, old + HZ / 16) ||
 	       !try_cmpxchg(&rcu_barrier_last_throttle, &old, j)) {
 		schedule_timeout_idle(HZ / 16);
-		if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
-			smp_mb(); /* caller's subsequent code after above check. */
-			return;
-		}
 		j = jiffies;
 		old = READ_ONCE(rcu_barrier_last_throttle);
 	}
+	/*
+	 * kfree_rcu() can retain objects outside the ordinary callback lists in
+	 * per-CPU SLUB sheaves and kvfree_rcu batches.  Test suites use this hook
+	 * to prevent deferred frees from spilling into the following test, so
+	 * drain those queues as well as ordinary call_rcu() callbacks.
+	 *
+	 * kvfree_rcu_barrier() currently includes an ordinary barrier, but that
+	 * is not part of its documented API.  Keep the explicit rcu_barrier() so
+	 * this hook's original contract does not depend on slab implementation
+	 * details.
+	 */
+	kvfree_rcu_barrier();
 	rcu_barrier();
 }
 
-- 
2.55.0

