Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426998;
	b=DQK40fKAGpBZk7ZPXLd2LfBCzTC3ZTdVqo9e4TPvRLmMDMCsa9EKXS0M5JlCo+G8gN+9
	 2xBTw4qRCmvueU2Pe7B1CbFUSiYhnQNTtvekXYc02b1mf36+lbh2HKALwYVmw7m/40yMV
	 AQTcXNLlQk9SpFiWPie5E1tUFEWnTUSfJ/jR/bgadWphHuqmkAmXMFuGc8wpm605I1OF/
	 qZ8tiT2K9PWsWf9R2aAWjiOoQEmNEJk3luJlDccg5P9MFv5C39IUuMqjp8AHLM74XRFmV
	 iAeCFPJ7Ntc19P+Hp1ToNALEkMiJ9P47WPHuYVSwNrT8PTR8+sfIdQEQiF8RH+SdW7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426998;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b57YxGMtPJSMp9oBEsWPgCkyOnL1xJOiwmMuFnnXqGo=;
	b=XPpqn9lTVthdxC16EgzcXtFKfDxryJIzUBQ8glMP91FT8jfCsE/LM/uyzQbtcJdYjfeA
	 5fY9rYYKKM+GMoBd0O0HXA/AddheK8PwBHocN4aOC3upsodbCkMxAEFQHMizFY7q6cUfh
	 QztUV/BTae/SnPVD03bBCKFyRxTiebwFRt1BzEtV8N+2Xj4qSxCMEt0p60KRZgRP2trQL
	 01VIWYj/3mnP5tw4TuGE0aCNQe2kfspfNr1LnQrwOz3tQOkl63EcKVrWyXN5cL/a59uvT
	 r+u1fZedoBY0tewf6wikGpka+QMFMuxHkKtkBKXv656VCa4f3vRMcAcQJxIgqoL7uGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=I8r3u7mR;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=oFVfo+02;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53348606A31A;
	Mon, 19 Oct 2026 16:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53348606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=I8r3u7mR;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=oFVfo+02
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792426973; bh=b57YxGMtPJSMp9oBEsWPgCk
	yOnL1xJOiwmMuFnnXqGo=; b=I8r3u7mR3b2GIUi1GcCsV0LfyCYsK6EIBckle5D85T/ECUuLT4
	2KjORH8IBGS5YyOdImUuv8/azNHoYNPNGIrKjRyHC08+3E0P7I9oTTfPUPnB19vJ0t1wJBKkxvP
	hgiiHM2xtN09L5w2RZn5lY5HwKe3EU4dGyTMdBWW/TH0AIKPaXQ346QNo8VWz9xSh7G6wU8xiot
	ln3MRj2H62I279AzL0FWSteeqvSEd6hkxLL0zRnOQPQfNonoh8JJENzw3ZRi5m49QagcwsTzHBO
	xZLOrVO8Tf21/XdXS6fxn6P66Tsnt88akdZac34Xgxbz5jU3fYHQeV2ADvO62gxJzyQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792426973; bh=b57YxGMtPJSMp9oBEsWPgCk
	yOnL1xJOiwmMuFnnXqGo=; b=oFVfo+02lVqwHe0RjQrQ4XxPPT1Zg5QTeJJ3BW+EIeOEt1rPiU
	LSXCkWmBr0rBxpu/N2BuBKjw9jPoRkCy7JBA==;
Date: Mon, 19 Oct 2026 17:22:54 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Andrea Parri <parri.andrea@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
CC: Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_-rcu/dev=5D_hazptrtorture=3A_Releas?=
 =?US-ASCII?Q?e_all_deferred_hazard_pointers_before_stopping?=
In-Reply-To: <20261019162005.12888-1-parri.andrea@gmail.com>
References: <20261019162005.12888-1-parri.andrea@gmail.com>
Message-ID: <AFA8DFD1-7D1C-49FD-BE53-95747FE4302C@mainlining.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 October 2026 17:20:03 BST, Andrea Parri <parri.andrea@gmail.com>
wrote:
>hazptrtorture can hang at shutdown when deferral is enabled, as in the
>PREEMPT scenario: the writer stays in ->sync() and kthread_stop() on it
>never returns, until kvm.sh kills QEMU:
>
>    [ 1800.899278] hazptr-torture: Stopping hazptr_torture_do_pending task
>    [ 1800.899447] hazptr-torture: Stopping hazptr_torture_writer task
>    [ 1812.713870] hazptr-torture: rtc: 00000000225df70a ver: 12436 HTWS_SYNC tfle: 0 rta: 12437 rtaf: 0 rtf: 12427 onoff: 48783/48783:48786/48786 3,254:3,280 611671:731494 (HZ=1000) acq: 5720353149 rel: 5720210186 acqirq: 571927 relirq: 714778 reldefer: 714139 relundefer 714114
>    [ 1812.713971] hazptr-torture: hazptr_torture_stats is stopping
>
>    Summary: Potential hang (QEMU killed)
>    !!! PID 1393523 hung at 1980 vs. 1800 seconds
>
>hazptr_torture_cleanup() stops the do_pending kthread before the writer
>and the readers.  Once torture_must_stop(), do_pending makes one last
>pass and leaves its loop, but unless stutter_will_wait(), that pass
>releases the deferred hazard pointers of a single CPU.
>
>Readers can also still defer after that pass, from the iteration they
>are in when torture_must_stop() becomes true.  Stopped readers hold no
>hazard pointer, so the writer waits on one of the 25 deferred hazard
>pointers above (reldefer - relundefer) that nothing releases.
>
>Keep do_pending running until hazptr_torture_cleanup() stops it, after
>the writer and the readers, releasing the deferred hazard pointers of
>all CPUs on each pass once torture_must_stop() and once more on exit.
>It now also sleeps between those passes, and kthread_stop() wakes it.
>
>This should be safe because readers defer only from their own loop,
>which they have left once torture_stop_kthread() returns for them, and
>the hazptr_torture_acquire() IPI runs synchronously within that loop.
>
>With this change, a 30-minute PREEMPT run on x86_64 with 8 CPUs ends
>with "End of test: SUCCESS" and with as many hazard pointers released
>from the pending lists as were deferred (reldefer: 960658 relundefer
>960658).
>
>Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
>Assisted-by: LLM

Why not put this into a series?

>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>---
> kernel/rcu/hazptrtorture.c | 24 ++++++++++++++++++------
> 1 file changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
>index 7c8b5899fb011..5153720074644 100644
>--- a/kernel/rcu/hazptrtorture.c
>+++ b/kernel/rcu/hazptrtorture.c
>@@ -547,18 +547,25 @@ static int hazptr_torture_do_pending(void *arg)
> 	DEFINE_TORTURE_RANDOM(rand);
> 
> 	VERBOSE_TOROUT_STRING("hazptr_torture_do_pending task started");
>-	do {
>-		if (stutter_will_wait()) {
>+	/*
>+	 * Run until hazptr_torture_cleanup() stops this kthread, not just
>+	 * until torture_must_stop(): the writer can be waiting in ->sync()
>+	 * for a deferred hazard pointer while it is being stopped.
>+	 */

Could this be shorter?

>+	while (!kthread_should_stop()) {
>+		if (torture_must_stop() || stutter_will_wait()) {
> 			for_each_possible_cpu(cpu)
> 				hazptr_torture_do_one_pending(cpu, &rand);
> 		} else {
> 			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
> 			hazptr_torture_do_one_pending(cpu, &rand);
> 		}
>-		if (!torture_must_stop())
>-			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
>+		torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
> 		// Omit stutter_wait() because this function needs to do cleanup.
>-	} while (!torture_must_stop());
>+	}
>+	/* The readers have stopped, so nothing new can be deferred. */
>+	for_each_possible_cpu(cpu)

Is the comment needed? I don't know if it's nessesary.

>+		hazptr_torture_do_one_pending(cpu, &rand);
> 	torture_kthread_stopping("hazptr_torture_do_pending");
> 	return 0;
> }
>@@ -773,7 +780,6 @@ hazptr_torture_cleanup(void)
> 		return;
> 	}
> 
>-	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
> 	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
> 	torture_stop_kthread(hazptr_torture_writer, writer_task);
> 
>@@ -785,6 +791,12 @@ hazptr_torture_cleanup(void)
> 		reader_tasks = NULL;
> 	}
> 
>+	/*
>+	 * Stop do_pending only after the writer and the readers: the writer
>+	 * may be waiting on hazard pointers that readers deferred.
>+	 */

May we shorten this? Feel free to bikeshed that one.

>+	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
>+
> 	torture_stop_kthread(hazptr_torture_stats, stats_task);
> 
> 	/* Do torture-type-specific cleanup operations.  */
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
