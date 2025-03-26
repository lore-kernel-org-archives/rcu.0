Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D41BC9E2;
	Wed, 26 Mar 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007447; cv=none; b=AuDpWaLI6CCR85IuDvveHC161nyDhJ3E7YQAJqBRXlHFsyhWuflA8KYfwn5AkyZuZRoHRUPFBtvj7WQkfCzCUE9v+18gtcd66tRrq9fJF6dmbAimD1wlT2graFpVMxCL5pczSj4hreuE0BQpi8hel0MquZkmmiBjfvARIyCJzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007447; c=relaxed/simple;
	bh=HQZ65i0Lgo+n3+UKmg9v453XuPjQ0Vay9kyFB9kQqfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvZnZ6FoSWGzghG2topsBwzCITZAyssFORuaLFZCYOvbkC65hlX3tXzYHuMFSyUn0b9TxDFxdr+zEREotVDotQ4Vx4hJaeaoNJZLQb3uPyPj+CtKzeARw1pqFAX5Dp7GxkAlrjhtwpSCW728btn4BO3qN+MTEUQ+Sl7TjGLymy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROUDlNZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROUDlNZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062F8C4CEE2;
	Wed, 26 Mar 2025 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743007447;
	bh=HQZ65i0Lgo+n3+UKmg9v453XuPjQ0Vay9kyFB9kQqfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROUDlNZAp/lWr9mOxkTzKDEy1jGU3LUIjB5SHCCX3+dD0Y5xLduUcYEop47eop9Ov
	 qRB+U2XW6iyiAEnEXkHzSuzkIvonXhlX/hFM4ocASQBrFPv1Dm76ZBL0XV1MfCGJPZ
	 0PD1dv9Q490go/hClBnTiwaFkPdmsLzK4DlCGnOFnBkbAj5PFrdeAaLlPxZlffWXZP
	 8ckh4McAvKq2hOI0jSFwaLiPvbessOfnFwyjnS89ACQpZxkeWlVyqiQ9iNPDxjO2Nw
	 WcPO1YHJqI72+ypgjFdRcZjkx/KIbg/DeTnlT0XtYHW9JQHaGq+N+r414TlSyy2zOf
	 ahUyltx5WOV5g==
Date: Wed, 26 Mar 2025 17:44:02 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Walter Chang =?utf-8?B?KOW8tee2reWTsik=?= <Walter.Chang@mediatek.com>
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"vlad.wing@gmail.com" <vlad.wing@gmail.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	Alex Hoh =?utf-8?B?KOizgOaMr+WdpCk=?= <Alex.Hoh@mediatek.com>,
	Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"neeraj.upadhyay@amd.com" <neeraj.upadhyay@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"leitao@debian.org" <leitao@debian.org>,
	"urezki@gmail.com" <urezki@gmail.com>,
	Freddy Hsin =?utf-8?B?KOi+m+aBkuixkCk=?= <Freddy.Hsin@mediatek.com>,
	"qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	Xinghua Yang =?utf-8?B?KOadqOWFtOWNjik=?= <Xinghua.Yang@mediatek.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH v4] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Message-ID: <Z-Qu0stgvwHF9n3q@localhost.localdomain>
References: <20250117232433.24027-1-frederic@kernel.org>
 <a7cb64fb-1c17-4316-abf8-e6a7e07ba4d1@paulmck-laptop>
 <ef6cf6aaf981aa2035828e55bd66d56b88e70667.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef6cf6aaf981aa2035828e55bd66d56b88e70667.camel@mediatek.com>

Hi Walter Chang,

Le Wed, Mar 26, 2025 at 05:46:38AM +0000, Walter Chang (張維哲) a écrit :
> On Tue, 2025-01-21 at 09:08 -0800, Paul E. McKenney wrote:
> > On Sat, Jan 18, 2025 at 12:24:33AM +0100, Frederic Weisbecker wrote:
> > > hrtimers are migrated away from the dying CPU to any online target
> > > at
> > > the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth
> > > timers
> > > handling tasks involved in the CPU hotplug forward progress.
> > > 
> > > However wake ups can still be performed by the outgoing CPU after
> > > CPUHP_AP_HRTIMERS_DYING. Those can result again in bandwidth timers
> > > being armed. Depending on several considerations (crystal ball
> > > power management based election, earliest timer already enqueued,
> > > timer
> > > migration enabled or not), the target may eventually be the current
> > > CPU even if offline. If that happens, the timer is eventually
> > > ignored.
> > > 
> > > The most notable example is RCU which had to deal with each and
> > > every of
> > > those wake-ups by deferring them to an online CPU, along with
> > > related
> > > workarounds:
> > > 
> > > _ e787644caf76 (rcu: Defer RCU kthreads wakeup when CPU is dying)
> > > _ 9139f93209d1 (rcu/nocb: Fix RT throttling hrtimer armed from
> > > offline CPU)
> > > _ f7345ccc62a4 (rcu/nocb: Fix rcuog wake-up from offline softirq)
> > > 
> > > The problem isn't confined to RCU though as the stop machine
> > > kthread
> > > (which runs CPUHP_AP_HRTIMERS_DYING) reports its completion at the
> > > end
> > > of its work through cpu_stop_signal_done() and performs a wake up
> > > that
> > > eventually arms the deadline server timer:
> > > 
> > >            WARNING: CPU: 94 PID: 588 at kernel/time/hrtimer.c:1086
> > > hrtimer_start_range_ns+0x289/0x2d0
> > >            CPU: 94 UID: 0 PID: 588 Comm: migration/94 Not tainted
> > >            Stopper: multi_cpu_stop+0x0/0x120 <-
> > > stop_machine_cpuslocked+0x66/0xc0
> > >            RIP: 0010:hrtimer_start_range_ns+0x289/0x2d0
> > >            Call Trace:
> > >             <TASK>
> > >             ? hrtimer_start_range_ns
> > >             start_dl_timer
> > >             enqueue_dl_entity
> > >             dl_server_start
> > >             enqueue_task_fair
> > >             enqueue_task
> > >             ttwu_do_activate
> > >             try_to_wake_up
> > >             complete
> > >             cpu_stopper_thread
> > >             smpboot_thread_fn
> > >             kthread
> > >             ret_from_fork
> > >             ret_from_fork_asm
> > >             </TASK>
> > > 
> > > Instead of providing yet another bandaid to work around the
> > > situation,
> > > fix it from hrtimers infrastructure instead: always migrate away a
> > > timer to an online target whenever it is enqueued from an offline
> > > CPU.
> > > 
> > > This will also allow to revert all the above RCU disgraceful hacks.
> > > 
> > > Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
> > > Reported-by: Usama Arif <usamaarif642@gmail.com>
> > > Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from
> > > outgoing CPU earlier")
> > > Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > This passes over-holiday testing rcutorture, so, perhaps redundantly:
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Hi,
> 
> I encountered the same issue even after applying this patch.
> Below are the details of the warning and call trace.
> 
> 
> migration/3: ------------[ cut here ]------------
> migration/3: WARNING: CPU: 3 PID: 42 at kernel/time/hrtimer.c:1125
> enqueue_hrtimer+0x7c/0xec
> migration/3: CPU: 3 UID: 0 PID: 42 Comm: migration/3 Tainted: G       
> OE      6.12.18-android16-0-g59cb5a849beb-4k #1
> 0b440e43fa7b24aaa3b7e6e5d2b938948e0cacdb
> migration/3: Stopper: multi_cpu_stop+0x0/0x184 <-
> stop_machine_cpuslocked+0xc0/0x15c

It's not the first time I get such a report on an out of tree
kernel. The problem is I don't know if the tainted modules are
involved. But something is probably making an offline CPU visible within
the hierarchy on get_nohz_timer_target(). And that new warning made
that visible.

Can you try this and tell us if the warning fires?

Thanks.

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 6d67e9a5af6b..f49512628269 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -9,6 +9,7 @@
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
+extern void assert_domain_online(void);
 #else
 static inline void nohz_balance_enter_idle(int cpu) { }
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 07455d25329c..98c8f8408403 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -13,6 +13,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/sched/task.h>
 #include <linux/sched/smt.h>
+#include <linux/sched/nohz.h>
 #include <linux/unistd.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
@@ -1277,6 +1278,7 @@ static int take_cpu_down(void *_param)
 	if (err < 0)
 		return err;
 
+	assert_domain_online();
 	/*
 	 * Must be called from CPUHP_TEARDOWN_CPU, which means, as we are going
 	 * down, that the current state is CPUHP_TEARDOWN_CPU - 1.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 175a5a7ac107..88157b1645cc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1163,6 +1163,20 @@ void resched_cpu(int cpu)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_NO_HZ_COMMON
+void assert_domain_online(void)
+{
+	int cpu = smp_processor_id();
+	int i;
+	struct sched_domain *sd;
+
+	guard(rcu)();
+
+	for_each_domain(cpu, sd) {
+		for_each_cpu(i, sched_domain_span(sd)) {
+			WARN_ON_ONCE(cpu_is_offline(i));
+		}
+	}
+}
 /*
  * In the semi idle case, use the nearest busy CPU for migrating timers
  * from an idle CPU.  This is good for power-savings.
