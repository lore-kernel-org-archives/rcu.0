Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D9331EC6
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752350; cv=none; b=gejUNkPpemuel4jsvpTtqv5+bDpQZjMuqDihKKtQDxG+whKCCNVfhn6CwImmOWx5SuwQdUCyLd3F12jSNBQcbhbQd5R7H9w/h4CREoDoJZ6UEs2U1MyPpGerBjgt5RyKGhAgFnkBCITF3npbOaEmQq8k7xrVTWX+unNVmbCO6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752350; c=relaxed/simple;
	bh=CGVA/ZVSxDQwk3QuV1O5/oZqn1YqVi8jf66NBKmDl2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ei7E3U4WlMTI2npYtIeP8/LYakSeJOm1Ouj4/3yah8OONO3ITN7But854+/zi/FRgzsIeqm3TvHmUn0fUOCT2A3Mw3+8dy3jMwVrZbtU+LtMEGlKLl5qJGYr3Pb9NPcx+A1OTbLFLKsQuxCNhxFQs/qbBwL2oOHzVNVsjgdpiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKV3MOor; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKV3MOor"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c40397e746so2965915ad.3
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 20:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752348; x=1782357148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSeuXyNGDp0AEfOTbyJ0TXed/qE2r/+QX9gKv1aP6Yc=;
        b=SKV3MOorcrjwv4HA9Mg8Ix23s1nMLV28lvCxj2kIbssmS4bXrK2jSPDkwBifo5gJw7
         wSKtcC8O9qdpYPadAeq/CTzZhC6LkcTE3gIdRSduX1+t1i+lG+71BZl3fUb4CKTtzDWu
         8hkvlCYTlj7XEKRbAhGc2dt5stId3Dq7VEqoC8GKcwb5/HaZ49r5iZ8Waus7OzN9O+Kw
         dxh0g1eYs7ay1/x9E3KZeSOD7WgAz27Uh/QAoGmi3scboQdvwuoki4eTEbJJz272YcuY
         SXP0ltz7A6aPr8F+OKocWKUQpUTnS3y9XkuNTbhsZqrcD6+AqjermA3T32B6w1jGxp6e
         5zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752348; x=1782357148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jSeuXyNGDp0AEfOTbyJ0TXed/qE2r/+QX9gKv1aP6Yc=;
        b=Mo18BUCBuvDhSq91dhryQRc0V5awZcYq0RuhNjNekN/eQo9a7VQRif1shnOiOpMJ30
         LREK5kkOv5/na4BrTlaKoJoQBLJQlak4w3FUyVUv8GjTm5c9SuO/yOgDy137XcbhXL1e
         f68jrKqYfO2PCbBgnv6D205e7NgPk9nF/rfrAoYuwmLWoGh+qo8Y63q8wqkemyIq7I62
         XwBJZyots2024rB5+NSZn8yVgSN14vc9ikDdsoDljUVamLf4UX5sw2oxmFwkgcr+27kE
         YaW4EIw8VfrEUA42V/PL7kYC4jC3kOw3impFxFhNa1ogb7itDLjAfX7pG/c/V26mK6Uh
         sAxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WWhEtt4mcgfxMRZ+V7bN4Quzjd3GY1ssc1mqVeO9kyENg1pVD+l0YHxFc+ZKUGNNHdIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xaCMdnBKo8P9Gmcyc2DaXfJJ+Kd7Nbld3AEqJuI1PCONao1H
	ADFiWbMokb7OmY9Vs2ndOmSbYrbaLVuZAuyJo+Knhs1kfdv6NFUhgeor
X-Gm-Gg: AfdE7ckRfButdZG9/c2Xu33JQ17OmsJZXGOXteRYft5V/xzLITdypYMH1n1JIcRYz3L
	2Sr1pKOARu5jMxX7QI62Jq5bhffpME9d0JA3AqBR0F0jQ7ccdi58LiW93VE/dsaXiOi2DXJkhrO
	dAsDFgV+gPCMWcaFFFG4SMRUtbdQte3qtpLuiRJdrJTvkLjfKcDYjA5H2fRVlNgjH4hX3P5RwI9
	PX0otRy3zY6vaijLA6jZwXq2jrc/5jqUMgY1iS2fdg7r2pLz6Y5K0aZK7jziJ27CVbZgmSZLgZc
	jUp1bOa0wsqQpi/dYeDEy1v91L622FSz0Yh61nmHcMMz7r1RYWsrb2I/eTq/HtiS2rouzPyycFa
	uFJ+TNyT2PEapKpTIkEpdEY49B6aoGotsxBtjStM4R3rWeftUT/bbGcMrmYP+6Q8bJ3jhpy5E8y
	b+klV09LkWZlI=
X-Received: by 2002:a17:903:19ce:b0:2bf:128d:f7ff with SMTP id d9443c01a7336-2c6f34327c6mr5866785ad.16.1781752348483;
        Wed, 17 Jun 2026 20:12:28 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:28 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:21 +0800
Subject: [PATCH v3 10/13] sched: Guard sched_tick_start/stop against
 uninitialized tick_work_cpu
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-10-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

sched_tick_start() and sched_tick_stop() are called during CPU hotplug
for CPUs not in the HK_TYPE_KERNEL_NOISE set.  They dereference
tick_work_cpu, which is allocated by sched_tick_offload_init() and only
called from housekeeping_init() when nohz_full= is present at boot.

When the DHM subsystem first-enables HK_TYPE_KERNEL_NOISE at runtime via
housekeeping_update_types(), tick_work_cpu remains NULL because
sched_tick_offload_init() is __init-only and cannot be re-invoked.  A
subsequent CPU offline/online cycle for an isolated CPU triggers
WARN_ON_ONCE(!tick_work_cpu) followed by a NULL-pointer dereference in
per_cpu_ptr(tick_work_cpu, cpu), crashing the kernel.

Since nohz_full= was not active at boot, tick_nohz_full_running remains
false and the tick-offload infrastructure is never activated; isolated
CPUs continue to receive their own ticks.  Guard both helpers with an
additional !tick_work_cpu check so they become no-ops in this case.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 371b509d92164..df004e3efca70 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5778,7 +5778,7 @@ static void sched_tick_start(int cpu)
 	int os;
 	struct tick_work *twork;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) || !tick_work_cpu)
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
@@ -5799,7 +5799,7 @@ static void sched_tick_stop(int cpu)
 	struct tick_work *twork;
 	int os;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) || !tick_work_cpu)
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);

-- 
2.43.0

