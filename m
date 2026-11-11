Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409199;
	b=0Imslrw2DHRXhHvh6ocmoHUSTevcBpOFaJDirhDAlSbxj1PO3Ukpew1MPZf41o2E+zV+
	 0TuXhtttMaxHVykdAS5kYvErQogyRV4Zb9iG3lQiNcPZY9hU0BqgtQKaqToB8RjIEl0dq
	 KVRp1GRoGsgwO52k9453fuuAEtp/J1hT6UIpdx+kINU+EW+eMVqYEbz0WGLYiCugmeQ0b
	 bxB/qkYTaF2w13lA/3lrp2hElkRi5uedgWP9wU8mNLrnhWZKgsnsfQi9csqAC9aJy1ue/
	 Ol8Yn4uv9e9tBJtt71xxIpYDPL7Xbyj5WzGCdlbOd3+QNx+jiXjy7qM6Ca9FNGoxRzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409199;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bm+n2tFEGGt2zoKOXv4G0G707ijjxMSsqQFFCRwLWSE=;
	b=Epl76fagxuTXK1bjawMzGd1qYfc5mE7ynCSdJjHDgzCauwSpU79OkFGHXGvRmavZh4Mk
	 JvAmqMw5+yBY2ZhEcT0Fhl8Y9kMD/rHr97tlB5xafqVgTAJI+cB3bVlCGrPhuyS6OrRkk
	 pTp81B70QdSwOSo0z2BHLUnIvwTZNWsDelW9UJsXdsUE/31RY1t+v/KRevGGMSKZKddBC
	 4zRwazY6RJtkuUL8vyx0EztCqJvJSibIwm/IlT7Gy+aPU+2yqCX/c4PuLE0HofHxCL3ZU
	 mLGUTZx8T2BT/VjaMWqV4cgLV9dUTq9xS+lsLfYTXU3WjZhuXDtVLHpUsFAq3tmJrRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=v4tabJxP;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6C606A881;
	Wed, 11 Nov 2026 14:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D6C606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=v4tabJxP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794409197;
	bh=bm+n2tFEGGt2zoKOXv4G0G707ijjxMSsqQFFCRwLWSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v4tabJxPsdiWW8zifVio/TqVQg529NwS2wxly5tgZisG4nlFRFlMWxiNpjRVkTZDN
	 qrWZGIl2QeA3moXiCsjyKqYfyh8X/6zkI4pcLbuYQN0O9DzdIJ4uwQlHFaTcjYZlnv
	 ZyDC6h1+3vVJbSxRh6LvCtK+3f9XRlPXN4TWYQsDwH0sGoiBCEUKrXcqpleJf5lwiS
	 aNzb/2MVllGecEPwq+NTealGZgAtRfwh2TwyQpKib9+M86oYYhfNeINzHGJ6iKI3NX
	 Xk4qUkml1lA+d03PG3qrddDPBuswUiorgltwD+pKlkj0Hnj+Afb0NEGvHpufMB6Vee
	 egQcdKNWvMxjA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPms92tcTzNgh;
	Wed, 11 Nov 2026 09:59:57 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rcu@vger.kernel.org
Subject: [PATCH v2 1/7] srcutiny: Do not call synchronize_rcu() from synchronize_srcu_atomic()
Date: Wed, 11 Nov 2026 09:59:43 -0500
Message-Id: <20261111145949.70845-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synchronize_srcu_atomic() never blocks, so that it can be called from
atomic context.  This includes interrupt handlers, and code within
rcu_read_lock().

With CONFIG_PREEMPTION=y, the Tiny SRCU version first calls
synchronize_rcu().  Tiny synchronize_rcu() does not wait: it only
advances rcu_ctrlblk.gp_seq.  This is valid where the caller is in a
quiescent state, in task context and outside of any RCU reader.

The callers of synchronize_srcu_atomic() need not be in a quiescent
state.  An interrupt handler may have interrupted an RCU reader.  A
caller within rcu_read_lock() is itself an RCU reader.  In both cases,
synchronize_rcu() ends an RCU grace period while an RCU reader is still
in its critical section.  poll_state_synchronize_rcu() would then
report a grace period that did not happen.  The caller within
rcu_read_lock() also gets "Illegal synchronize_rcu() in RCU read-side
critical section" from lockdep.

srcu_drive_gp() has the same call.  There, it makes an RCU Tasks
Trace grace period imply an RCU grace period.  RCU Tasks Trace uses
call_srcu() and synchronize_srcu(), which are both forbidden on a
srcu_struct that uses synchronize_srcu_atomic().  And the Tree SRCU
version of synchronize_srcu_atomic() does not wait for an RCU grace
period either.

Fix this by removing the call.

This was found by reading the code.  An rcutorture test added later in
this series fails without this change.

Fixes: a48669f0c49c ("srcutiny: Add an atomic Tiny SRCU")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rcu/srcutiny.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 63a3f0a8bc53..d58f4160f925 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -367,9 +367,10 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
-				   // And in Tiny RCU, it is near zero cost and doesn't block.
+	// No synchronize_rcu() here, unlike in srcu_drive_gp().  The caller
+	// may be in an interrupt handler or within rcu_read_lock().  Tiny
+	// synchronize_rcu() would then end an RCU grace period that an RCU
+	// reader still holds up.
 
 	// Usually, there will be no readers.
 	preempt_disable();  // Guard against lazy preemption and some other grace period.
-- 
2.47.3

