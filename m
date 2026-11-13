Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531035;
	b=q74LzX6+u4bv9G46JZDZiSKO61RUlJarH4LA2jt9Z5+ToFlDtWnElOPi7ZKoszxSnL/R
	 Z6JeK0RDZQyaefWMpZV1N3s9AacRUVKaySBnEb0cHrtnuKtU/NGttJMLeMGGE4bpI58iN
	 jT/f5Qrk+ul40VDGVBGQem1lssDW4Jr/MoPBx7ewQinGIgkFkiyw9W4GWrjxxetgZqp+7
	 rfolFJXnpWbBvURRu728j9LnmaGxT7TVlJ8fcv1QdBbQjOZI15i7N0SuoubpvfkBlUkO/
	 id7Gmh/oMXZq8JmuJcpPkG/Ts9uPlfpVNchWHmXs5gb8gFJJ5zZrrDztXneITW+m7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FekEKo5wh9dK9x2tt/oaB48ZaKcR3xC9BKWYBXgHibk=;
	b=OcfcaFhS9L3xdoV4Pt3BnxpohM3NLGAgv8D0DBk5cnEb9IlNQPUjgZDhd0Nm8KXfua7G
	 AwEyEtYeuHy9MQ50wo9lfQPob77+VZtKQabbpUp30AQaJn09480+aZ3nNcovU9OiJ+0FB
	 xDbgj7pyaZ+zCEBnVbgj02S45tYlEaLzsqUDvmhU+2AijwMEEaJxHXLOUSgC3pAkCgzWb
	 8+ljTVPt/rLxVpMCis6wV4IVreaYpOrklzTWchSn4FMz6k55Tk407zt92rBfwQghqoTWg
	 ZAWV+KQxCqrFCxl+YESt53foPjnjpDWYVnERz1yV23sy7E51ktZ+0fubWYbDDZvVNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNHc9WkJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F2EF160A3832;
	Fri, 13 Nov 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNHc9WkJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4D9DA1F000C5;
	Fri, 13 Nov 2026 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531034;
	bh=FekEKo5wh9dK9x2tt/oaB48ZaKcR3xC9BKWYBXgHibk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNHc9WkJEBvdfl+QNjb7xp5eGFCAHvM/JpbnIfCTuOw77DT/kK70jvpmxyY70u5QI
	 uIdBeL4EcJDCPRy8pUnIIQehrkr+hrtiCGjeeX/H9gaJZv745Wy4yFgb/A4A9aF775
	 /epQ17TqhMShBKQXzqhtwTJglai5pv8Z+PxmeeyYgiNPS+2CW2+4NI53ejpl9JSCi2
	 kJQSpRuTSmn4lIue+tAk2jrcL3IKGF7ldP0vAYxujWkyvdnd9bHUaenEEISodoGr/G
	 mlbpEVifY/7yDvNuQ+nfQeP31UirEUNeEm+i7GEKiwyr5AP8k9JwsnhQoceo1ldyLk
	 Ry66id/4I+BpA==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 08/11] srcu: Detect duplicate callback enqueue at registration
Date: Thu, 12 Nov 2026 19:50:10 -0500
Message-ID: <20261113005017.2772440-9-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005017.2772440-1-jfern@kernel.org>
References: <20261113005017.2772440-1-jfern@kernel.org>
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

From: Kunwu Chan <kunwu.chan@gmail.com>

Move the duplicate-callback check from srcu_do_enqueue() to
__call_srcu() entry so that detected duplicate registrations
are rejected before they reach the deferred-list enqueue path.
Use __ratelimit() to limit the diagnostic output (error message,
object dump, and stack trace) as a group.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/srcutree.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 76f074f67299..778d8507dc80 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -23,10 +23,12 @@
 #include <linux/kasan.h>
 #include <linux/llist.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/ratelimit.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
 
@@ -1511,12 +1513,6 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 			    rcu_callback_t func, bool do_norm)
 {
-	if (debug_rcu_head_queue(rhp)) {
-		/* Probable double call_srcu(), so leak the callback. */
-		WRITE_ONCE(rhp->func, srcu_leak_callback);
-		WARN_ONCE(1, "call_srcu(): Leaked duplicate callback\n");
-		return;
-	}
 	rhp->func = func;
 	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
@@ -1526,6 +1522,10 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
  * disabled, so defer when interrupts are already off rather than enqueue into
  * an operation that may be in flight on this CPU.
  */
+static DEFINE_RATELIMIT_STATE(rcu_srcu_dup_rs,
+			      DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
@@ -1539,6 +1539,17 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (__ratelimit(&rcu_srcu_dup_rs)) {
+			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
+			       __func__, rhp, rhp->func);
+			mem_dump_obj(rhp);
+			dump_stack();
+		}
+		WRITE_ONCE(rhp->func, srcu_leak_callback);
+		return;
+	}
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
@@ -1554,6 +1565,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		if (READ_ONCE(sndp->draining) && !in_nmi()) {
 			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
 				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			debug_rcu_head_unqueue(rhp);
 			return;
 		}
 		sdp = this_cpu_ptr(ssp->sda);
-- 
2.54.0

