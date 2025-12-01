Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02D182B7
	for <rcu@vger.kernel.org>; Mon,  1 Dec 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764632973; cv=none; b=Py8skTTSTdlNgsQPqEgfpsZIcnvtqw8ca4UOlWbin/foxU2T9uZZnnxB5cPoYGkcD97j4QTzegNPlXw8VceMQUjITwKgQ3n4WVN7ZE0uN5ND0BmrGJczNhxvwK93kwGFlAekIEJf4d0a0rbNVDhZusAe+m/A7p8ng3Yl6DlXrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764632973; c=relaxed/simple;
	bh=RdOJR20bs2ivpPI2mhBvgFTYVY/Nm6iBreS32CASUus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOUcMxM6wKuWPExX8ZWD5iffPuVZ8OmHUDIl7GKKc020FvrGlJv6wgZHWpgbVHH0063qj1StEiHQGQo8sqTcjaIiidMIJ7QEvwAlZNwKYpR/OW8cVTRH9EFMZQJuGAgHG6hZTCxVhFjRWxoDUIdTLQ0DjY6QwtXM7fK915ZdfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AD61zCcJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD61zCcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764632970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5pQYbjS4ON67ZhNnO3irc6qHx27milprD4CfE5GNwo=;
	b=AD61zCcJ0Bqa0ioa85MHgP+ZMfKv8fScHHbLBCyCmaY9FtPOI93Kxr9rci7uZJS5A5seL8
	U/E9MuKupdMrSRoy4hkKblt7MLB9l36hbyTUy3eIFoGpwhHLu8QMal3qC+UCC5WoYEmeax
	bCTNPKAPnZd5hPAn6Vk+X+LFPQmJvYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-BoqLkeiwOaWnUwm24R7PEQ-1; Mon,
 01 Dec 2025 18:49:25 -0500
X-MC-Unique: BoqLkeiwOaWnUwm24R7PEQ-1
X-Mimecast-MFC-AGG-ID: BoqLkeiwOaWnUwm24R7PEQ_1764632963
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D80241800250;
	Mon,  1 Dec 2025 23:49:22 +0000 (UTC)
Received: from localhost (unknown [10.22.80.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9EEE19560A7;
	Mon,  1 Dec 2025 23:49:21 +0000 (UTC)
Date: Mon, 1 Dec 2025 20:49:20 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	stable-rt <stable-rt@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v3 3/3] softirq: Use a dedicated thread for timer wakeups
 on PREEMPT_RT.
Message-ID: <aS4pgDjn1b8coe0r@redhat.com>
References: <20241106150419.2593080-1-bigeasy@linutronix.de>
 <20241106150419.2593080-4-bigeasy@linutronix.de>
 <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d66a966-0b89-416a-8712-6a6131af355e@siemens.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Dec 01, 2025 at 10:51:50PM +0100, Jan Kiszka wrote:
> On 06.11.24 15:51, Sebastian Andrzej Siewior wrote:
> > A timer/ hrtimer softirq is raised in-IRQ context. With threaded
> > interrupts enabled or on PREEMPT_RT this leads to waking the ksoftirqd
> > for the processing of the softirq. ksoftirqd runs as SCHED_OTHER which
> > means it will compete with other tasks for CPU ressources.
> > This can introduce long delays for timer processing on heavy loaded
> > systems and is not desired.
> > 
> > Split the TIMER_SOFTIRQ and HRTIMER_SOFTIRQ processing into a dedicated
> > timers thread and let it run at the lowest SCHED_FIFO priority.
> > Wake-ups for RT tasks happen from hardirq context so only timer_list timers
> > and hrtimers for "regular" tasks are processed here. The higher priority
> > ensures that wakeups are performed before scheduling SCHED_OTHER tasks.
> > 
> > Using a dedicated variable to store the pending softirq bits values
> > ensure that the timer are not accidentally picked up by ksoftirqd and
> > other threaded interrupts.
> > It shouldn't be picked up by ksoftirqd since it runs at lower priority.
> > However if ksoftirqd is already running while a timer fires, then
> > ksoftird will be PI-boosted due to the BH-lock to ktimer's priority.
> > Ideally we try to avoid having ksoftirqd running.
> > 
> > The timer thread can pick up pending softirqs from ksoftirqd but only
> > if the softirq load is high. It is not be desired that the picked up
> > softirqs are processed at SCHED_FIFO priority under high softirq load
> > but this can already happen by a PI-boost by a force-threaded interrupt.
> > 
> > [ frederic@kernel.org: rcutorture.c fixes, storm fix by introduction of
> >   local_timers_pending() for tick_nohz_next_event() ]
> > 
> > [ junxiao.chang@intel.com: Ensure ktimersd gets woken up even if a
> >   softirq is currently served. ]
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org> [rcutorture]
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This went into 6.13 and was never backported to 6.12-lts. And that is
> why you can easily stall the latter with a workload like this and
> CONFIG_PREEMPT_RT enabled:
> 
> echo "+cpu" >> /sys/fs/cgroup/cgroup.subtree_control
> echo "+cpuset" >> /sys/fs/cgroup/cgroup.subtree_control
> 
> mkdir /sys/fs/cgroup/stalltest.sub1
> mkdir /sys/fs/cgroup/stalltest.sub2
> sleep 10000000 &
> pid=$!
> 
> systemd-run --slice "stalltest.slice" taskset -c 0 sh -c " \
>     while true; do
>         echo $pid > /sys/fs/cgroup/stalltest.sub1/cgroup.procs;
>         echo $pid > /sys/fs/cgroup/stalltest.sub2/cgroup.procs;
>     done"
> 
> echo "1000 20000" > /sys/fs/cgroup/stalltest.slice/cpu.max
> 
> This triggers a lock-up if a holder of cgroup_file_kn_lock with
> SCHED_OTHER is scheduled out after using up its timeslice and then
> cgroup_file_notify_timer fires over a SCHED_OTHER context as well,
> trying to get this lock, failing and then never being able to reactivate
> the lock holder again as well.
> 
> I've nicely reproduced this with upstream 6.12.58 while Debian's lastest
> 6.12-rt does not trigger because it additionally has the downstream -rt
> patches on board.
> 
> How should we handle this? Consider 6.12 mainline with -rt and cgroups
> as potentially broken, asking people to user 6.12-rt? Or port this back?
> 
> BTW, the original report of this issue came from an older
> 5.10.194-cip39-rt16 kernel (based on rt94 for 5.10). When was this
> feature introduced to the -rt patches? Was it ever backported to 5.10-rt
> or other -rt versions?

Hi Jan!

I failed to locate the original discussion (from v5.10-rt) as the V1 of this
patchset is a new thread. Anyway, you are correct, the commit below (and the
other two changes from the series) are not present in v5.10-rt.

AFAICT commit 49a17639508c ("softirq: Use a dedicated thread for timer wakeups
on PREEMPT_RT.") was merged initially to v6.13-rc1, it was never exclusive
to the RT tree.

Luis

> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
> 
---end quoted text---

