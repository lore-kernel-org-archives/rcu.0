Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE774380FC1
	for <rcu@vger.kernel.org>; Tue,  6 Oct 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292668; cv=none; b=rCkw6xQy5sluVo7M0DiS/K3SBYa58H4FojltyK/AH1Lu8jXdz3JvOvK3s58F9W4fWm3xWCeYnih3txPJ1CJ+BBGvafeLKVEMyY12uDAsErUizg1rU5PGwHY2ymncnv9eu/WR11YiQzImS+ZJwghE9gktE3hPLTTzl1xkzz0SWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292668; c=relaxed/simple;
	bh=5MBdw2qFdXU/rSttiuzhfhM4WM65xuOHSkPq1R9UjCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=MU7KSLLRtVatfaR2R6/G55TFaRJSIwEI+79XUr4GRocfaueR43mpA3exxORoYYFUOIF+R4n05VEV8OBB0wp5m0GtJCBYsriDVvWz4hBzR3xL1coLv2ooU4a9V9f8Lkoj5hoO4e0NIvcP0TXZACMYeTb4l/H6FLrQ0Yx1+YM5sH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYyn2PWL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYyn2PWL"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a49623b865so1715787a91.0
        for <rcu@vger.kernel.org>; Tue, 06 Oct 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791292666; x=1791897466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:mail-followup-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwSVzV9/NQkclbEISh7Vv0SoPGQums46C1TZ0hc0x8M=;
        b=oYyn2PWLi2mG/Gxb/Z3PxStp1xK7fKjq75LjD0UtUw0vg/cDMgLyIvQ0/NbAZ+WpsQ
         n+7kS3KzxL35UIB3H0tVGy+pzjW1wj+v7HgUlT/EAZvKdt7bpFrfTREfvObtw90e65/7
         8QD2RXP4/3XDxWpzsO19sP1fFtXP8lq5AW/+H2JKLcNlRYA2Jh97aCMhnttXHVuaYbIH
         6LJsDsCUMhY4bjJChTI3XvjaCmJmqE2lR8F+TEtUyLHKK+D52SzReGySh2r3pniQwWTj
         vsQRpaZyKMf17zYp6IggRZC+qiie+OUX6qUIaO5Dh6jtFiFSZNDr0S5PiOHpNfbVXPpi
         Z33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791292666; x=1791897466;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:mail-followup-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HwSVzV9/NQkclbEISh7Vv0SoPGQums46C1TZ0hc0x8M=;
        b=orY92tFWmHgfQgNU8tzVqQqZsXA7uRPK5AvfLX69VE48tyDYDyyD19EGWU0ZDTRh4V
         Mw1fEyccMDOWHoQSqCn9KR8bLLrNvTYBhi3wo5+AB7gEjEmtghLTm97zd9RIT8BcrRej
         0gFARL96Pdmh+XsnpWU9GO2KvsaBbpsVLPCv4QbHdA/H4hst9sABxkk8z+rpBkcxHbNd
         BOkZTnU/QZoIwXNHmozPmNE28+Z0J8iQSV8Qmay/IXRTafQKTxD+qok0m9lAkO0y1XRY
         2GvlAORR0SeWr/nlKVyr7ESr0IsBXE2JA3eJBk0wa1nzZOuYFc0P1p2cPHMxd6xeOnvE
         FnoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYZYwC6faQNFlK+2nLYeMmE0Ln6HESKyEKcyiIlHmEXp1MooJ7JBFFOfCDZjtFiqeDONc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN7P26tahtHpuY/V3AukOmnxwvI8Jq6tDzf0JEv2nPjxjNEgNS
	vcGA9ESf427f3AhWcoioTgNHnoRaVNnCW3t0R5UAUM0x2Gdt0cT7LImW
X-Gm-Gg: AYBFou12VrcnyGAYGIXhbyiOMMrs/6XDOkWfUhTiM0R31X5akmg1AaLm79pTzXtrLnn
	k8NmcWUsMyezZ0aPkgkLQutPNrvdwz1V2svfHns8n8zke5ZqBzplnqE+rhrBMaSV7joy+ejGzx1
	NW+B5Fh/KQSsR84VQFpmr7tFBJADY3s03yovjo7HlQkYmZzWuWxxGgsWjuVuBtQ3/l/gqPetznK
	tQ7hmQ9qbcplo9UONDLojLK7oYcwg6AuP+So7Fx5cZ0VG1KAJ4dEc2AZ0bt0AN/2nAiS2UwiYJW
	i8PtIrpB2FuF/EyA1XKsvcJsT19fHDbhI9CTHqm8W2+vkCm4MMz/IPTbMIge64yM47Qs7ZYAI91
	kSthrqh0z7ByDNakfQjlO5i/aHrV8DR/y0FdAgjBFRzSNLrGcYnR1h82rpW1kl7Puznoat0PnIs
	UeWNubkJxWb/opVZLtdE1xIn5Bi+6sFHk31K7Zg+q9nbAOZH8ZauAAeBmXCqC8+vfYs2dU0AtbO
	2s7UzdtlQ==
X-Received: by 2002:a17:90b:388b:b0:3a0:903b:f253 with SMTP id 98e67ed59e1d1-3a78717daaemr9010866a91.18.1791292665848;
        Tue, 06 Oct 2026 06:17:45 -0700 (PDT)
Received: from localhost.localdomain ([8.139.245.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853e66d7fsm4892810a91.5.2026.10.06.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:17:45 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu: Enable runtime reset of the RCU stall panic count
Date: Tue,  6 Oct 2026 21:17:37 +0800
Message-ID: <asT08QHOiIJrfIIZ@63b45mr6s164qmn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <A522703D-CBCE-4F3A-9CA2-968BA382166C@nvidia.com>
References: <20261004-rcu-v1-1-3799a44367f1@gmail.com> <00F6D386-FE41-42E3-9B89-07381A49E061@nvidia.com> <asThhHxoFP2L25Nc@63b45mr6s164qmn> <A522703D-CBCE-4F3A-9CA2-968BA382166C@nvidia.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Joel,

Thanks for the quick reply!

On Tue, Oct 06, 2026 at 12:39:17PM +0000, Joel Fernandes wrote:
> 
> 
> > On Oct 6, 2026, at 7:55 AM, Cunlong Li <shenxiaogll@gmail.com> wrote:
> > 
> > ﻿Hi Joel, thanks for the review!
> > 
> >> On Mon, Oct 05, 2026 at 12:56:30PM +0000, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Oct 3, 2026, at 9:14 PM, Cunlong Li <shenxiaogll@gmail.com> wrote:
> >>> 
> >>> ﻿The kernel.panic_on_rcu_stall and kernel.max_rcu_stall_to_panic sysctls
> >>> count RCU CPU stalls since system boot, and invoke panic() once
> >>> max_rcu_stall_to_panic stalls have elapsed.  This count is never reset,
> >>> so stalls caused by transient incidents keep consuming the budget of a
> >>> long-running system, and a later unrelated stall can
> >> 
> >> Please provide examples of specific transient events you ran into, and recovered from?
> >> 
> >>> immediately
> >>> trigger panic() instead of allowing the intended fresh window of
> >>> stalls.
> >>> 
> >>> This commit therefore introduces the kernel.rcu_stall_panic_count
> >>> sysctl.  Reading this file reports the number of stalls counted so far,
> >>> and writing 0 to it resets the count.  This allows the cumulative stall
> >>> history to be cleared after an incident has been resolved, and also
> >>> allows userspace to clear the count periodically, so that panic() is
> >>> only triggered by a burst of stalls occurring within a short period.
> >> 
> >> Could you provide details of such an incident that got resolved without requiring a reboot?
> > 
> > The motivation comes from our customer systems running codex on Ubuntu
> > 24.04, with a memory limit of ~8G and zram enabled for swap.  When the
> > agent's memory footprint grows, the box spends long stretches in direct
> > reclaim (zram makes reclaim CPU-heavy), and we get a continuous stream
> > of RCU stall warnings.  In the incidents we have seen so far, the
> > warnings kept coming and the systems stayed hung, so we would like to
> > enable panic_on_rcu_stall so that the box reboots and the service
> > recovers automatically.  However, we do not actually know whether some
> > of those stalls were transient, i.e. whether the systems would have
> > recovered on their own once the memory pressure subsided.  If they
> > were, a panic would kill an otherwise recoverable system, which is
> > what we would like to avoid.
> 
> Wait, so does that not mean that if the stalls were legitimately non transient, you prevent killing the system too?

All the incidents we have seen so far appeared to be non-transient:
in one case a VM stayed hung for over 30 hours with repeated RCU stall
warnings on the console, and was finally recovered only by a forced
reset.  This is precisely why we want panic_on_rcu_stall, and the
reset does not stand in its way.

Our plan is to have userspace clear the count once an hour.  With a
non-transient stall, the warnings keep coming, so the count still
reaches max_rcu_stall_to_panic well within the hour, and the system
panics and reboots as intended.

> 
> It sounds like you do know that it is likely transient - but based on this description and the below, it sounds like you have not yet found a use of this patch.
> 
> 

To be precise, we worry that some of the stalls were transient, so a
panic reboot would affect the users.  But we have no hard evidence
either way: every incident ended in a forced reset, and the dmesg was
lost.  Going forward, we plan to enable the NMI and kdump to keep
investigating the cause of the RCU stalls. We will also monitor dmesg
to confirm whether transient RCU stalls actually occur.

> > 
> > We have not yet been able to reproduce this in the lab.
> 
> So you are not using this patch or made use of it?

Not in production yet.  We have exercised it with rcutorture's CPU
stall testing and verified that the counting and reset behave as
expected.

> 
> I am starting to doubt if we want this patch so please make your case properly :-)
> 

From my point of view, max_rcu_stall_to_panic needs improvement: as
implemented, it triggers panic() on the Nth stall since boot.  Given
the background of its introduction -- that some stalls are transient
and the system fully recovers from them -- what it should provide is
N consecutive stalls, or N stalls accumulated within a short period.
The resettable count is the minimal change that provides this.

Thanks,
Cunlong

> Thanks,
> 
> Joel
> 
> >  But transient,
> > self-recovering stalls are not a hypothetical: the commit that
> > introduced max_rcu_stall_to_panic, dfe564045c65 ("rcu: Panic after
> > fixed number of stalls"), states the premise outright:
> > 
> >    Some stalls are transient, so that system fully recovers.  This
> >    commit therefore allows users to configure the number of stalls
> >    that must happen in order to trigger kernel panic.
> > 
> > As described in the commit message, since the counter is never reset,
> > stalls caused by transient incidents keep consuming the budget of
> > max_rcu_stall_to_panic, and a later unrelated stall can immediately
> > trigger panic() instead of allowing the intended fresh window of
> > stalls.  This is what motivated the patch.
> > 
> >> 
> >> 
> >>> 
> >>> Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> >> 
> >> If the commit is AI assisted, please add an assisted tag.
> > 
> > Yes, it is AI-assisted, and I will state that in the v2 commit
> > message.
> > 
> > Thanks,
> > Cunlong
> > 
> >> 
> >> Thanks,
> >> 
> >> Joel
> >> 
> >>> ---
> >>> Documentation/admin-guide/sysctl/kernel.rst | 15 ++++++++++++++-
> >>> kernel/rcu/tree_stall.h                     | 28 ++++++++++++++++++++++++++--
> >>> 2 files changed, 40 insertions(+), 3 deletions(-)
> >>> 
> >>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> >>> index ffea61d448eb..64fe2985e358 100644
> >>> --- a/Documentation/admin-guide/sysctl/kernel.rst
> >>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> >>> @@ -959,7 +959,20 @@ max_rcu_stall_to_panic
> >>> When ``panic_on_rcu_stall`` is set to 1, this value determines the
> >>> number of times that RCU can stall before panic() is called.
> >>> 
> >>> -When ``panic_on_rcu_stall`` is set to 0, this value is has no effect.
> >>> +When ``panic_on_rcu_stall`` is set to 0, this value has no effect.
> >>> +
> >>> +rcu_stall_panic_count
> >>> +=====================
> >>> +
> >>> +Indicates the number of RCU CPU stalls that have been counted since
> >>> +system boot or since the counter was reset. When ``panic_on_rcu_stall``
> >>> +is set to 1, this count is compared against ``max_rcu_stall_to_panic``
> >>> +to decide whether panic() should be called.
> >>> +
> >>> +Writing 0 to this file resets the counter to zero, which restarts the
> >>> +``max_rcu_stall_to_panic`` window of stalls. This allows system
> >>> +administrators to clear the cumulative stall count after an incident
> >>> +has been resolved, without requiring a system restart.
> >>> 
> >>> perf_cpu_time_max_percent
> >>> =========================
> >>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >>> index 091e7850ab6e..a80f03e1c7ea 100644
> >>> --- a/kernel/rcu/tree_stall.h
> >>> +++ b/kernel/rcu/tree_stall.h
> >>> @@ -19,6 +19,20 @@
> >>> /* panic() on RCU Stall sysctl. */
> >>> static int sysctl_panic_on_rcu_stall __read_mostly;
> >>> static int sysctl_max_rcu_stall_to_panic __read_mostly;
> >>> +static unsigned long sysctl_rcu_stall_panic_count;
> >>> +
> >>> +/* Reset the RCU stall panic count when written to. */
> >>> +static int proc_do_rcu_stall_panic_count(const struct ctl_table *table, int write,
> >>> +                     void *buffer, size_t *lenp, loff_t *ppos)
> >>> +{
> >>> +    if (!write)
> >>> +        return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
> >>> +
> >>> +    WRITE_ONCE(sysctl_rcu_stall_panic_count, 0);
> >>> +    *ppos += *lenp;
> >>> +
> >>> +    return 0;
> >>> +}
> >>> 
> >>> static const struct ctl_table rcu_stall_sysctl_table[] = {
> >>>   {
> >>> @@ -39,6 +53,13 @@ static const struct ctl_table rcu_stall_sysctl_table[] = {
> >>>       .extra1        = SYSCTL_ONE,
> >>>       .extra2        = SYSCTL_INT_MAX,
> >>>   },
> >>> +    {
> >>> +        .procname    = "rcu_stall_panic_count",
> >>> +        .data        = &sysctl_rcu_stall_panic_count,
> >>> +        .maxlen        = sizeof(sysctl_rcu_stall_panic_count),
> >>> +        .mode        = 0644,
> >>> +        .proc_handler    = proc_do_rcu_stall_panic_count,
> >>> +    },
> >>> };
> >>> 
> >>> static int __init init_rcu_stall_sysctl(void)
> >>> @@ -161,7 +182,7 @@ early_initcall(check_cpu_stall_init);
> >>> /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> >>> static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> >>> {
> >>> -    static int cpu_stall;
> >>> +    unsigned long count;
> >>> 
> >>>   /*
> >>>    * Attempt to kick out the BPF scheduler if it's installed and defer
> >>> @@ -170,7 +191,10 @@ static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> >>>   if (scx_rcu_cpu_stall(stalled_mask))
> >>>       return;
> >>> 
> >>> -    if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> >>> +    /* A lost RMW update only delays the panic by one stall. */
> >>> +    count = READ_ONCE(sysctl_rcu_stall_panic_count) + 1;
> >>> +    WRITE_ONCE(sysctl_rcu_stall_panic_count, count);
> >>> +    if (count < (unsigned long)READ_ONCE(sysctl_max_rcu_stall_to_panic))
> >>>       return;
> >>> 
> >>>   if (sysctl_panic_on_rcu_stall)
> >>> 
> >>> ---
> >>> base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
> >>> change-id: 20261003-rcu-375496d7704e
> >>> 
> >>> Best regards,
> >>> --
> >>> Cunlong Li <shenxiaogll@gmail.com>
> >>> 
