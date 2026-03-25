Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B034E75A
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429846; cv=none; b=aCB3wpROBszWdPOC39iXxlgeHhNswp21JvsItVaWUaenl3O3rFe5Z/3n5WNNHO8TYGf8vvhPXbKUE6o/BlLkrTF6nd/iqg/neQl/UuFe5o83hJvT806k7/y3RANp8j894UlvWVj81YbLewhZTgyI72aCq1ouBjCuo4dh/g00Gb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429846; c=relaxed/simple;
	bh=mrfbrebLUZCOEDJjnautNoTo1l9b+KCTSw7ew/U+baw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOwiVhuw8WxhM/esfjqF6ZgHjKgvmYxhSggI4eYag3wlIzv3gHo2JIN/NTkq8Xxpa2IZWTISSw1UNvz5vItxluBrc2IOQGym1FPuxNlrt5h5FtFKdXfz6/vX32d9eYENBrMsGUFTg60Q+TlnAtUODJaWeXNlbXojXHdtLxrt5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dScfrMGD; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dScfrMGD"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c1092cc08cso2896143eec.1
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429843; x=1775034643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVaXBsXyrGbsFUqtfIJ4CxUQ0g0L6QfqD42wgzMQLJ4=;
        b=dScfrMGD3usRjutCEoZomIQAkSDL88d4lb616cZezuOz7CLOEftPeXjOiRPhgzz0UL
         kko2no15nbdrlt9XW1zSrI+yf3oGy37Q4TaBIdQ+Boe00u0OIZwM53lrCkmG3cBj4pHh
         FA+0o79zpu44tJgRlMt96R3oMlkaREpRItGR2mY8LaSN0HilphKJXryd4PysazU1boWD
         YXub38f1z6I/dX5NBBkK5tlx3HR+wGc6zFNWdi5NqewBIKBLDmMz+xJTStFRvcr4zUuv
         TjC5j9uzHNqZ8KMctgUWrmOJwysT3Fr3m8gd0DbC1JT3Kb576lvGIYFuhFQLvrt5oNTI
         qqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429843; x=1775034643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AVaXBsXyrGbsFUqtfIJ4CxUQ0g0L6QfqD42wgzMQLJ4=;
        b=bg4F5s8WrTt2sNl9hktPqIxNcM300Mfk1QsZTMoZ8Y1KBz7B872AEZeS6/x7YYK628
         SUwRel+1Y8yMrwoU+iG8+h4d5VJ4X6UAHs6kPYNLDYj/vhBvOx5Xe9CtrsHRTnjAWuxl
         OJS3Y/qpzw4tgemw03Rw39PQpWKcrQoNJttvvZlFDDZ+EvHidnWN4WGiufTq4Rrw6US+
         SiV7HtqhaUbcA8sAC3f5/tFmVShRnOfzIJgNlV0rsNZb7SfXFkuw/X+vlpSgOT40s9TU
         rThwcLMP9jUhW9rUfHUH+D/Dq1m5/49qm+O3bIFfc7V52AtATxFXl7+uDkNJVgYXxk/3
         VtRw==
X-Forwarded-Encrypted: i=1; AJvYcCV6a1/OZ9ggozml2zFCYDLBVoHMm+xqGs1WsOxWH/h28zv/yCBtBvolLXKNK5OL+3NulEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCI2+7TWhAMvWMYcS5aRz2+CGSd+HMdWqWDDzWNN7LXmhy2/Fs
	wbrCxQ7XKVBqdFEFqEvAq8iCDLYeTJtaxJ9lNvrSY86TXLtFu2wzgXZ6
X-Gm-Gg: ATEYQzxpRuAkhHZOMbQLrS9caCHAc4b1LSLIWGCj1ugCle1AvsCeMtqy0QrpzT4/Hvn
	oVwQOahjwldsnk7zB9XwaGwxhYozGlhbm/LzFcS5UBx4AkLXaifGT1HmxrVsNANepNxdkBXMbR+
	GGaHyNyskuewiJ9MGircGNM6eLGpNTb44xAhsIuB6hjcvNPLeLcgHBaweg9283pMgKcF4GXhpAU
	inxCkdSgJT/YBT9lg1/Z0J4D4cxcAG4AUPRxX4ZBf9GYmu+MVIlgswqSYpkoxDGwIccpITFC7sv
	Fc4CtsD5J3KhEi2tkOPeOshBWeyOsWPXX4TqlUPTpwFTNgocxbNPj7Dko2n0irvP1rcm7YqeJ5R
	eyMhFfaCQQO0MpgjvAXCgSgfmOqtz2TIISOjwcQag1LL5OYRHxVRA04tCA7mQ27pWa9ykrxa54j
	EboZJj91J/4xiyJjxA
X-Received: by 2002:a05:7301:e0a:b0:2be:9886:d4cc with SMTP id 5a478bee46e88-2c15d31dab0mr1366051eec.3.1774429843054;
        Wed, 25 Mar 2026 02:10:43 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:10:42 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:39 +0800
Subject: [PATCH 08/15] workqueue: Support dynamic housekeeping mask updates
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-8-919cca23cadf@gmail.com>
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

Unbound workqueues use HK_TYPE_WQ and HK_TYPE_DOMAIN to determine
their default CPU affinity. These boundaries are currently static and
only enforced during early boot.

Implement a housekeeping notifier to update unbound workqueue affinity.

This enables unbound workqueue tasks to respect dynamic isolation
boundaries at runtime.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/workqueue.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 253311af47c6d..ef3ef7e3fe81f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7904,6 +7904,47 @@ static void __init wq_cpu_intensive_thresh_init(void)
 	wq_cpu_intensive_thresh_us = thresh;
 }
 
+static int wq_housekeeping_reconfigure(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		struct housekeeping_update *upd = data;
+		unsigned int type = upd->type;
+
+		if (type == HK_TYPE_WQ || type == HK_TYPE_DOMAIN) {
+			cpumask_var_t cpumask;
+
+			if (!alloc_cpumask_var(&cpumask, GFP_KERNEL)) {
+				pr_warn("workqueue: failed to allocate cpumask for housekeeping update\n");
+				return NOTIFY_BAD;
+			}
+
+			cpumask_copy(cpumask, cpu_possible_mask);
+			if (!cpumask_empty(housekeeping_cpumask(HK_TYPE_WQ)))
+				cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_WQ));
+			if (!cpumask_empty(housekeeping_cpumask(HK_TYPE_DOMAIN)))
+				cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+
+			workqueue_set_unbound_cpumask(cpumask);
+
+			if (type == HK_TYPE_DOMAIN) {
+				apply_wqattrs_lock();
+				cpumask_andnot(wq_isolated_cpumask, cpu_possible_mask,
+						housekeeping_cpumask(HK_TYPE_DOMAIN));
+				apply_wqattrs_unlock();
+			}
+
+			free_cpumask_var(cpumask);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block wq_housekeeping_nb = {
+	.notifier_call = wq_housekeeping_reconfigure,
+};
+
 /**
  * workqueue_init - bring workqueue subsystem fully online
  *
@@ -7964,6 +8005,7 @@ void __init workqueue_init(void)
 
 	wq_online = true;
 	wq_watchdog_init();
+	housekeeping_register_notifier(&wq_housekeeping_nb);
 }
 
 /*

-- 
2.43.0

