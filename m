Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531040;
	b=sDqO3l+ZlFgH5CP4gooKax5Y9q9kDaYjrdd1ZdKP56VYoagVIhTQcRY03zFPNolSPKwY
	 idRsHNvgplRkq3J9IY+oT2twBE1dyclA7FlMssbPW43pEiWOxFAmLd4FzWdRAK58lMSmh
	 AD8C2idsP4CCd4D5nu+kLyAqlN4O70noS2GP16l+vUBLkNYFBItcstFTdy07iSmZyGsAt
	 ceG/GvjaCoVh+RqNznOHidoFzmIyMqskryD2QrGfBCw4PIjgcGkW54tlaj59xakJrHaC1
	 4txxq8aIamyOc6yyM55/XH+YRCr9O9DtQlqlg5ly8PSr045sI+UjwXyGaHyUElXOsyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xcjCuXLuyrEQvtO3AjIqcYfMwPpbsImC7herEE8hUZM=;
	b=KAsbCqrO4qs3/LYQsaYoziYY2gALIl7/o5WWb8E+lMYWykAlAfjawJrhio+pyyEfDYEb
	 YRQqveyjB6WSGhan1oh/ItfsFiu/cTnZ6OA9DvS7VhWNpU15FQfJZMfSCpM2v7Hc44e6E
	 i1S+9bWAAKkjhHXX2rcRUVBNQsSBpuJB7JIH2+Vmvdb5OmZ9u5uGDkGaW1ThN+D6qNadc
	 HX8+XWoHXNckjFqzyefDooAdInMJbA7VSKOT4WduvhsMKMqUGnJNkl5MSxYcEk9pmRHES
	 gJqQrsmjasEE5yrvJF/M4FUZ7Rx8UsgBmwc3DgPptkge/MBhmuyW7PS3PCtS7A09zPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg386Y9i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6CE7160A6F45;
	Fri, 13 Nov 2026 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg386Y9i
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id ED27C1F000C4;
	Fri, 13 Nov 2026 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531040;
	bh=xcjCuXLuyrEQvtO3AjIqcYfMwPpbsImC7herEE8hUZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jg386Y9iIkQSm9oQuqSIAJPyIf6N8l5seetpwoXHcve1VjrX6N3AF+4Vatjmgk2LE
	 jkyoVKk0QtTlX3JyG38PRvNbnI3FlTv2/JBOLjEgitRjDRLYWlixaU5Y2uAiIkuuCI
	 3cwaGMJbCiuIIz35up01FT/lzv64v+61oqolbWCj8DpoFLEqcqhsxfv9468w2NncAm
	 uM8l6HscKFGm1AamsvF+ftblgVcFySjo0t6Vlz22e17Uw8h1HIbbefE6IA3ND7krB7
	 hQljDGYGSUweiiUKGt2SqVMgQLKRRRWnic/c2rfda8nQvx9F6SJHluEhLCHf7IXO7t
	 FzLx/JAtAtSpg==
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
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH for-v7.5 11/11] rcu: Improve duplicate callback diagnostics
Date: Thu, 12 Nov 2026 19:50:13 -0500
Message-ID: <20261113005017.2772440-12-jfern@kernel.org>
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

Use ratelimited diagnostics with dump_stack() for duplicate
callback detection in rcu_do_enqueue().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aea3aef7397e..a8ede50dbeff 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -25,6 +25,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/interrupt.h>
 #include <linux/llist.h>
+#include <linux/ratelimit.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
@@ -3154,9 +3155,12 @@ static void check_cb_ovld(struct rcu_data *rdp)
  * already disabled, and a drain of a remote CPU re-issues onto the draining
  * CPU.
  */
+static DEFINE_RATELIMIT_STATE(rcu_dup_rs,
+			      DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
 static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 {
-	static atomic_t doublefrees;
 	unsigned long flags;
 	bool lazy;
 	struct rcu_data *rdp;
@@ -3167,9 +3171,10 @@ static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func, bool lazy
 		 * Use rcu:rcu_callback trace event to find the previous
 		 * time callback was passed to call_rcu().
 		 */
-		if (atomic_inc_return(&doublefrees) < 4) {
+		if (__ratelimit(&rcu_dup_rs)) {
 			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
 			mem_dump_obj(head);
+			dump_stack();
 		}
 		WRITE_ONCE(head->func, rcu_leak_callback);
 		return;
-- 
2.54.0

