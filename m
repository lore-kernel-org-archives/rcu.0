Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426816;
	b=YUQdygnY1FU53yXSVt8c0bpWkAX7FsD05K1l1aCO0bQUCsa5D/CEfK9zvlkNyD0Kui3f
	 zfdEaq305aGs7izXqap1SXr8NF7a6a72EpvWPNk9F8LiHIR0WMBGbVi2zICS9GicaKp/5
	 /FKtybbwGPM1a2x6q5hkUBpWGwtRtFq/b6IKR38m+qeifFC6ACVb8WPooK5lU/XLD0t+u
	 5qC7HGaKJIa/C9CmLluy3xMExvbNEsmBvoXjATO1T3KXQK9sa+AfWLzBFOyXunYd4N9pT
	 qWfoxrKOkBhvjm2/poWccS8TPptCOXlJm/Emr6CvSjZsrValjd4DJMQlRONmRBgVy3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wMCaBZ3cPYlo3WgUgRBvzFpHfELTk+gUNHqJ34/c1Vk=;
	b=TeVFfabaArpQ0jT7G1G5xBAFPlnV2KaUxMGDhlSpdfH9rk7iqFcR9eRWU2uRHBdZ9uXc
	 ZEZ29it3/cjxU1vddS1/h33vsun0N31uDuhCihZ8KTvdFNsOJZl1jevX5jqSbAlSwj5in
	 okIdsshiNlMAJGvra+ULUMY+40L+b+zLjIO1Ahbzzs6jhsAplke1LI64LrPk2R4ka89TA
	 ETMgNsbL2LOxGV+xfEjAIIwqFJQZ1Hu0qV5CXLV+CWoSbKHUzXgXk0B0oR6/n7zo1Nysy
	 ejVCSHJrq5WEe2XWnNX1Y8BpFOaS16sFATQfFNNrWfu3YwUnKrFirPP1DbKNFfUEA8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kBhIyW3T;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB7606A319
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 16:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFB7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kBhIyW3T
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1875623f8f.3
        for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792426815; x=1793031615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wMCaBZ3cPYlo3WgUgRBvzFpHfELTk+gUNHqJ34/c1Vk=;
        b=kBhIyW3TiN0ufg80lIEwriNI8BTYAVYkZeiHdeXGtvzPKYLqGuhXZounou1/JGRAFr
         AbBTU1hsWNGW/w+PDZda+gCxvY7g9SSfox/ScCidEZ2Lf4WfW4m2zvsIOgDQHDT3v+8Q
         /PZscyY0xC9mWd35+C4B6ZiJXjjWDsz0gYbwbhsW0bMk4IAvUgzgQzZFnyMOmACEqVuu
         DMAq67Ram89P9e+ja6jK/Rx5Odo4jEFnOBKPTsFQv5k3kVxRlSuvQB1ogUCSQAjhboSv
         IGykHsrfE+uFlE5ruIts2KUcM+wkdD09vsripNS/1fbFuA+tYY3sGYgKynnTgu3bnOQL
         zr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426815; x=1793031615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMCaBZ3cPYlo3WgUgRBvzFpHfELTk+gUNHqJ34/c1Vk=;
        b=tKe19dGk8g4yBWi79Dh1HIFBPo6inPoQDYzxjnzdq3g+I1MOJJE7gjmv4ORfcjOdFT
         Gzqxour5m9J99e5MscnsG9rSqO6VGuc4qpSOWssqkf4pw6rA4LVQQzB9IaWeWUy00Ty0
         j0skq4BpzbQEKl8qiQIXkqRaDWRXgQUUvWtsDsTLSfo31NdCuHjJjtJM/t5iMpXssgZQ
         WY5EKd213t1NAfaJWJRensNB/5DikN88rHPHRHcVM7ve/zqLne4CAeIxROcXxju1Ts9F
         jUeFaj65AuIQsQq6ITKqejJeLQbzCGtvwL1kBnlxN+CzHlZHAa/s+v7DL8WiAegGPTAC
         FE4Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6ZMqAciW71F/GXwmKmedB1onln7u8ol5eqZcZNI81/k1slRTr2nsNSjIqxy5yhxZlqyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqzkUDh3kUOun30bLazUYqX+vUv8Hi674RHooUfp1oqV2KnKYk
	8RQa133RCrL98eVUqUkSHkRjWuawt8TCW4wuLLOH3SDWNe/da2PKtXn2
X-Gm-Gg: AYBFou0lQRS/ojFXPYolQm6MyytVQgNwULbR9O287jBLcmYBjVCfHZn4sncEakEVBnq
	2ca+vc3kFNQya7FH52OEhD+bEswP3PHKpknzIaW/livzXa7BeyE3zzmucULm0S2IDihNqishztU
	ohOYsMw5gjPLmKJIceh+HKYATkzlUmtmhfBinsQxUzRL+nnddFJ9KcW47hKIj8KW4csLfz9SgpV
	zeLmrPHk2oMj2FVXHhkW3q2EfsmOvUHNKbrPqGrS4t7rX2NOCcYjuK7DDdYxsxwkI5El2kHZCrF
	y/29iP9bsHADrh85tf/9gC1HooR4h8iqSuG3t8mk5hGi+DyHeHxMAAGolu5hKtn0DdAZNW81PiG
	7do/MZDYRMtO6Cef0rZwQ5QPy2tjdMFyJ9cm4iobcyhntEHungqItFi2v+DSyRgaKTwLsy2ePqo
	efFay5tdHC74B1jkM4wHDUlzQzsLuc4fE4rN6Dd2Tud6ShiOBKajmCaqNPWjS7U1uEgOKuogG9f
	hwSxUTwplg0k8QPst3OrfNrTi5ltJ71Bg2YRjXhKpM=
X-Received: by 2002:a05:6000:41c7:b0:48d:f50b:2af8 with SMTP id ffacd0b85a97d-48e07fad0dfmr16383672f8f.46.1792426814532;
        Mon, 19 Oct 2026 09:20:14 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ec8dfsm25165890f8f.26.2026.10.19.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:20:14 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC -rcu/dev] hazptrtorture: Release all deferred hazard pointers before stopping
Date: Mon, 19 Oct 2026 18:20:03 +0200
Message-ID: <20261019162005.12888-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
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

hazptrtorture can hang at shutdown when deferral is enabled, as in the
PREEMPT scenario: the writer stays in ->sync() and kthread_stop() on it
never returns, until kvm.sh kills QEMU:

    [ 1800.899278] hazptr-torture: Stopping hazptr_torture_do_pending task
    [ 1800.899447] hazptr-torture: Stopping hazptr_torture_writer task
    [ 1812.713870] hazptr-torture: rtc: 00000000225df70a ver: 12436 HTWS_SYNC tfle: 0 rta: 12437 rtaf: 0 rtf: 12427 onoff: 48783/48783:48786/48786 3,254:3,280 611671:731494 (HZ=1000) acq: 5720353149 rel: 5720210186 acqirq: 571927 relirq: 714778 reldefer: 714139 relundefer 714114
    [ 1812.713971] hazptr-torture: hazptr_torture_stats is stopping

    Summary: Potential hang (QEMU killed)
    !!! PID 1393523 hung at 1980 vs. 1800 seconds

hazptr_torture_cleanup() stops the do_pending kthread before the writer
and the readers.  Once torture_must_stop(), do_pending makes one last
pass and leaves its loop, but unless stutter_will_wait(), that pass
releases the deferred hazard pointers of a single CPU.

Readers can also still defer after that pass, from the iteration they
are in when torture_must_stop() becomes true.  Stopped readers hold no
hazard pointer, so the writer waits on one of the 25 deferred hazard
pointers above (reldefer - relundefer) that nothing releases.

Keep do_pending running until hazptr_torture_cleanup() stops it, after
the writer and the readers, releasing the deferred hazard pointers of
all CPUs on each pass once torture_must_stop() and once more on exit.
It now also sleeps between those passes, and kthread_stop() wakes it.

This should be safe because readers defer only from their own loop,
which they have left once torture_stop_kthread() returns for them, and
the hazptr_torture_acquire() IPI runs synchronously within that loop.

With this change, a 30-minute PREEMPT run on x86_64 with 8 CPUs ends
with "End of test: SUCCESS" and with as many hazard pointers released
from the pending lists as were deferred (reldefer: 960658 relundefer
960658).

Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 kernel/rcu/hazptrtorture.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 7c8b5899fb011..5153720074644 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -547,18 +547,25 @@ static int hazptr_torture_do_pending(void *arg)
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("hazptr_torture_do_pending task started");
-	do {
-		if (stutter_will_wait()) {
+	/*
+	 * Run until hazptr_torture_cleanup() stops this kthread, not just
+	 * until torture_must_stop(): the writer can be waiting in ->sync()
+	 * for a deferred hazard pointer while it is being stopped.
+	 */
+	while (!kthread_should_stop()) {
+		if (torture_must_stop() || stutter_will_wait()) {
 			for_each_possible_cpu(cpu)
 				hazptr_torture_do_one_pending(cpu, &rand);
 		} else {
 			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
 			hazptr_torture_do_one_pending(cpu, &rand);
 		}
-		if (!torture_must_stop())
-			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
+		torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
 		// Omit stutter_wait() because this function needs to do cleanup.
-	} while (!torture_must_stop());
+	}
+	/* The readers have stopped, so nothing new can be deferred. */
+	for_each_possible_cpu(cpu)
+		hazptr_torture_do_one_pending(cpu, &rand);
 	torture_kthread_stopping("hazptr_torture_do_pending");
 	return 0;
 }
@@ -773,7 +780,6 @@ hazptr_torture_cleanup(void)
 		return;
 	}
 
-	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
 	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
 	torture_stop_kthread(hazptr_torture_writer, writer_task);
 
@@ -785,6 +791,12 @@ hazptr_torture_cleanup(void)
 		reader_tasks = NULL;
 	}
 
+	/*
+	 * Stop do_pending only after the writer and the readers: the writer
+	 * may be waiting on hazard pointers that readers deferred.
+	 */
+	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
+
 	torture_stop_kthread(hazptr_torture_stats, stats_task);
 
 	/* Do torture-type-specific cleanup operations.  */

-- 
2.53.0

