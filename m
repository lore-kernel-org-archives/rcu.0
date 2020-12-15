Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6EAC2BB48
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AD522D02
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 00:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgLPABg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgLOXuM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 18:50:12 -0500
Date:   Wed, 16 Dec 2020 00:49:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608076171;
        bh=wvzAVXUEKU1RaXHyuE2ZtZzPjw0j5EezKmXnsJl3dA4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr4NM4qdwgO+KZNHGpkavVp2Z3yvNO8IS0aivpIB9yjjizavOJ7DUTCOOsq6+d1Ia
         gxIKs0sgyg4U1NdVLMsRw8upVlXJMjHukndrgFkK3NdSNUEtjrX5PJr0B0hN5jVPWd
         +fSFGnb+7Nkj6NE9G+E6/V5zEOTtnm1uEC33fY+rs84uFHBiEbbPoEvckqo51+TcwS
         EYVfhx3VRp/K/AGmIw0HCZ/7WpOLf0JWnavc05oCPA110lhWNtLlo+Z9N+n+QkHru/
         Ol3a6cYgZJXTvSSodls200f4qYHyjC7MhpxgNK4DZZI7SXarXHdcfJfmDieGB472z6
         8j2rJ2t08fYgA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 17/19] cpu/hotplug: Add lockdep_is_cpus_held()
Message-ID: <20201215234927.GA98790@lothringen>
References: <20201113121334.166723-1-frederic@kernel.org>
 <20201113121334.166723-18-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113121334.166723-18-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 13, 2020 at 01:13:32PM +0100, Frederic Weisbecker wrote:
> RCU needs to check if the cpu hotplug lock is held, in the middle of
> other conditions to check the sanity of RCU-nocb. Provide a helper for
> that.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>  include/linux/cpu.h | 1 +
>  kernel/cpu.c        | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index d6428aaf67e7..27eb3875e45a 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -118,6 +118,7 @@ extern void cpus_read_lock(void);
>  extern void cpus_read_unlock(void);
>  extern int  cpus_read_trylock(void);
>  extern void lockdep_assert_cpus_held(void);
> +extern int lockdep_is_cpus_held(void);
>  extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..3cca5b27de25 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -330,6 +330,13 @@ void lockdep_assert_cpus_held(void)
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
>  
> +#ifdef CONFIG_LOCKDEP
> +int lockdep_is_cpus_held(void)
> +{
> +	return percpu_rwsem_is_held(&cpu_hotplug_lock);
> +}
> +#endif
> +
>  static void lockdep_acquire_cpus_lock(void)
>  {
>  	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);

This patch may trigger a build error with !CONFIG_HOTPLUG.

Here is a fixed version:

---
From 80609608b29758e43e8d8d6beaca486b8c42bb43 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 11 Nov 2020 23:53:13 +0100
Subject: [PATCH] cpu/hotplug: Add lockdep_is_cpus_held()

RCU needs to check if the cpu hotplug lock is held, in the middle of
other conditions to check the sanity of RCU-nocb. Provide a helper for
that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/cpu.h | 2 ++
 kernel/cpu.c        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d6428aaf67e7..3aaa0687e8df 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -111,6 +111,8 @@ static inline void cpu_maps_update_done(void)
 #endif /* CONFIG_SMP */
 extern struct bus_type cpu_subsys;
 
+extern int lockdep_is_cpus_held(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpus_write_lock(void);
 extern void cpus_write_unlock(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..3cca5b27de25 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -330,6 +330,13 @@ void lockdep_assert_cpus_held(void)
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
 
+#ifdef CONFIG_LOCKDEP
+int lockdep_is_cpus_held(void)
+{
+	return percpu_rwsem_is_held(&cpu_hotplug_lock);
+}
+#endif
+
 static void lockdep_acquire_cpus_lock(void)
 {
 	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
-- 
2.25.1

