Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085088;
	b=gC4VObOWcxwGivshuZgyxEcOzrzFup0z85ciFVBa8DTPfPR18XtgEgFN/L73rOJhzvE2
	 gtjqVsjQOMD/4ROjtZuGwcnRwLAusElsoMEeg+oASMNefWffd0STdW+/vbvYQtMijChhI
	 l/bspsLacc9k4qfLCOjd5452ZR4LdnmZmn+xNX0k8rADNoijJI3M4lD+QEezyj+Nvh6HF
	 EEVVKPM2knIlMlQci8aiSdZ1fn6JBU7OylrRXbEoQbmpAyoqqqtD2dRS/jTGgwLEe6zl4
	 g9SXBsRU2NSaOoAK4aGfdwaFQOewXSRGc3/juoCITqsffeRBjvqK9shk+Np8rcAN7nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E2GQKIdQM5uzG68snbI8euOUnqyt2y2f++AHs+X3HGc=;
	b=gmL8lSSmmX/5jhFRRV2OAQseJ+RBKazLl0a+bo35kGrA1skUdlsRnwP51lbfsBbsgw0D
	 SjlxpPLaQt8lJ4xqT89SEB8lWxFlUIPvaBQ0Uno1kPiRcGiqefmyZofkx7IZZhOWsrk3g
	 YiECGacFNU5HgfLiXmq+ELUQlCAFmKJsGmheUax+CRg9fWwqtXLsnWhfFPpAcO4M0ZK/I
	 HHfBBc1x3U964psQAK8UlwTeqsSts3/vUXH1V0sjJ1GCzTToi+AQ1BnyNWe5mCTG8HsM/
	 OnBrw26BPSMIPdKZsdotN1cb3dWkwv//F3+4BSm+OQ/AQrfN8uN4tT2oL1/0T3t3I+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YoQqTe3S;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F7606A322
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB9F7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YoQqTe3S
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1673955b3a.0
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085087; x=1793689887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2GQKIdQM5uzG68snbI8euOUnqyt2y2f++AHs+X3HGc=;
        b=YoQqTe3SrIoBPo2uF4cYQWKrrGQe91OgWdKUfDqkgsHpbHTw7L2/kNBomGuzGKG0Ec
         FeJ4lDvCtryNw+42J9ldJwC62wNwkB0YR61ARdaa50IQD2PhWNDgPqkSYDthN8tVos5X
         KcU6TO2LlAeGuAUakXuLNg8dTE5Nc0sX3zUefH1W5sOfF6F+9+/q8hJ+AerFmA/H+e/4
         0I23ooQMWZbPZI17ArUAov7xDx9hMhHVr0dWvOkBW9bjKOlnGYL99jAx9s9mnyHGjq6V
         R6MxtQbVGScKFIPDjCjcflWYgjXRKu0bpnQgUnnXFp19jtZRyM8F12wAzq0PYFAkKa9h
         /bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085087; x=1793689887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2GQKIdQM5uzG68snbI8euOUnqyt2y2f++AHs+X3HGc=;
        b=F8GEzL32yFZXvpnq/RpjtXgw5cdS0OEs45/4/8U/DKoZSxFdneSYX+Tu6lqBagxQFF
         fK5UBVzPO7PseK/N+XWsPOnj9ZbuGjMLuOSR9ITjmRXcznsd8Oudu6q0uUTvWDh9Qz87
         B0goAi0KkHlC2GDG7yiLUl0xRJgVZHjU8fUOAkd87+WgHzI4zboBIeWL/XO5aerfiLHV
         mSBGIaty5ITSftihUbS/fOZpcR6LGTLiDPKPUEDsigvhnXkHkD1SJX3tDg39kN2NpvnW
         V/w9a5NFJldY7CqJ9oJCmyNHX1MZtIshgKpWwRh3nURFNdiq+lAhOXHXcML8FEb280ML
         NVIg==
X-Forwarded-Encrypted: i=1; AKwUvBwdeY5lmqzqGZHyvuj4wBLd/0foN2pLkOoI7VSeW01GrxFUEo8DMNVIrLeEEW1aIyzr7Y4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMoy70YPuR1mqEuW4bD8q27+pZzpypN8BPiFyp+bjh/etRfnxf
	Ayy9S+4tuOyHCTs9sXxWiyaWLsiBJxs9VvaNhEWwX53V+OMB+HlCD3dz
X-Gm-Gg: AYBFou0BzoeaAvTg5CwwV7n+1edQSPSMaZVPiGtxHeZB9nEstPvBYzL1STC9EU67luh
	GeOHGTl4K4KcRbMmWWB+MTkYIoT8ZxSwl3TMMNh8G+nl/1J9yFP61qLtjFMWnsGiVyeZLVzmVAt
	/7NiMIxkt9FtOdVCTxnemnGKuNQkoQidaSfH0FrGWUmVIcsw5DdB79dlTVFE6eiou5lvKDwRzju
	zBIvNlMCad82APi5cTSf4Z1BJFdAzdc9Xv4ydzRMx7NswOmF5JBSRAKIcTAGT1KrVA7OCiGDLYt
	uHQaWhuVWyzRD0r7zDKStbmAFbCxUb7g6Dq+ars5alWGt92XmTMA1wTm4k8Kea6jS06OPtJgbr7
	jXEW0CSGEloWjTU9Fk8fuQTNq+j3YNBnlYq/RCa5bxrlahx1SPdp71NbTgaFbWQCNWyVU+CZHWQ
	DDURrS06CdJtH152U51zWQvC3+PNZZJaCM18l7I/42QQnUb6+7nOgvpIMmpA0YPzsGbb8Wue9EL
	8w9ixiplCDTZ4WNi8ycAyKriL7tEZyypkuRZ9kW0lFs/KztuxjAAwovaewwxOqrRzGXZcaTwA==
X-Received: by 2002:a05:6300:4096:b0:3e2:b482:ba2e with SMTP id adf61e73a8af0-3e7bfa3401bmr6314626637.14.1793085086813;
        Tue, 27 Oct 2026 00:11:26 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:11:26 -0700 (PDT)
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
Subject: [PATCH v2 09/10] rcu-tasks: Detect duplicate callback enqueue
Date: Tue, 27 Oct 2026 15:09:22 +0800
Message-ID: <20261027070923.3054462-10-kunwu.chan@gmail.com>
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

Detect duplicate callback enqueue attempts in the generic
RCU Tasks callback registration path.  Use __ratelimit()
for the diagnostic output group.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tasks.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5d7f234795b4..d5d060a5c4b6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -6,6 +6,8 @@
  */
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
+#include <linux/mm.h>
+#include <linux/ratelimit.h>
 #include "rcu_segcblist.h"
 
 ////////////////////////////////////////////////////////////////////////
@@ -339,6 +341,12 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 }
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
+static void rcu_tasks_leak_callback(struct rcu_head *rhp) { }
+
+static DEFINE_RATELIMIT_STATE(rcu_tasks_dup_rs,
+			      DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
@@ -358,6 +366,17 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (__ratelimit(&rcu_tasks_dup_rs)) {
+			pr_err("%s(): Duplicate CB for %s, %p->%pS()\n",
+			       __func__, rtp->name, rhp, rhp->func);
+			mem_dump_obj(rhp);
+			dump_stack();
+		}
+		WRITE_ONCE(rhp->func, rcu_tasks_leak_callback);
+		return;
+	}
+
 	rhp->next = NULL;
 	rhp->func = func;
 	local_irq_save(flags);
@@ -586,6 +605,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		debug_rcu_head_unqueue(rhp);
 		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
-- 
2.43.0

