Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750800;
	b=dpj7v3iVERArcyAYyPR/zoo9J+ptVyd21NDdQE5PXmH9rpvCITud9srW5yrvgeUlaOVE
	 KSUXRKtCvXbfLbyXc/PoVjuLRpGCMOcJsQVX9UJvup1HjbqnxJAZAnlJ+z3032ZvQvzq2
	 5/xjrMoFfd36UX2REOGLHV40nO/a+aASzIabBVHa7keW6kA2Xi/K16pY+aGIl5npxiJWT
	 ZonQNZQAfEW7uMshxBmJUFJjLPVOMoA0gBqTr7yYyQVDHtSMEOJoCSCfe11TLpSoO2EqO
	 YkaGZ6hRIEl/HIaW/pLa/7i1lblFGJZln3yABronYGJ41xzT9VDf5+2+9wQBqXUeU3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cvh1e2ACKZ6dBS33vYatxd8Ssl5s8JzjtHSDS9Smmho=;
	b=DVMM50rVqOVCdoyX3AqTwSE2QMtOhHYMIXTsDflRbGZlQCA7J7TX3hW9xLOLqKuc6LXG
	 iwWY4HPjuxRcSHocec//mpTz4aX/MK2Yae/MCis96iLDzILFFeLnfchOg9qOjeNlq8yFg
	 uyk0X6zA3Dro+h74YASO9F1rU/Gur/WU9URFS0oInDvt59gkx/x/OLNGK5xWEuSvRyRXs
	 tY6EgO/9LbEPSmvDIKKss0RX9L7JlXsNkkQjaLjMv7GPBC/vNMCZHDToHsBclQwBamoT1
	 lDAkHNFLXF+7btgszEaXa+hGUj5NJ4e/S6tGW67LCdlICOGbU9Pdvyj/RdWb2PXCRuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F8vFIoAj;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A6606A31E
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C40A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F8vFIoAj
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36681e85e87so1783261eec.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750799; x=1793355599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cvh1e2ACKZ6dBS33vYatxd8Ssl5s8JzjtHSDS9Smmho=;
        b=F8vFIoAjg93S+5E4TRlD1x9tixLp91pSGF3ufTJP2VdXXsexiqOikCYA7zExeiqRN9
         tf5gDjpcTNUewI28yhwmbgzXAU8OhJ+gzbdplIMv0AVptffhVcv3HJrO742scx7B1aPK
         woNlSsbYqUF2J1O7gsiC+LT9G7wgDTK8vI7A3Z7i7e4w2VqkB6wIliTshAU0NGL7gmR9
         ZCr+wskKXehRyrZRH0ct/CGne2+kW1ReXnUF7WQN4gwS4JVZy5LM53frhfJrp6P9Bpey
         iwaxdkbXxLXr7yw5U0nFAaZffoqqGuRUoF5kltnDtMoQku6Vt1rjZnXEYfJSLF68gdq4
         SW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750799; x=1793355599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cvh1e2ACKZ6dBS33vYatxd8Ssl5s8JzjtHSDS9Smmho=;
        b=h/Cc1vgrT05p5R/Q9f89pm/VSWqjNHA5UjsNv33GoHcW09vM/cO3ZoCsp09+Uo04XZ
         rjPau6i+mJZXGw0U2lhvritWPGOdzGBphTN2PUd8UWCgsCqNCyNGEMeKnRyozFKwgPZl
         KPHVCYg6D4FvrgenDmTv8Ypqnh1mpNDsXPWsCRhKxabYNBDbLmhoJvU9lCAh2chIzCGr
         NbhtTNJ3btoMtgccMYD89klO8b48x7Rro2DpyG9DNRh6GUHUjsrLY3mnOCs7mMyTsp46
         0YmnQA47jnKN5rRknc4nyrSgvDkg0jOvWuM9QvG0dxJukbcmj2wydvvSutisXxr9clKp
         zFDw==
X-Forwarded-Encrypted: i=1; AKwUvBwmTrlDUmh+Q7UFXeZOkUhgPF8biqbCshhurH8QJARDfIltBK5f5cEq5rQRNzK9OOad/tc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLby0Yqab2bwPpi1jt/kVTILsA3bueIqbtNWCmFMzMpl5MUa3RO
	jaWhn8h0ddZfwsrX7cb8/OlvcJhZsCnFU2pmQQLlJ5oOcZPu/VwekVTB
X-Gm-Gg: AYBFou2e73aCFsQAm022Ay7g5o1GxEFn25sPy2kLBaiMvY411UkwH0OhRIL5IUbmpp3
	sO1mOGAR2VjCBR4OGwouTPCMAaR/sAuxp0aQWN7rBFojy1LUMQryJrlD88ZxKhU8CRWOBr6Ct8S
	DjDIpMirpmtpxiuMz45iC7i7UlbyFdwzgXnkTemnIL2FDfQlRTDeCrEQnUep0Xcw8u0WXUIvws6
	f17EFis87EzTqJi+mBNj0ks524w7cEN0rE0wprW4oGFaxCvGKQXTvzp9gH4ZyDoxHhhAivSp5Id
	upNvWoWVAUxcLsWEJ1+rDzGa6ERThn5R+kpOb4OAbUx57/Hju0PmHM0+RkySMMzazO22lIlpGPW
	wQN0hUFJsTycWkMNkvEW/KHFTNH4CJ1pgsX1lKo/stQGPaSXHsXITqTC6qoqkCzgeuuh8Ypwo/z
	nhnqHbd7X6Qaaj7+dEcOApYqXF0j3jXG4gq3gPtAYxbTbE05uFejOLuQmjZ7tDU88l/R4dN2auW
	+9zT76yBJvfe51UrgA0whhZVcXO5w5XVjYO7PBCNnbV1PCtvPRSriAW1pXhOqbbM5z4EOU9Kw==
X-Received: by 2002:a05:693c:6384:10b0:35d:f7f4:bc1c with SMTP id 5a478bee46e88-369d971e05bmr2648699eec.6.1792750798851;
        Fri, 23 Oct 2026 03:19:58 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:58 -0700 (PDT)
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
Subject: [PATCH 9/9] rcu-tasks: Detect duplicate callback enqueue
Date: Fri, 23 Oct 2026 18:18:41 +0800
Message-ID: <20261023101841.2910719-10-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023101841.2910719-1-kunwu.chan@gmail.com>
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
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
RCU Tasks callback registration path.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tasks.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5d7f234795b4..49b716feb31d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -6,6 +6,7 @@
  */
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
+#include <linux/mm.h>
 #include "rcu_segcblist.h"
 
 ////////////////////////////////////////////////////////////////////////
@@ -339,9 +340,12 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 }
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
+static void rcu_tasks_leak_callback(struct rcu_head *rhp) { }
+
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
+	static atomic_t doublefrees;
 	int chosen_cpu;
 	unsigned long flags;
 	bool havekthread = smp_load_acquire(&rtp->kthread_ptr);
@@ -358,6 +362,16 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Duplicate call_rcu_%s() CB %p->%pS()\n",
+			       __func__, rtp->name, rhp, rhp->func);
+			mem_dump_obj(rhp);
+		}
+		WRITE_ONCE(rhp->func, rcu_tasks_leak_callback);
+		return;
+	}
+
 	rhp->next = NULL;
 	rhp->func = func;
 	local_irq_save(flags);
@@ -586,6 +600,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
 	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		debug_rcu_head_unqueue(rhp);
 		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
-- 
2.43.0

