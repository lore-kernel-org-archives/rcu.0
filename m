Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085066;
	b=KxJx9gWC4pJI1RwsIrXgAMkvS8e2eCRm9JmLZZVmi3+C4yg7n3FhrGxh0O++G3mK6djX
	 QAiuScjEymFfVnkFuuPPSofu+omEIzmkC8zkyufth/1dHk2UrTo6IC/OV4TI5ipWmdihO
	 QW5uH0SzmSKtJ+n9a4HxDU1VQjIhBWOWk3MdmoaVoyrJ+8Pgx0PAvSriBL1s1IdeeGXVO
	 5ngLes/asfEulEm9RgjgYcETtSN76jtsjmsuzjH5e9AAT1ckikmNNQTPjVKwo1SDpZHVB
	 axkyG8thbRHhm9fTXIGAHzS76O6JEwIoICCdaBxt61hhop/fGQOIOHX2hFrTcC1viVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JquzjJyvf3NvcwDt23a9P8thg6Ysb/TnHv/SZlZzeZQ=;
	b=eZN4c09lTNEje4ZwHiIYKKzP5w/BvHOCo4lXFQaTQqW9jFqj/mgMz7+4EwAvYPI9UtiK
	 wWYqDB+Vq93nl84BxZDGh03+TyRfbxkFAhJmH7CJoG4C5zaeqO+AJFdrZCtJAQ5zbN2im
	 shhdpHKQl9P4C2ZfUgfUsBbBXFA+C6kjPYIoneM8FE/XJuGOomgQi+AqQ9PsGpzyOoiby
	 ZZUZkxd/C+NXo9jUIpmYELs4Q1EYY3hN5Bnt0T9ougc29rpKS+QPaUY5VUHEkwWQ8yWGY
	 3lZymqgJ3qlt2Vstre0BW4bwHR0kdDK4KCeXvkvesJi56WUaAr0U9KQVi7rWrNoyWdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsJQkpPw;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FFD606A31A
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96FFD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsJQkpPw
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so2698163b3a.0
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085065; x=1793689865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JquzjJyvf3NvcwDt23a9P8thg6Ysb/TnHv/SZlZzeZQ=;
        b=WsJQkpPwdKm4vgaGX4866ERFXl/v29IpJ079S5HRmOn52RtYTilL1a/Ck6wRFbxX3V
         m9/nWZ7AbWOby3dHkKpwuY2wVE8QzbOc43opQIDUT/BAl/f+q+L55RNarz2HMOaIqCxw
         Br4lMRxbkVrl61AICDPnYWawq3gazYP82CNK8os1KkfHiOKkkCADqsUugira8K84wCye
         U3vDJ4WHrTPTBDk6NnE24rFt9tvc0DpMcG/iaP0CLH0BcuIM45VMPjfPV00EUaD1ixq9
         tWezK2fdCt6FDavOI+luon+JFlG6gQm6gOxcWAv5kJ6TQHRvD/sHucdS0vuIu1HM+lyo
         l2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085065; x=1793689865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JquzjJyvf3NvcwDt23a9P8thg6Ysb/TnHv/SZlZzeZQ=;
        b=BV7cufegRPuEB/7oVwOZ2nb9o1paX/KIcdGyhTHKo5RBCNn0Hubl4hZFnEYweNm8Jn
         70dP9fMLOgm7DhwMsNa848G6vRnFie/uX4CKSPk8lMcA1t3P7doEzcBOUWWkXj+qCvDn
         l38rebecj4PA9SahGjfEiudY20zgarWyOUxQdI1xK8TSIz/zZNWC2ZKuklnJipx75zvp
         fWkyMEUzfvwOCmQ+KX90kZ+pbc7XaSnRujpfeCgMP/uJLZTPFc2TrDi7oNtOnwY6jYYD
         DZo2lmr1bvFTKno/LKxTZlRy/PzzUFZ3Gy+CMUjq9xd03r5kQxbhbA3yVlv+iGcoMdIr
         Ir5g==
X-Forwarded-Encrypted: i=1; AKwUvByde6en8YDN7Aa5q8ywiBCiKAW3IhLqf/8Znh/357vtH5xJkaoJadqnLWqUiYHU28p2v1Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5l1H8FnydLWAK6hmeWjb+AAtp0Wr89S/ziKRPlDYkD1e4wfTp
	IOyXx8szGFkBoHIYVJA6NLREzP3wN3InkQwiFrEpRlEKO5mt4YQdMA6b
X-Gm-Gg: AYBFou04DvmczD77m6f9hzVJKCLkdpgpvB1m+z7p1JE83n52go2BXbkuAIL6V7QTQWa
	h+lSZnssm2xEx0xVFAzgj1XjEhSZ3xoJiJjTvIZDcr0ldXeP098o43IfW0zQm4GRQQzBrkdBh2w
	NjeKX3C8BQaIKaJCPUUm4T+rZHcSL8JZe+fnJSFPOd91DnEEnfYI90Bl9D8qAxoisJT0lQy0kql
	SNheu2TaWIOeMInkrMxxsKS+9bn4i6ixNNF9Qv5RSjIsqL0gDNr3E2vr0IsxnpzXtM+RMyuyrTr
	xH0CCLIWk60oIcNq+8J6OfLULgQJXH5mrwcwBoev4k1jKfi9fQzhWiWvwG3XiMXa9+A7OGL1hb0
	eXUiCkhfDLPDKVNCSAEXrjqW0AI7wue5jlPgB3EcQ2zZvBTKTj8NaBiuhf3tFLDinKKdm/bRkeb
	NjlSX7aTGv3n4mWEzIAX90V9h1ozfsAfHxwIKz9/3LSF78p0HU3oBUwn0BPn7vKb1OngQhZDMqL
	7YW/E8tC94LbXLqOyqWEvJyp9cK8oHz/6MpoaEmN6GuEPc43z5o8F2gq7WOzSDSlx+ir8ZSb58R
	KgUhPeOb2zx1HqwQYCI=
X-Received: by 2002:a05:6300:408a:b0:3e0:b445:5612 with SMTP id adf61e73a8af0-3e7bfa4a6a0mr7089526637.14.1793085064628;
        Tue, 27 Oct 2026 00:11:04 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:11:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2 07/10] srcu: Detect duplicate callback enqueue at registration
Date: Tue, 27 Oct 2026 15:09:20 +0800
Message-ID: <20261027070923.3054462-8-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027070923.3054462-1-kunwu.chan@gmail.com>
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
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

Move the duplicate-callback check from srcu_do_enqueue() to
__call_srcu() entry so that detected duplicate registrations
are rejected before they reach the deferred-list enqueue path.
Use __ratelimit() to limit the diagnostic output (error message,
object dump, and stack trace) as a group.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutree.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1993ddbdb828..81423b3dffae 100644
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
 	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return; // Leak the callback rather than corrupt SRCU state.
 
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
2.43.0

