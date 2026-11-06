Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973846;
	b=BDpNQmnsT12o5eJUsHxwJ8Vxmf6rOxoQuIbTOZ5oGdi90aRxlVqBZi1SPvUrSCOnibcI
	 PPkr942qCZV294WFLqpA8fBW4tG8w3PCGsB8qtKiFE6ireLFpXS+pNPh8DHMDtzNB/RLZ
	 Cxlpn9vBt6TOaCWpRu3ApX7qYlGkJxbRMzu5XEJM3jYquEOM5rkRf7/lj8otC9q1CMRJZ
	 VCWVHn1sQZ3utu8EFDTGhLemqofDjX6qIohIb7cfiBCjGkSbUdR9yn3YqzqzeYH9/9FM9
	 fIVtPM2B1LPv0QKzcoGwpf8IhWiRHzFtsCqVEOHRkjPpP+Pqta3E59mF5WYU7PRwbgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973846;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=2POFqhBdX4hWO/hojONQrzEFt0JAY/xmNxctemziCs4=;
	b=Ygarbe4ZmO8v8qCJScdYtwE8eFTcfQ5z7vwQP9WrVjztA9qhTMkmEh647TWVcrfajPh1
	 dcIO8ITzBeOy+mfVCSmwBwsclSoaELuGQaaWK4+JrllS5gaL9M3X6DfqnHPZHekswrud1
	 EhVOmlIOQfsHlm/jPv50m2EEGUn+5JLlcLXfjHC9feIhK+2K8QIr9tRrqyynkOPurH3UN
	 4dLfgJ7ZoPkQf8NGtbeueQeWIs0o6uzpCfVT+TQo8KzOQVuFg134XvC144+qD0ZXTseTP
	 zqakhzinlF88PG8as0HMgCIZt82XxOo7YX8oCfT4zRAmCC8S+EfUooZztnfRPo0MFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ddswAkxd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=J8vrAzlw;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE0606A32E
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 14:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DDE0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ddswAkxd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=J8vrAzlw
Date: Fri, 6 Nov 2026 15:04:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793973843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2POFqhBdX4hWO/hojONQrzEFt0JAY/xmNxctemziCs4=;
	b=ddswAkxdodHlatVr2rgkk+Y0/hiKaDFaVHpxYwUxUGKJul2CAHWe+Nv2W6LjNnQY3sAiOb
	XJ12aCfRGZ+Ovo4jNq3SzkSy5S2+GU/3EbDGo8fMCxnI2Lat1RMlUHbZLQiEJVIVxX10M3
	LE4sIYQCHHv6DyPxmzvyApkQ6fxv7xZPbnBiPLWzF58MFsA7EJIHu3ftQtMkliub53psQ2
	x59G6Xos7UgFcw11V04qin57U50dMT1XLaNp1i5MXSsfVptGcfxSau4zgIOv9F0t7YNxSm
	+Q9fLWYtFsf11KxDE2Vr00nUXh7cX2zYz00uCxAYMwmAdHjPWHndM67VSh7HQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793973843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2POFqhBdX4hWO/hojONQrzEFt0JAY/xmNxctemziCs4=;
	b=J8vrAzlwb8GUXMcIC9A1kycm3NH6aQ31wmBz8kTWJ7dupY3htlibePGzYfFFdcNh7ysUXI
	6knNgHI+oxoC2eBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <20261106140401.90MH_6qt@linutronix.de>
References: <20261105165113.82N-rPMG@linutronix.de>
 <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>

On 2026-11-05 12:03:11 [-0800], Paul E. McKenney wrote:
> > For rcutorture, I don't think there's a ready-made kernel interface,
> > maybe we could add a sched helper that performs the same operation as
> > the debugfs knobs?
> 
> I would very much appreciate that.  ;-)

This maybe? Since it is built-in only, there is no need to restore the
old state, is there?

--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1333,6 +1333,8 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 	return cur_ops->gp_diff(new, old);
 }
 
+void dl_server_fair_disable(unsigned int cpu);
+
 static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
 {
 	int cpu;
@@ -3394,6 +3396,8 @@ static int rcutorture_booster_init(unsigned int cpu)
 
 	/* Don't allow time recalculation while creating a new task. */
 	mutex_lock(&boost_mutex);
+	if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST))
+		dl_server_fair_disable(cpu);
 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
 	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
 					      cpu, "rcu_torture_boost_%u");
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 076a6c2f017bb..45b1251922c4f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1921,6 +1921,31 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	return 0;
 }
 
+#ifdef CONFIG_RCU_TORTURE_TEST
+/*
+ * The RCU-TORTURE built-in test will disable fair-server to avoid any
+ * throttling while testing RCU-boosting.
+ * If compiled as module then the user needs to disable it manually before
+ * loading the module.
+ */
+void dl_server_fair_disable(unsigned int cpu);
+
+void dl_server_fair_disable(unsigned int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	int retval;
+
+	scoped_guard (rq_lock_irqsave, rq) {
+		struct sched_dl_entity *dl_se = &rq->fair_server;
+
+		update_rq_clock(rq);
+		dl_server_stop(dl_se);
+		retval = dl_server_apply_params(dl_se, 0, dl_se->dl_period, 0);
+	}
+	WARN_ON_ONCE(retval);
+}
+#endif
+
 /*
  * Add @dl_se's bw to the root-domain accounting.
  *
-- 
2.55.0

