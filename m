Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2B30AACF
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361557; cv=none; b=Ck3YPkF0zw3CFbC0ekHeRP96sROXXDqzlEBAZuoRqMsvtF3wC2SXmzPKD1w5JnjCCszMAvHX1aXJzoCLwkXfXV0KIWvsnRqRixLZeK2yVui+fg0r/lWznAxelrxloQLE2vuEeOqRthXNghIv1HSBJqIeAM9jP8ygrMsZIhjwIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361557; c=relaxed/simple;
	bh=ffNi/OfZqfCh3eY/Rf+kiDJpyM0ZNd1ZaRFXcbtbeuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=savaMu5Qp4HCwosHVfnTzOVqppLQ/Opstnc4oKVu2Dv7JHpCqJ7Igg5e4Qcu4TU5yt52F17+SpvHej5QuX2l5Lu6xjg22qBeFKGTA9NtGSY+xatlORe7qA/qxVU4Y4HDi4HJOZ/ZvrZdorlsFdj6WIsGoGb8jKXK17TYL5uLWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKe7OpWV; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKe7OpWV"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233c155a42so2439496c88.1
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361556; x=1770966356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB2/ruY1e1gP0SuPgYbrsKSnwM+7BBdQPj97g55uYUE=;
        b=PKe7OpWV6H11crVVO96cIwvAdJShjd5AGfJAPI+rXPSsgShea9vP9Xz6njLyTcq3UG
         BziXZr7EHd1hOto3OmgRa8Xb7PN+uk5tEOMG1jlU9R8sZ1qjPSjCm+uROIXFKZqQ0NVa
         Yg5JaNZj5NEB+ijNiMyOMmE28m23vcSjllu84ctjwvK7jwPi+YVFkASx9QKSjXY+WRJu
         uttnbMaBc1qM7+Ei009sJ3/QDaIXeLB4GEENT+GkxD8gF6dCl68AaLsDgrsYyEg2/vMF
         DbmtdhY0qQRqAGl9mxn2RRsB3WjnYdwD40hpw8/LAM2xh0RWG7B9u4iiYjbUYNO7okWk
         Oxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361556; x=1770966356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IB2/ruY1e1gP0SuPgYbrsKSnwM+7BBdQPj97g55uYUE=;
        b=TOPtQklVHn/VRkATU6f4pJNaeW/ZjD4MC20ZRTwOIzsYCPSq2OFl1zx/SqVDZTVN5C
         7bVLhdf9AsPVyp5i1jYVRPaQzaXVb6Ww+fB8xYg3nX/IRargzxTL4mSAhVDqHYqm8vbd
         mwZWTVZ/qH9mwxPT+6oy6MwcxZPjIAxT5Yc7Wn3VhjSGRSXUrIFKFZFYe1BkWdWD+k4n
         Ffa2Tzj625z2rjGpjWMiyw2/A42RYpo6Vlve4de0+7UVBr9yqhIhyIz6wBhUkN6kjhtn
         Yq3vSPapAa1qRg2lRpujln9s7gkQjHBoTCeET71zJtr/3SwM4E08kuU+yh/kKTyXp6v7
         HaXA==
X-Forwarded-Encrypted: i=1; AJvYcCX8j+VxZq584qqWmeaTGAX4pWiN+xic3EzT80YMh5ydSshwtXBnejRE3aiMgPye6pZB2nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/70JvXEt1tPj7F6ofM1ONSrlCfRDxOFYVwhr2mhtT0Hx3+kFK
	P8WOl9R1ZxGTfgGDpWC4yeMWo4CqAByHxH/eg4fwnh6Ukr/jQOdvIBcP
X-Gm-Gg: AZuq6aKmijZJm3e8k3aSEn1qqDSpyaq1edOVKXpoXEbssDVtZufc+TOJyH/yePn9rWf
	8aiN/JToCgvE+XEMkru4hOF04nX7sO497UIxIdUYVaua744LG48jqE/IuiUxrtHq2d9pYJ5hlql
	rB+Wzt66omIaOHcLVCu0UINXOWjCUTj1TkZK19o9ynE8mi7Mq0wkOEdCksWe/P0/6NeXl7HZ+LR
	IN2kBNeS/Y5NUKxjykWGafpajPwkjLqU2bbNH+aWL5ld41jOdgg4uhaERjc0wo2U/iI7Djn3UT9
	+iNAejpxWFcDfl/kGIXJRKNkoP53WLem+oTTN1wgK/2gproVA8A+YucibO3iQECrn7+JEFCKdt6
	S+YafcUktLq26YFaX7DAgTWGpHj5BiLqCnFzlE4zCOhRu3iXPm7hBin7MUfqn3hI9WLDAbzKBCq
	JScgSBcWcJRg==
X-Received: by 2002:a05:7022:4a4:b0:11e:3e9:3e9e with SMTP id a92af1059eb24-12704074edfmr999273c88.49.1770361556050;
        Thu, 05 Feb 2026 23:05:56 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:05:55 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:26 -0500
Subject: [PATCH RFC 05/12] sched/core: Dynamic update
 housekeeping_cpumask(HK_TYPE_DOMAIN)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-5-00a711eb0c74@gmail.com>
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

The housekeeping mask for scheduler domains (HK_TYPE_DOMAIN) is used to
determine which CPUs are isolated from the general scheduler load
balancing. When this mask is updated at runtime, we need to rebuild
the scheduler domains to reflect the new isolation boundaries.

Register a housekeeping notifier in the scheduler core to trigger
rebuild_sched_domains() when the HK_TYPE_DOMAIN mask changes.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/topology.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cf643a5ddedd..7f218fc62183 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/sched/isolation.h>
+#include <linux/cpuset.h>
 #include <linux/bsearch.h>
 #include "sched.h"
 
@@ -2940,3 +2941,28 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	sched_domains_mutex_unlock();
 }
+
+static int sched_housekeeping_reconfigure(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		unsigned int type = (unsigned long)data;
+
+		if (type == HK_TYPE_DOMAIN)
+			rebuild_sched_domains();
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sched_housekeeping_nb = {
+	.notifier_call = sched_housekeeping_reconfigure,
+};
+
+static int __init sched_housekeeping_init(void)
+{
+	housekeeping_register_notifier(&sched_housekeeping_nb);
+	return 0;
+}
+core_initcall(sched_housekeeping_init);
+

-- 
2.51.0

