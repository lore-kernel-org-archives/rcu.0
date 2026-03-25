Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D434EEE3
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429829; cv=none; b=CzSOmQ3SUiGpQNJ3DsZSOJPXOWjT6G942b5aHHN6j5NsERFWll+DeywUikHIE2Kvoclunn/BbrC23Jg8KNXVG2kkP23oZ9+2c4wdocnYFH4hJ1tecV3zVifz5KmAqHHw6/h4jpBcH7tZi9lC9pQEV6yViM3GF6TjSNP3HyHBgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429829; c=relaxed/simple;
	bh=t+n2wTHFkqljFya/mEg/ADCwcFPQysDFOOajjS40Mfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOL39viJnxw5WVeSTAOwIPPI4VO96ddwARPNG0nb+S5py2D7UFVUbxSny1UFkbAfp0KquPTNfHY8E2AJNSOaII6V5WmssRvN1dWO6ugm3AwP3+9GoBNwO6bdUQ0EOv6kauJlZgrZQNyy1CG0mxHbLOjqDxN6tpNTmo0yVjYPQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzalt8JS; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzalt8JS"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6b0500e06so7603028eec.1
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429827; x=1775034627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw+tpbsqbbsakcxSKodY3EwFB9EQzmLwAIJ3DaHGMD0=;
        b=nzalt8JSKq8WgAhF3h8VTvFTeHyTYbTNL6hc2zTro/0BTNkAF3E5dVVBLM0MxHn1VB
         3DqSP551b/GJLchDjqAJKMM14c7LHAEZc4P0i6eFGvyXjkusAg4ApDeXTuQDAe5qKgsU
         nEqGrBecjWJOSyU7x6o1BmxRrN0+/drLu3GDmE+psilxIjCRTb8mMlo1J5D3Y+/0xraM
         xqDOAIsHIqzwfb6YlPULWsA6L2RGUTS7h4HgGP0KT2bGo+F79XvPk7tOxLY92JjH4Sc0
         iSvllnDgsvIJ6Tc/9VFhnIfUBWi8w73m+iYtOc6ZDL6LzSoEp9z8mS8lj7d3MqWh7nB9
         qe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429827; x=1775034627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cw+tpbsqbbsakcxSKodY3EwFB9EQzmLwAIJ3DaHGMD0=;
        b=Es5xEAs7FpyXbqbkrDiaUBd7i9zm7La9t+VuTDx7WVMxcrYeolncj+7jYfYbRjsAhq
         SABW9X6jlxbdOY9GhNZjXisPFub/bsnu3X+xbZT08cBWy6wqXWYYzQBhuoBytwN/PCgF
         LChoodphQb2g0QQEQnDfaV+H2xx6QnJUMSgxAyFmxadCPG3dSaDvKdL1YztEyBZhvCR1
         92UVItixTp1M/90p4rd2M9sDZMpCg96S8Kg2VPfdarCnIWFsUlnw491uhqWYalMvOwBr
         EyffFzwWiaqNVdQVNOF1UJjcfiLzohHto/RX6tP4F7GAO4xnnRWLe0CUlKpoEjfI5G5d
         Dr4A==
X-Forwarded-Encrypted: i=1; AJvYcCVkJRclSREfy5G9tBKZ/aW4e3GuFN63xMIrGP8QwqQB3i4h0XD5he7UPPVf7KX2kgz14Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCXvPYldWiL7qElKKPL2Qk2vBWs/WeCmb23igJO4hsEFEEfSm
	7MY5ihNzoRBw6BlDBHzw8TNwEZZKEcmMR9R0ZqGd+A1L2tUHZXv97VGy
X-Gm-Gg: ATEYQzx2tCl+aRqAFHlh8NYuaaa7TX5DRIfTzvb5hT8ehaY3XLbaP2gq4pvVU4GeOkH
	uCilqyS9/VAjXRDTaasj5cz6eix5dibXZgE05GB9oasOlh/sKZutsPAzDTD+Np3aaILluHhlPzb
	I+fufGnmIzM5uUvHB6cp0ULSyDiLmyoT4rFZTeOhB8E5uw6mTEwGoXf187q3/GH9LhBWzFive/k
	jAsTJv99cnTnIhtppCr0DUdOwlw4OtLkbMmQyrsVBLmeKsjj6TiTJahcEp/m3ttLEFDj6us4MN8
	qYAwNL5ortdGinLqjJNa9D+rUM5+muEQL2m/v+vzQkwazKtYdtiq9Cx/OQFWXjD81WDqPTVSMs8
	AHL/ujtCBZzoAiVSdjqH0USNG5pH4YvSUwRF4GT2vcKvvRz07Ht/4VmWzKmdBGr78n0uNWtuHVW
	Z5Spc1o1ghIM3i++yJ
X-Received: by 2002:a05:7300:cb0e:b0:2be:e4b:60c2 with SMTP id 5a478bee46e88-2c15d291b93mr1336228eec.5.1774429827089;
        Wed, 25 Mar 2026 02:10:27 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:10:26 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:37 +0800
Subject: [PATCH 06/15] sched/core: Dynamically update scheduler domain
 housekeeping mask
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-6-919cca23cadf@gmail.com>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Scheduler domains rely on HK_TYPE_DOMAIN to identify which CPUs are
isolated from general load balancing. Currently, these boundaries are
static and determined only during boot-time domain initialization.

Trigger a scheduler domain rebuild when the HK_TYPE_DOMAIN mask changes.

This ensures that scheduler isolation boundaries can be reconfigured
at runtime via the DHEI sysfs interface.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 045f83ad261e2..ddf9951f1438c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -39,6 +39,7 @@
 #include <linux/sched/nohz.h>
 #include <linux/sched/rseq_api.h>
 #include <linux/sched/rt.h>
+#include <linux/sched/topology.h>
 
 #include <linux/blkdev.h>
 #include <linux/context_tracking.h>
@@ -10832,3 +10833,25 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+static int sched_housekeeping_update(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct housekeeping_update *update = data;
+
+	if (action == HK_UPDATE_MASK && update->type == HK_TYPE_DOMAIN)
+		rebuild_sched_domains();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sched_housekeeping_nb = {
+	.notifier_call = sched_housekeeping_update,
+};
+
+static int __init sched_housekeeping_init(void)
+{
+	housekeeping_register_notifier(&sched_housekeeping_nb);
+	return 0;
+}
+late_initcall(sched_housekeeping_init);

-- 
2.43.0

