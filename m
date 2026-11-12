Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490657;
	b=TkWVG/k0YGYHCYJcICbVJxjvrGbZyd9Er75rRLCs4pVanJmYhwK8uUvJVc3M+5KTjobp
	 9QvkEHMoG8iqeKqu7B5p46+ZXp271Ez1iagi96dmeZsEonsv20dD93OQlNmQY3v8XVOUD
	 asJVMqBNzaVr9US8TmAbIGnflVC3wMfPn+qGmIUly5kYqPRqZrkOtn1qkHRDE+WKWlt6Z
	 YGy1FV7Zw5W6755vkEC1Ko+n44yyoI+Ol6oFLqvEXmaBGSyIZKO8g0/OpBlEt1cxorz2A
	 hP9ZIxcdAEfx8NHTW/Vtogc2WVMd3e0vUaWMFuDwNlyOegiiB9GQeMpKcEAWFiVBMiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490657;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FIVDbaAlnk+am+BNT8xpbGfO+Ac2yA3UwLt7VW2qB2g=;
	b=DLib4UTllq3/5eVdVAxQIqNQ2130IpQMx9aDrpnD8FioopAM1Xlq+P8JaC1P43jbDhjL
	 96ew/nh/e0DZdp7jukFjqluJSFhFtQNYlZX3dyUTf638z4iP7AFXTdmvu4Orwh1/uvzSH
	 bk0Kre9b5EdOTXvmHq8+9A/ZeJfMuN9bLtTGJXu1yEVj+fTJfwmIcnv0wHb6+xxK0q/fJ
	 sZZn+ZsNwBymk6Aa1qxAgAzsOMVPDgyrCuTMljlReHZDNXOadExnJtv7cgeHkEPkQTipJ
	 AfB9MAJ/Jim0QuMXdX6fSzME2uNY8sipb20GDT4M6XD4P+0fCfd9RQdDEGradFo4a/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=IT08NoZL;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044D606A886;
	Thu, 12 Nov 2026 13:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4044D606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=IT08NoZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794490655;
	bh=FIVDbaAlnk+am+BNT8xpbGfO+Ac2yA3UwLt7VW2qB2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IT08NoZLVOcfXRXuHd12iFgM8/yp1q31R79Wor28zo0bhS9KMD0G+Js0pFVxI+OhC
	 yIeAfipRrAf/ZxlOTnVpXvQnG8n7YAF/Tm/NQsutGayKFf4/i5Rs0JEPIIxEIjeNSL
	 DBTA0FLyk4vx6AkPEJ8600OnK/lbQ3zL1rgWwm6QUKaHHRQ895Np3jKdnI9kWIbpBi
	 qrlS8ICBvY7s5l2gUiNAxsBWCe0cct9Cew90PAQdEKm4nTWZaH/ahlpHBd+Q2LB1Fw
	 /u4L2jr/ri+LhgbNUAnOWO+kcU9/38wCAk5MjaIBjAal0v7coE5bih4UOIzHOd0K4w
	 dUtHZIwSquD9w==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQLzg1bcdzNZk;
	Thu, 12 Nov 2026 08:37:35 -0500 (EST)
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
	rcu@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v3 1/7] srcutiny: Do not call synchronize_rcu() from synchronize_srcu_atomic()
Date: Thu, 12 Nov 2026 08:37:25 -0500
Message-Id: <20261112133731.127221-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
References: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Kunwu Chan <chentao@kylinos.cn>
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

