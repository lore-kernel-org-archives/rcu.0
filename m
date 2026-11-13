Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531493;
	b=rKkzXTURwqE3W8IZKpFuzx3+GN4hU3IBzyXLH9Lt2SixXUgjwJ90fD5n+9XQWg8CIHbZ
	 tWhFpygceKjmxFFz3r9YBwUHn8Qvl/hVyXk4/BOyjXrmn7IpzFbTtcdNRiiCj2OjUfv7O
	 3eObjVkksE7fIZxY/e3pEqogxx8pN/+HNynIFG0lnVq7xA6SXq6sgKML3BayB5hWRYtQj
	 ImAsFOdQ9mH6WOBanPnb6uJouLcjIkyb9GGVGYv9GP0AYLMIg39aKCxbZs+Y2fhKoXWQS
	 tCboeFY9pRmN5W8PDizYlL9PxrFw80Eal74UKCBhTeDsSREZRYP+q0/8aDGMreqYpYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hk2TBm97oswj+7aAWPXZHJA3Ys2LR67SyNxGqC9TLgc=;
	b=GdUyVDsXi3HF7A5EVJYC1PS9nTcvob/HBSSF50PMZu1ttzKh9dMXLRE+w6SL7Hzsj9NT
	 7739VVgpW+RC1nx8f44+fo88Hrm79sm6AF0+1N+ebO6tVWId7ngYzdCu+dIJ5utZBSB8I
	 MGOwpIv03dQvRWTsqIZOwo9nu9C2pmZ6QDFbuch0xf5H+aqC8ZXvntWV/VL+2bVDVS/FA
	 iVmJ0wUKOqGepxKCGSoGhSENoBd3XGHH0/VyBixJT37sXMF03FHas4WUy5U2FQF7QHTqU
	 6XzHGvoupnQbhbAZocOOUOjWMxtjji/p5vK6UbjXstBv2xWaNzYtSCSFJ+9wFDa5d7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkA1ZSNq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E251B60A3832;
	Fri, 13 Nov 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkA1ZSNq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2A0D11F000C5;
	Fri, 13 Nov 2026 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531492;
	bh=hk2TBm97oswj+7aAWPXZHJA3Ys2LR67SyNxGqC9TLgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EkA1ZSNqQdaHvzeAeFBqAdE0mUJfQ8FV1vgMY4cknArSbq/lcYgF63jU/fj5UEDBv
	 XPT7SBgRTLvJ/P5azBEqGvPxNnTb4u8dS7xK2R3sCMK8bC9eGCXpRPuMOcHp0zF/ob
	 MuAcheOT4jXkZqoxilnjMrT6TaD3rl1w3ETyAO+Tojd8aA2dYpZw+igzmkqYyaWs9t
	 H6WVkMIoqdlHhgClLqR5jD0SdG7DCKkixFFDFgoo8sfgvuh8CfrJGY2fRKTHKiw1uC
	 1VUf/tlIfO57s0BCeGPypAH3pVzvDPY8LKwz1KweV7HC1rTBZgQmE5d0eBAUrIRXjO
	 CFqScrZK4LeTw==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 11/14] scftorture: Protect the initial affinity check from hotplug
Date: Thu, 12 Nov 2026 19:57:38 -0500
Message-ID: <20261113005747.2977123-12-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
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

An invoker binds to its target CPU, sleeps for the holdoff interval, and
then warns if it is running elsewhere. CPU hotplug can offline the target
during that sleep and legitimately move the invoker. A built-in test with
matching worker and hotplug holdoffs reproduces this warning.

Check the initial binding while holding cpus_read_lock(), before sleeping.
If the target is already offline, let the existing offline/rebind path
handle it instead of warning about an impossible initial binding. Release
the read lock before the holdoff and test loop so hotplug remains tested.

Signed-off-by: Joel Fernandes <jfern@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index ff9a8271a464..64ee2c5cf51c 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -479,19 +479,24 @@ static int scftorture_invoker(void *arg)
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: task started", scfp->cpu);
 	cpu = scfp->cpu % nr_cpu_ids;
-	WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(cpu)));
+	cpus_read_lock();
+	if (cpu_online(cpu)) {
+		WARN_ON_ONCE(set_cpus_allowed_ptr(current, cpumask_of(cpu)));
+		/* Check affinity before hotplug can move this task away. */
+		curcpu = raw_smp_processor_id();
+		WARN_ONCE(curcpu != cpu,
+			  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
+			  __func__, scfp->cpu, curcpu, nr_cpu_ids);
+	} else {
+		was_offline = true;
+	}
+	cpus_read_unlock();
 	set_user_nice(current, MAX_NICE);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, raw_smp_processor_id());
 
-	// Make sure that the CPU is affinitized appropriately during testing.
-	curcpu = raw_smp_processor_id();
-	WARN_ONCE(curcpu != cpu,
-		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
-		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
-
 	if (atomic_dec_return(&n_started))
 		while (atomic_read_acquire(&n_started)) {
 			if (torture_must_stop()) {
-- 
2.54.0

