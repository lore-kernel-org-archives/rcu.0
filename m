Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A70C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B00206FB
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617289;
	bh=70+j/DeqmVUbBtwCo2NhwIvYr9M+1GQTVl7aG5v8g+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTVnldKej3suiUxudDM+9XE9F6UZ3w6FqWwKwc0v/mNDrgEweR4uLTMwuU/7FDrmp
	 Zyw0AlVIQba2BxrRgSiU7nVYGeClXkRGIVT7BketMt9yPaG9z47SI++uPzft/ZGvxW
	 CiyJm0ccd3hq/dxzZWM2WCIA7ZKDtTonySCFVP2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgKEXB2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbgKEXB2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:01:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FDB9206CB;
        Thu,  5 Nov 2020 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617287;
        bh=70+j/DeqmVUbBtwCo2NhwIvYr9M+1GQTVl7aG5v8g+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xejj63gASGMZ2ZRrI8mi1Z90WTWdnzuRHBMPjG3HZavJAshRsp5QQborvcox2GYZ2
         XO237++t1t5ubz/shImxax+YAkElbii6cmeavRutmi5kdzU23Wo9tCKhgrxMOuDhWr
         bXgAGM/KcYFqG6Qi0sInkow+OAwyYwU5Eg4hZoYQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH tip/core/rcu 1/2] x86/cpu: Avoid cpuinfo-induced IPI pileups
Date:   Thu,  5 Nov 2020 15:01:22 -0800
Message-Id: <20201105230123.18308-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230040.GA18202@paulmck-ThinkPad-P72>
References: <20201105230040.GA18202@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The aperfmperf_snapshot_cpu() function is invoked upon access to
/proc/cpuinfo, and it does do an early exit if the specified CPU has
recently done a snapshot.  Unfortunately, the indication that a snapshot
has been completed is set in an IPI handler, and the execution of this
handler can be delayed by any number of unfortunate events.  This means
that a system that starts a number of applications, each of which
parses /proc/cpuinfo, can suffer from an smp_call_function_single()
storm, especially given that each access to /proc/cpuinfo invokes
smp_call_function_single() for all CPUs.  Please note that this is not
theoretical speculation.  Note also that one CPU's pending IPI serves
all requests, so there is no point in ever having more than one IPI
pending to a given CPU.

This commit therefore suppresses duplicate IPIs to a given CPU via a
new ->scfpending field in the aperfmperf_sample structure.  This field
is set to the value one if an IPI is pending to the corresponding CPU
and to zero otherwise.

The aperfmperf_snapshot_cpu() function uses atomic_xchg() to set this
field to the value one and sample the old value.  If this function's
"wait" parameter is zero, smp_call_function_single() is called only if
the old value of the ->scfpending field was zero.  The IPI handler uses
atomic_set_release() to set this new field to zero just before returning,
so that the prior stores into the aperfmperf_sample structure are seen
by future requests that get to the atomic_xchg().  Future requests that
pass the elapsed-time check are ordered by the fact that on x86 loads act
as acquire loads, just as was the case prior to this change.  The return
value is based off of the age of the prior snapshot, just as before.

Reported-by: Dave Jones <davej@codemonkey.org.uk>
[ paulmck: Allow /proc/cpuinfo to take advantage of arch_freq_get_on_cpu(). ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/cpu/aperfmperf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e2f319d..37ff7f4 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -19,6 +19,7 @@
 
 struct aperfmperf_sample {
 	unsigned int	khz;
+	atomic_t	scfpending;
 	ktime_t	time;
 	u64	aperf;
 	u64	mperf;
@@ -62,17 +63,20 @@ static void aperfmperf_snapshot_khz(void *dummy)
 	s->aperf = aperf;
 	s->mperf = mperf;
 	s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
+	atomic_set_release(&s->scfpending, 0);
 }
 
 static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 {
 	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
+	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
 
 	/* Don't bother re-computing within the cache threshold time. */
 	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return true;
 
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
+	if (!atomic_xchg(&s->scfpending, 1) || wait)
+		smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
 
 	/* Return false if the previous iteration was too long ago. */
 	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
@@ -118,6 +122,8 @@ void arch_freq_prepare_all(void)
 
 unsigned int arch_freq_get_on_cpu(int cpu)
 {
+	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
+
 	if (!cpu_khz)
 		return 0;
 
@@ -131,6 +137,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 		return per_cpu(samples.khz, cpu);
 
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
+	atomic_set(&s->scfpending, 1);
+	smp_mb();
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
 
 	return per_cpu(samples.khz, cpu);
-- 
2.9.5

