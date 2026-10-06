Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93D3D75DE
	for <rcu@vger.kernel.org>; Tue,  6 Oct 2026 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287695; cv=none; b=ihFRhIhs/OQJNvv8bY+mQubKPGuG3M0eMTLL7wIMPXbFcH9QqM0rvl/8vas1TZ6Zh4W0krEq9VwFcQ8oF1D//ZBX6LQkcI12F0/qeS83GoMYgRVcUdaZW9mumQQGrpQ/7zUm9cgS9FKht4aKKaaJ0Jh8sfVjlyfg0hdmcBpv4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287695; c=relaxed/simple;
	bh=ec5S30qPeZpFcFjUgJJIOgR9OI8o4nySH5I+NYVFb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=KrUIty0R6kSvhYB7lSwM3D28AubUVSsDaYGTaybsWfxK8B0S52bwAL7LTMv+PXnmX/QUXjHRJIHRFdcxnF5v4A/LkOmQYcLbkEoe7pauhmE91cZpYPh2w8TFdwrfsj79MqXR2S2Ux992vQ4SLifv966cJLcpnp2Vy9FLx9UI800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWpRIsl5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWpRIsl5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so728371a91.2
        for <rcu@vger.kernel.org>; Tue, 06 Oct 2026 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791287692; x=1791892492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:mail-followup-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InkVEEPwk9G9xH08bG50UczMC9CsJoX2e/6UdOdqPB4=;
        b=JWpRIsl5lQTj901UMmC7UoTNdnc0WAWSknAiCHrYA360VWcaUyfwO4VsEbp0VdshSz
         AQ1fXSa3kx3h/pOnWyflf7pCzwtzTkD4KitG8PYoGUHiGbxcyyfz8PrGQ33ijLETKKXy
         DIoKz53ZA+MdseUep3NPvzI5lr2fbirgILb2kUp4XpUOXY93YyQmj2bYtj86SO1LYEPu
         Sn+irnfeoWMjdumcFphuv5Ho1bcEzylGZirobfOE3XgsDET89UPFKvCcxBJEfNh7klrk
         iVAX3Zd+bEzw3cnIoIVnW2K0vK5y4oOCFKfBWPEvBYbxu52f4u6Q/Q9raiOuoh4uVDNz
         eApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791287692; x=1791892492;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:mail-followup-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=InkVEEPwk9G9xH08bG50UczMC9CsJoX2e/6UdOdqPB4=;
        b=l0kjznbhumVpmvZ6bN3WgDhMMooEsQ6+VTMIibZZZHryfdHvchzk5GequyYj67EpOF
         wTSG01lonwhQM4QBj6GzBGW8Op5dvCTk9pmmhY5JnfgsU8zlqniUWW12s9a6T7MQxzHt
         nP6HSiLs2RIGcOHKXTbly63nempc+r0hoIyIJesekfGvGEYT/X4phvLgAuCDO9YAGjYH
         jaEXVAElQ/dJZH3o+j/JYLyEZkD2MKCxDCU5W59m1snU8QUR2FAxSnONQqk+fAchVFs3
         kf7d7nf4wrz7y9PcWYcCFV41kJnl4bWXQpcq390jQXauxhFeTnO0YKqsRupSiVESFtvK
         9S7w==
X-Forwarded-Encrypted: i=1; AKwUvBxEzcyvON5pxY1MMFzA2x/8EIHxHctBc9FlRILxA64T3ccvJtDndbigtHM4/pOSsW0imps=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIS8Ru4ZcS0kYW14rDezs2tIjloCETiyG7BZJzFN0g/NixFXgH
	c8pJxFaH2YAcIt8B5+HHj4Zf8x0X5MTWbAPfHOXV1ej1Vukpabn69tR+
X-Gm-Gg: AYBFou2H/urOQpvXTCBMBCPkVU5MtNj8SaRYfEdQdFtdJs3C8cznGc/8lx7lY4xrfYO
	64fhn2tkc36+BOpmWN/fZ1ECzChkDXA9gZzN1d4vWMU12522D7JUQe5rhEhdsIhdnCbKDsd8AAX
	w/XtfS/F7hjZPigLMKM3a6Yqf9+W4l50KiTSurxZu8ZtQ6rjlBZAHT9bQgQpM8MvBM+iAyyNuMR
	MLdWJ/ArVeZIeP1EbIkK1GyVHzXocvL4hchHbNCYrWENjGiU0sXKzFnRiEUrPhtHWg6Ei6aVEOY
	BGzdHuSQK7Ki7lWd/RjqNcXb3yeWRElJgV5t9rhG8WKT48jI99nBycVNHGmu+G5gS4q1GblZy6U
	VtS1ecXf+sqUVmkxRWYIVLgn6g2cB+KvTgE223A1tVeypMLWlJF/58ax5OkpAI66qJxZEQGMbnI
	5Bvg/QuhnorcVfZi857VuwhSl0jgC/hWF8k7X9LJquyZn1CZexiWQnixOOo27HC5yFw7S9GkCne
	POHGgJpeXI=
X-Received: by 2002:a17:90b:4c8b:b0:3a7:a42:c364 with SMTP id 98e67ed59e1d1-3a87379dcb3mr692290a91.51.1791287691963;
        Tue, 06 Oct 2026 04:54:51 -0700 (PDT)
Received: from localhost.localdomain ([8.139.245.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543b0c1fsm5749910a91.14.2026.10.06.04.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:54:51 -0700 (PDT)
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
Date: Tue,  6 Oct 2026 19:54:44 +0800
Message-ID: <asThhHxoFP2L25Nc@63b45mr6s164qmn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00F6D386-FE41-42E3-9B89-07381A49E061@nvidia.com>
References: <20261004-rcu-v1-1-3799a44367f1@gmail.com> <00F6D386-FE41-42E3-9B89-07381A49E061@nvidia.com>
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

Hi Joel, thanks for the review!

On Mon, Oct 05, 2026 at 12:56:30PM +0000, Joel Fernandes wrote:
> 
> 
> > On Oct 3, 2026, at 9:14 PM, Cunlong Li <shenxiaogll@gmail.com> wrote:
> > 
> > ﻿The kernel.panic_on_rcu_stall and kernel.max_rcu_stall_to_panic sysctls
> > count RCU CPU stalls since system boot, and invoke panic() once
> > max_rcu_stall_to_panic stalls have elapsed.  This count is never reset,
> > so stalls caused by transient incidents keep consuming the budget of a
> > long-running system, and a later unrelated stall can
> 
> Please provide examples of specific transient events you ran into, and recovered from?
> 
> > immediately
> > trigger panic() instead of allowing the intended fresh window of
> > stalls.
> > 
> > This commit therefore introduces the kernel.rcu_stall_panic_count
> > sysctl.  Reading this file reports the number of stalls counted so far,
> > and writing 0 to it resets the count.  This allows the cumulative stall
> > history to be cleared after an incident has been resolved, and also
> > allows userspace to clear the count periodically, so that panic() is
> > only triggered by a burst of stalls occurring within a short period.
> 
> Could you provide details of such an incident that got resolved without requiring a reboot?

The motivation comes from our customer systems running codex on Ubuntu
24.04, with a memory limit of ~8G and zram enabled for swap.  When the
agent's memory footprint grows, the box spends long stretches in direct
reclaim (zram makes reclaim CPU-heavy), and we get a continuous stream
of RCU stall warnings.  In the incidents we have seen so far, the
warnings kept coming and the systems stayed hung, so we would like to
enable panic_on_rcu_stall so that the box reboots and the service
recovers automatically.  However, we do not actually know whether some
of those stalls were transient, i.e. whether the systems would have
recovered on their own once the memory pressure subsided.  If they
were, a panic would kill an otherwise recoverable system, which is
what we would like to avoid.

We have not yet been able to reproduce this in the lab.  But transient,
self-recovering stalls are not a hypothetical: the commit that
introduced max_rcu_stall_to_panic, dfe564045c65 ("rcu: Panic after
fixed number of stalls"), states the premise outright:

    Some stalls are transient, so that system fully recovers.  This
    commit therefore allows users to configure the number of stalls
    that must happen in order to trigger kernel panic.

As described in the commit message, since the counter is never reset,
stalls caused by transient incidents keep consuming the budget of
max_rcu_stall_to_panic, and a later unrelated stall can immediately
trigger panic() instead of allowing the intended fresh window of
stalls.  This is what motivated the patch.

> 
> 
> > 
> > Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> 
> If the commit is AI assisted, please add an assisted tag.

Yes, it is AI-assisted, and I will state that in the v2 commit
message.

Thanks,
Cunlong

> 
> Thanks,
> 
> Joel
> 
> > ---
> > Documentation/admin-guide/sysctl/kernel.rst | 15 ++++++++++++++-
> > kernel/rcu/tree_stall.h                     | 28 ++++++++++++++++++++++++++--
> > 2 files changed, 40 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > index ffea61d448eb..64fe2985e358 100644
> > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > @@ -959,7 +959,20 @@ max_rcu_stall_to_panic
> > When ``panic_on_rcu_stall`` is set to 1, this value determines the
> > number of times that RCU can stall before panic() is called.
> > 
> > -When ``panic_on_rcu_stall`` is set to 0, this value is has no effect.
> > +When ``panic_on_rcu_stall`` is set to 0, this value has no effect.
> > +
> > +rcu_stall_panic_count
> > +=====================
> > +
> > +Indicates the number of RCU CPU stalls that have been counted since
> > +system boot or since the counter was reset. When ``panic_on_rcu_stall``
> > +is set to 1, this count is compared against ``max_rcu_stall_to_panic``
> > +to decide whether panic() should be called.
> > +
> > +Writing 0 to this file resets the counter to zero, which restarts the
> > +``max_rcu_stall_to_panic`` window of stalls. This allows system
> > +administrators to clear the cumulative stall count after an incident
> > +has been resolved, without requiring a system restart.
> > 
> > perf_cpu_time_max_percent
> > =========================
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 091e7850ab6e..a80f03e1c7ea 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -19,6 +19,20 @@
> > /* panic() on RCU Stall sysctl. */
> > static int sysctl_panic_on_rcu_stall __read_mostly;
> > static int sysctl_max_rcu_stall_to_panic __read_mostly;
> > +static unsigned long sysctl_rcu_stall_panic_count;
> > +
> > +/* Reset the RCU stall panic count when written to. */
> > +static int proc_do_rcu_stall_panic_count(const struct ctl_table *table, int write,
> > +                     void *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +    if (!write)
> > +        return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
> > +
> > +    WRITE_ONCE(sysctl_rcu_stall_panic_count, 0);
> > +    *ppos += *lenp;
> > +
> > +    return 0;
> > +}
> > 
> > static const struct ctl_table rcu_stall_sysctl_table[] = {
> >    {
> > @@ -39,6 +53,13 @@ static const struct ctl_table rcu_stall_sysctl_table[] = {
> >        .extra1        = SYSCTL_ONE,
> >        .extra2        = SYSCTL_INT_MAX,
> >    },
> > +    {
> > +        .procname    = "rcu_stall_panic_count",
> > +        .data        = &sysctl_rcu_stall_panic_count,
> > +        .maxlen        = sizeof(sysctl_rcu_stall_panic_count),
> > +        .mode        = 0644,
> > +        .proc_handler    = proc_do_rcu_stall_panic_count,
> > +    },
> > };
> > 
> > static int __init init_rcu_stall_sysctl(void)
> > @@ -161,7 +182,7 @@ early_initcall(check_cpu_stall_init);
> > /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> > static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> > {
> > -    static int cpu_stall;
> > +    unsigned long count;
> > 
> >    /*
> >     * Attempt to kick out the BPF scheduler if it's installed and defer
> > @@ -170,7 +191,10 @@ static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> >    if (scx_rcu_cpu_stall(stalled_mask))
> >        return;
> > 
> > -    if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> > +    /* A lost RMW update only delays the panic by one stall. */
> > +    count = READ_ONCE(sysctl_rcu_stall_panic_count) + 1;
> > +    WRITE_ONCE(sysctl_rcu_stall_panic_count, count);
> > +    if (count < (unsigned long)READ_ONCE(sysctl_max_rcu_stall_to_panic))
> >        return;
> > 
> >    if (sysctl_panic_on_rcu_stall)
> > 
> > ---
> > base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
> > change-id: 20261003-rcu-375496d7704e
> > 
> > Best regards,
> > --
> > Cunlong Li <shenxiaogll@gmail.com>
> > 
