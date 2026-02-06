Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DC30BB9D
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361582; cv=none; b=Eq8M7u1xj2De8/T/dTgozlM7SKJwNWmWd4fX+foRD2dzQpvI0gaiPZ07gFuCmsw+3mrDlgqotOLdVup2ikgpe/WjZzTcnIqHBByGTDgwwBRFk7lppoTyZ/1RmkLZqPE0SLhndT8WgOaAqTf5sfnm3w+O2grCeMXwG5/UmF0lVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361582; c=relaxed/simple;
	bh=UT29CcuMRb3rg0RO1+fhXxr1/+A+Ym9oJ4TW4s1z3Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7mLq+R+A9vd0aLfRX+EdND/Ra9o0lnFJ4Yx7Ww6PVcu9BanvXzG37+ILZQOJcCGCU9uA3PC8+tEazgtNxF6Zym8l3GtfwcOSAxGY3gEaqd4M7ZEh87RQsmZ6nrq7QnTyLjK5GRPfz7b8DTix5M2uvxRZ6y4prMjZsdMvZxHiUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFaF5yZv; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFaF5yZv"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4b77adso2106869c88.1
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361581; x=1770966381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BERFuyeKcGtNuzKkAmOfXnG5ws1V9eOTpauK4BW51xs=;
        b=EFaF5yZv68QQNl1tm6Mm9e3E9keRNcIePjuNsoZdRFtAbWh8rKz48nPgcbaOO44HUq
         yY+cvPntDO3UYps5J8+Q5EysHSzGAVVcDNutGmHxOdaObjJJLoCKojuzfQHDZjHmD46R
         fXIvkkJlWk89ORllqVsnFUnzM2+Q8WNqa5UJIiTDwpuST1/MGOsZMSSW+82ppsjOg4EO
         hSw5sjTAQyEKKDagyaIhKQciVBMQ1coKf8XsJre/kUFCkaARAYQEY9R849KHK7rPjVmO
         Z5r40DSAVbMwWkOEWmfNAc7Z83po8uWpV4ZWRSQUhe3YFqSNmF5S2+VJW93V3ipcVRUG
         X7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361581; x=1770966381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BERFuyeKcGtNuzKkAmOfXnG5ws1V9eOTpauK4BW51xs=;
        b=AK3NXn5xK9TNaaKqnPwTNXE4n0ddDiT/EJEsarQ3fGyJ1AoosAH6tvPpnDvYgyQitl
         5BHowukKpNiEOhCvdiHmtNVPzKRk3DC01tIyEUqxpCoO/v2utzvUY0GgZWacXIcpE0Gm
         c1u86nnstdxaOXZTVYLMKelYrZ8t+1RCDkv5rR7IKdh3ZV1p1cqrmTuI0yVyk62K5gQB
         ZiHgcH5vGvajzqZBBjr6Mtv6nVwYFsPzThxmN5po+ocVm9q1pCLoWY6zxKpYoPUFbfa+
         kjueJSDtLXht8pjho8WqJnzB/i7C/IS/0dFD8OEsF2XQ2SLeosatdn+yTqbXsFz7HOQh
         2mMA==
X-Forwarded-Encrypted: i=1; AJvYcCVP01L+AvJFTuxq8RsTuOqpaDbh9gsA9YLovgKSCQq6Nz5lhMIGCzfWoVT8HPL0D5HqSzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQPL0bTksuZ3vwBDyk/pY/Fr2DH4R3uPOhAWs7wJ7VVRoh3zD
	vJyTbdbAZMpq8d5kH71ysIP7hHeOLj/1hNqd1beBqa+1ydpxvhZKy2I0
X-Gm-Gg: AZuq6aJKeM1sFBh6eDcBb2hxhuf4iM8sk27c3qEigZ+FMpJ3ES1gcOFtzc/hQoIl7hT
	m7jn6m4YR2RDYn1iHRRg0t0InvTAHAYW629QUcGv46hb5bpX4tLS4CoAthwL3OiuUrxrRdPdmvk
	f1TmD4RS3GNvHdMmdzfvuz8KfmcwxqS4BLikKW97WN8MsLgB98InOtQIpXbWtjBYvNsByBthDTa
	/yswGKhczgchjQfAVF2f7yTYXtyfCL4jhD98EDKR1qpRCVlSKsIHBwfB9Md4MeWo/jGfsMPIMzT
	E0Z6SRIGMlL6hAPf4QNB7HB2SMBADqK+VLgEbRCNenBi9QgU9MMsPZfZGmox+SXIYhCfMRnViq2
	xvwAZj5yKC+PfXmXeVlSc7H9+vok71cKX4ByX6gH1o4y3DabI/X4Ym1Jlj3uczuYcJWNRo2WfKF
	eW8iaq4+eQI3cWDqDPwGe9
X-Received: by 2002:a05:7022:226:b0:11a:6424:f40f with SMTP id a92af1059eb24-1270401630bmr793866c88.36.1770361581202;
        Thu, 05 Feb 2026 23:06:21 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:06:20 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:29 -0500
Subject: [PATCH RFC 08/12] kcompactd: Add housekeeping notifier for dynamic
 mask update
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-8-00a711eb0c74@gmail.com>
References: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
In-Reply-To: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
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
 Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 Qiliang Yuan <realwujing@gmail.com>, Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.14.3

The kcompactd threads should respect the housekeeping mask for kthreads
(HK_TYPE_KTHREAD) to avoid running on isolated CPUs. Currently, they
are created without explicit affinity constraints beyond the node
preference.

Add housekeeping_affine() to kcompactd_run() to set initial affinity,
and register a housekeeping notifier to update kcompactd affinity
when the HK_TYPE_KTHREAD mask is changed at runtime.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 mm/compaction.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..495106d970f1 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,6 +24,7 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include <linux/sched/isolation.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
@@ -3246,6 +3247,7 @@ void __meminit kcompactd_run(int nid)
 		pr_err("Failed to start kcompactd on node %d\n", nid);
 		pgdat->kcompactd = NULL;
 	} else {
+		housekeeping_affine(pgdat->kcompactd, HK_TYPE_KTHREAD);
 		wake_up_process(pgdat->kcompactd);
 	}
 }
@@ -3320,6 +3322,29 @@ static const struct ctl_table vm_compaction[] = {
 	},
 };
 
+static int kcompactd_housekeeping_reconfigure(struct notifier_block *nb,
+					     unsigned long action, void *data)
+{
+	unsigned int type = (unsigned long)data;
+
+	if (action == HK_UPDATE_MASK && type == HK_TYPE_KTHREAD) {
+		int nid;
+
+		for_each_node_state(nid, N_MEMORY) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+
+			if (pgdat->kcompactd)
+				housekeeping_affine(pgdat->kcompactd, HK_TYPE_KTHREAD);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kcompactd_housekeeping_nb = {
+	.notifier_call = kcompactd_housekeeping_reconfigure,
+};
+
 static int __init kcompactd_init(void)
 {
 	int nid;
@@ -3327,6 +3352,7 @@ static int __init kcompactd_init(void)
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
 	register_sysctl_init("vm", vm_compaction);
+	housekeeping_register_notifier(&kcompactd_housekeeping_nb);
 	return 0;
 }
 subsys_initcall(kcompactd_init)

-- 
2.51.0

