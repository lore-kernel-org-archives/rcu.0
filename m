Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288C30AD06
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361574; cv=none; b=aNxXtCHa3qLsKlZf0J12wgTvPbKyhAiOOoBhQsWRjerTnruYFQCrPydgLzzOkRi8KuPZrA/v7JSNiMIHd9mWfJEi+eYdbhRNuDirvbswELYPuwiZhPO56iEGnrQ1dXDtS3i83asfqGvrmq+HjBBlnigu1J5S4PUPV14bW8s1EjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361574; c=relaxed/simple;
	bh=6a04V02JrKq+UtMy+kud93gsZRYKV/Lla4DLD0k2cqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akstIIUiNDXHwybPWMspayFiNxYDMeM7OzEprv4xL5W2PKgHDKYzoB2jo/6HNG7SSThpqAwjQUMsRsvRg6Wk5uuMZRMIR5oi9cT5abgoCAjHdwR3eAjVPhdSD0ss4vjnSdTUXLnH8x+uCLE07Ducgv1+/tCFZG3n1rsgrqtpVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSkBqR2e; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSkBqR2e"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124afd03fd1so480789c88.0
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361573; x=1770966373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvBmHx7kwJLfpYkQiDz3mWD0AMOGml1PQig1PAVjUmk=;
        b=LSkBqR2eL6UR5nwMRZBndcbURMFJdOjUd/7LtrdCVNaxoiZI9TTnSNToU8SmWi+nF8
         m3dZITaCsmObraDFxNiM9H12rXoZMHWiddHcfIKALFHb7bSZ3ag6ui/cfQJIRZgSsTDo
         +s1YV90hyKpxBxYx5S+RHGiQVEFVIvkqd/4bo6r1gIt3/UqSHXLWg59ZZPoAt6iMN0BH
         Qb+0bJtH01Ffmaq53tPnznlrmOxmHSk9qndRyAPNNUxd8lJ5DkwmZj9Kzuphg0R2eswS
         MIbxkCxH3hRb2K6ipttH4gmcGSR2cEk+ICmGxsa2uGUfjAJz4c5gu9g7v38gRqbAY5JQ
         X5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361573; x=1770966373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cvBmHx7kwJLfpYkQiDz3mWD0AMOGml1PQig1PAVjUmk=;
        b=jTaj8nhhYlcP/MuGUDddFhdcbG6qypC7wz0HbdO6WSGOcM4hBguDNECjDr8tQfWfsd
         GLEM2tQfhoCgPm2pvRPhSTuFhN3WKLNZEcsjTFiaSqIzUmWqr2OJdtlAI6LPqJPOwlN6
         o08ShoTL4FiVx087anT7NjHNqOXA7i73Sm6XLahi2dnl9YiU/8F6yPjs48Qc5mGbtW2u
         gI6qt0am4EAJe3HX9uJojIyOKxPqJpz6/clJTgd3nFj66uTo+YEMG65HJg1hdK8/gcF5
         E/VOAIy/z1/IVMLU/N8WALnJsJg+aRoYqUi4/Zbpy39JfOAJp0GV5lE2mDEq9A6Pi61u
         oubg==
X-Forwarded-Encrypted: i=1; AJvYcCXfocrwTcSUakSkK69qebddpRKx3rvMmj9BuW8YDGt58xCpYFq4KghPtAYEBzALLIBD6js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/1mU7QsfYDpjUVCd+iWgUPMekkUfq7aZpPAXKEOGv0M/CQqx
	W/mEmi0HCGtaFGOHZ25TYY2Vnkk4P4GnHSEqt/j0B4ufTny3Ukl3Fjgx
X-Gm-Gg: AZuq6aLf8VHpnXpd7Q+AoOpEaG9z9R2K2VLwPF3VKhECD0ZrE1sNNRVs1+wX2oWeTCD
	CzB1LkTaylRaNSgp8RG6a7w2sSOeg5kdZpK3bM5x9jjkCXxNghZKdbPutlqtFJAcStvtzLTBhgl
	Z90a/2rY/cG4ybJXQQwCjUbsYlkHIkAY7FnDo3XJbyCd0k5uN1ypXVDM0fzPpvTDs4rx/uABch3
	a0jdcbLS3UzzXXqlmPLKFFRv1i+NqolbJP6gnuh/iHS2uJ/vyIS7KVWvn8Sd3mcBZR1VKbtE0CJ
	REccQCk6tD7KBz8Mqafoq1pttPceHdYuHTKHMU96ASjegasXl1vlEcLXfjplOTpSXYSWIXRcwR4
	woBLO0Cy9gPp3viuPd5L25hhMH60qRKYdg/l2bs6OlAo2ur1pzefrm//bP3A1h2FQCZOS0TjXNv
	aTF+Z5N59Amw==
X-Received: by 2002:a05:7022:b81:b0:11a:e610:ee32 with SMTP id a92af1059eb24-12703ff4ba5mr818049c88.25.1770361573224;
        Thu, 05 Feb 2026 23:06:13 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:06:12 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:28 -0500
Subject: [PATCH RFC 07/12] workqueue: Dynamic housekeeping mask update
 support
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-7-00a711eb0c74@gmail.com>
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

Workqueues use housekeeping masks (HK_TYPE_WQ and HK_TYPE_DOMAIN) to
determine the default affinity for unbound workqueues. Currently,
these masks are only applied during early boot.

Register a housekeeping notifier to dynamically update the workqueue
unbound cpumask when these housekeeping masks are changed at runtime.
This ensures that unbound workqueues are re-affined to the new
housekeeping CPUs. Also update wq_isolated_cpumask to reflect the
changes in HK_TYPE_DOMAIN.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/workqueue.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 253311af47c6..b8913935d5e8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7913,6 +7913,44 @@ static void __init wq_cpu_intensive_thresh_init(void)
  * executing the work items yet. Populate the worker pools with the initial
  * workers and enable future kworker creations.
  */
+static int wq_housekeeping_reconfigure(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		unsigned int type = (unsigned long)data;
+
+		if (type == HK_TYPE_WQ || type == HK_TYPE_DOMAIN) {
+			cpumask_var_t cpumask;
+
+			if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+				return NOTIFY_BAD;
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
 void __init workqueue_init(void)
 {
 	struct workqueue_struct *wq;
@@ -7964,6 +8002,7 @@ void __init workqueue_init(void)
 
 	wq_online = true;
 	wq_watchdog_init();
+	housekeeping_register_notifier(&wq_housekeeping_nb);
 }
 
 /*

-- 
2.51.0

