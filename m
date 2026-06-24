Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5F397E8A
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291310; cv=pass; b=FGYkolh9kq/bnAg7Aegg8nPd8Sczec2X81/6TAln/9omqfSrU/CM0xTKX0jDsfKXS5Lj+mMzmaS1r445jUNCiSRZ2ROWHY5n9JIhM8p+2RGxBrCrKV8YdrKZHP3u9ZuGqL6NWNKnWuyN9VbXP8d/72kfZCnoGzmO1EVDYRbCk4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291310; c=relaxed/simple;
	bh=eYwAWYWD5M9EvxZkfXpbGlD4xih23k507q35J+Xy7eQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhOMJKNcTAWHD6mtsYAB4oqUtI7RlNJwErv6sDnogTf7GBUbGmGC16J7omd2NHcyCMZY5HlAsP01awCHDCZ+dS41Atqbf/tTmodRPfdd3lEqkmPetwg6gESXjKXCNAE8ilRf/P3zfR2QQKhmuBhxPGP6rYa5mtwwx7IJgtUHtlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jP2eOpIB; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jP2eOpIB"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABB123F7D1
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 08:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782291307;
	bh=s7TqPSu/A9xR8G74filqeitAQECJWjPR3ecsYhIZTqU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=jP2eOpIBDWowl6ne4pWE6R0cvt3TRpfGEnbd1sokR/Gu5d+rzxmtXS+CJfHLYueFp
	 Q1ITVFIPvaTJzRB64Zs0trC/wKNNN8U5WVDiCc+ujFY+iXFh/BTf5ISvfO2WgeDcrt
	 3lJjFDuMnEigVBEG2c3N6e5XoU9D0OnpUeDho1tTVmx0p2+y0hNEthmuIPcW92+BfO
	 NW7mjXvaFZTNo2WfJNHjN7UhTRNx2RPmCjaZ6f9T4Ns5Q/cEa+Ar/AlnC6EJ04D1SY
	 GbSAP3WK9pLmZUh1d9Xz1Kg/4JIsmlVzhzF9veXZKM2GeM31j2+yxIyuj2MOEQPwRF
	 lqXzfb8XzydQS45iGAhQN3TI5+UvTGtWWIOqlOYM+KM84huTd8e6QxGlbXJiUrj8bJ
	 91LJwcpEcANxmzlZDlbRlIw5/LIztB4KB4xRosVXUqYxSnfV1J8k3DK+t37ZzeWT6D
	 2QkJs+Vd/RMwBvy+0+MzIvEKBe5hjVk+HYjt/Tk/UjwvmghK/82LRK3o2kBNvhbBtG
	 NObL8H2ZrSHIpmkGk6kA3UkJYLZiMLpgq4jFiVaNse0Y37VCsBaM0ziSJYaMIrtsPa
	 giZRHlYNO+Tv7u5feSJtu1k7gV3Sx6TOj+J5tF/h39brLxFAoUru02mswEALzdujez
	 LVhtR+U6eALWvv+iU14CU0Yo=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c0deb2b9dceso55660366b.1
        for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 01:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782291307; cv=none;
        d=google.com; s=arc-20240605;
        b=QNF4vMWAW+kAULaEoTsjwxPN870cPYtZFk5+oFMOgdCSQPdOdneW0Rjlk40F/j/2Qg
         ARAzOEyxRBb1RvCgb9XV2cG89TlxI30godpwfZ3sP9l5VelhYV4Q9Rc+L1qd/HTGb2+6
         wm3NtGvW2sNsotm8b1E5sQEkv+q6h5HP3VLgRTAWSI2x1PUQsBycW0CrDqRr4EGrF+sO
         9FlNlvs5mJnz2DTRdvPOTcBi1PVHboN062duIOKSvpDLyS6/X8c8g/cvbtSgqnfYZOQm
         BMelY5oAF11WluQvPIaVdNeMwQqKAokBumvJ/HWB8Y6FI1Sgk57zL83aIeXTy+6mGb4R
         BrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version;
        bh=s7TqPSu/A9xR8G74filqeitAQECJWjPR3ecsYhIZTqU=;
        fh=jBBICawG8eC4unxMuTZouzUfxt/BKIekF4PXYeEgT/I=;
        b=NgxKw0ryE4hllDTXf41phLCoQRzM6tVy/fSPWmZzUxsf8fMthCvUoBAbl58cUcelNZ
         +0NIsS06EJFsXgFTVfVH4wNaJT+wB/dtkigF+vMEcuQGoKFY35KKRW/Cdj1NeZcbIEb+
         RDRD6u401I20uDK//2LmIlHXHyjQ4owFLARssFHWKvV+XxQ4NyanumNblS5FeC5nUkBg
         6yfG/FOnLIRhIGCFGGscmi4Vz7Cq5VT7bQpCCf8QMRaiTve9fsbEHqNFdhHvYL3ET9IP
         rIt5gq04hbNVPhT7jk+H/i0Ljgw9leM0YWgvWIF/dCgqXPiHUta8qdsDb+Qjzj2K/Rou
         Ny2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291307; x=1782896107;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7TqPSu/A9xR8G74filqeitAQECJWjPR3ecsYhIZTqU=;
        b=nTNI7MrBl0yoK3WHIZPrmk9J6WOOcbvlqz00IumeLrtl7tHFoX+6GEJG0eL07byf5S
         s+lXL1FjYf/3RzhXCGxRcEE6EqAArJzVWfTxV9ySf9rs2GWhQF2Y1HLTI6Qzvcdprbd4
         fr4y+V0sIQQMqsraJo4bvHMEfQ2xIWnJfSfu/xzPStFtlQR0qjYERxPN+nZudvZy9XwX
         521HMjdYbDPKkGe2pOnyX4rdRsfjpz80yug3/ldJuLvY6XbLIZHwXgsPNAIwNu5W+eCh
         cn5AVM5xHZDknhYLS5veJzFVODd0qBpK21Q50CgZhl2fnJETv0mUkKc5GZ8gq66xEu/U
         8u4w==
X-Forwarded-Encrypted: i=1; AFNElJ9W8pC0FYlMTUfGB6OH3VI0/caBmyHUmXZvxkygjX8ShbRqjNR1Dps/JIREb1w9rYwozuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaRmcm41gBQ8hc0seQ6cwFv2/cZoG0ztpMsnwT4apI8P9PYYc
	bt37vlWETLKP5v2LRulWfEayZn7DfcgDXZ9LTEgnB6wmmrRNXFM7i7WcULewWySvPO/fIHPTxCU
	Jb7HM9jGQgtPE/fesW10oQhunv5p0Jgib9Ficbfb+kGWGGPnHSK3x++wwvKC4UzT8vgM8xPYP/B
	lvTM+ztoTCTfEo9vd8QfPBNeDuYkaZsKIt6wsLpTIbOU82
X-Gm-Gg: AfdE7cmTC+22ng6LWu4lITeFQdtucd/q0mlwM4umV3BhcNcaVC3+95e6i+Mc4R2Ns/V
	ZUz0AxpN+h47g6j50r2qMBFOauwzvQ09jiDWdd2ZqOA43InlZN0J2wSNTU2nS7avYdWSv/voZ1v
	Xtj0RX6TLOZj1VPDlsLkq7pExzbUaiQm1sLXT6HnKzTJybVcFLqzNhT6BQ+7uZQlJidw==
X-Received: by 2002:a17:907:d16:b0:c0e:e136:5dc9 with SMTP id a640c23a62f3a-c119eb4f188mr116946266b.37.1782291306903;
        Wed, 24 Jun 2026 01:55:06 -0700 (PDT)
X-Received: by 2002:a17:907:d16:b0:c0e:e136:5dc9 with SMTP id
 a640c23a62f3a-c119eb4f188mr116942466b.37.1782291306382; Wed, 24 Jun 2026
 01:55:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 04:55:05 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 04:55:05 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <80773b89-f333-4c82-99b5-3fca44ea93b3@sifive.com>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
 <ajQPAk_ALP-84obp@MacBook-0RXW5> <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
 <ajlW4oSzEqav6gxc@MacBook-0RXW5> <CAJM55Z_7N40ARWGoZg04p-NnAy-w10v4=Em-e4Bx4+oNYMGBLg@mail.gmail.com>
 <80773b89-f333-4c82-99b5-3fca44ea93b3@sifive.com>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Wed, 24 Jun 2026 04:55:05 -0400
X-Gm-Features: AVVi8CeYfdj8i8RJ4gjMUNpq9dpeYFKIx4E4OBuE2SSA-tZZ9Xi0mIgO0ILPk4g
Message-ID: <CAJM55Z_aUzPieiGKPgr_iETovgyGB0EUFau+=tLxZksT9CkpYQ@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Boqun Feng <boqun@kernel.org>, Samuel Holland <samuel.holland@sifive.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, 
	neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>, 
	Zqiang <qiang.zhang@linux.dev>, linux-riscv@lists.infradead.org, 
	Sarah Emery <sarah.emery@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Samuel Holland (2026-06-23 17:53:19)
> Hi Emil,
>
> On 2026-06-23 4:34 AM, Emil Renner Berthing wrote:
> > Quoting Boqun Feng (2026-06-22 17:38:10)
> >> On Sat, Jun 20, 2026 at 05:25:25AM -0400, Emil Renner Berthing wrote:
> >>> Quoting Boqun Feng (2026-06-18 17:30:10)
> >>>> On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
> >>>>> Quoting Boqun Feng (2026-03-20 23:29:16)
> >>>>>> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> >>>>>> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> >>>>>> happen basically everywhere (including where a scheduler lock is held),
> >>>>>> call_srcu() now needs to avoid acquiring scheduler lock because
> >>>>>> otherwise it could cause deadlock [1]. Fix this by following what the
> >>>>>> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> >>>>>> the work to start process_srcu().
> >>>>>>
> >>>>>> [boqun: Apply Joel's feedback]
> >>>>>> [boqun: Apply Andrea's test feedback]
> >>>>>>
> >>>>>> Reported-by: Andrea Righi <arighi@nvidia.com>
> >>>>>> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> >>>>>> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> >>>>>> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> >>>>>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> >>>>>> Tested-by: Andrea Righi <arighi@nvidia.com>
> >>>>>> Signed-off-by: Boqun Feng <boqun@kernel.org>
> >>>>>
> >>>>> Thanks for the patch, which is now upstream as
> >>>>> 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
> >>>>>
> >>>>> Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
> >>>>> SoC both on the 7.0 and 7.1 kernels:
> >>>>>
> >>>>
> >>>> By "single-core", is it only one CPU in that system?
> >>>>
> >>>>> https://esmil.dk/d1-7.0.txt
> >>>>> https://esmil.dk/d1-7.1.txt
> >>>>>
> >>>
> >>> Yes, the SoC only has one CPU core capable of running Linux at least.
> >>>
> >>>> From the callstack,
> >>>>
> >>>> [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>> [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
> >>>> [  243.021858] Workqueue: device_link_wq device_link_release_fn
> >>>> [  243.027587] Call Trace:
> >>>> [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
> >>>> [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
> >>>> [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
> >>>> [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
> >>>> [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
> >>>> [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
> >>>> [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
> >>>> [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
> >>>> [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
> >>>> [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
> >>>> [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> >>>> [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> >>>> [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
> >>>> [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
> >>>> [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
> >>>> [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
> >>>> [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18
> >>>>
> >>>> I will guess for some reasons the irq_work was missed or the IPI never
> >>>> happened. Is it possible for you to enable trace points ipi_send_cpu and
> >>>> ipi_entry to get more information?
> >>>
> >>> I have to admit I've not used tracepoints before, but it seems like only
> >>> ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
> >>> I've now added trace_event=ipi:* and tp_printk to the command line, and this
> >>
> >> Thank you! Yeah, this is what I meant ;-)
> >>
> >>> is what I get:
> >>> https://esmil.dk/d1-7.0-2.txt
> >>>
> >>
> >>
> >> [    0.071132] rcu:     Max phase no-delay instances is 1000.
> >> [    0.077837] ipi_send_cpu: cpu=0 callsite=irq_work_queue+0x22/0x4c callback=srcu_irq_work+0x0/0x58
> >>
> >> Is this the last line you can see from your (serial?) console, or we are
> >> missing a few more lines? Maybe it'll should the same hung task
> >> messages?
> >
> > Yes, sorry for not being clear about that. This is the exact same binary booted
> > without the two extra command line parametrs:
> > https://esmil.dk/d1-7.0-3.txt
> >
> > But with the two parameters added the board reboots before getting to the hung
> > task messages. The bootloader enables the watchdog, so I think what happens is
> > that the kernel halts earlier with the tracepoints enabled, and doesn't get to
> > load the watchdog driver to keep the machine from rebooting.
> >
> > The same happens with just trace_event=ipi:* added, just without the last
> > message above.
> >
> >>
> >> The ipi_send_cpu message means RCU was able to send an IPI, now if there
> >> is no ipi_handler between the send and the hung task, that would mean
> >> the IPI was missed.
>
> Assuming that your OpenSBI version is exactly v1.3 per the boot log, and not
> "v1.3 + patches", then you would indeed not be receiving IPIs. You need at least
> this commit: https://github.com/riscv-software-src/opensbi/commit/446fa65eb579
> (included in v1.4) or alternatively to add the CLINT to the M-mode devicetree.

So then we're in a situation similar to [1], where upgrading the kernel from
6.19 to 7.0 requires you to update the firmware first. To me and from the thread
that seems like a really obvious regression. So the question is, how can we make
the current kernel work like < 7.0 kernels worked?

[1]: https://lore.kernel.org/all/87jzgjnh9z.ffs@tglx/#t

/Emil
