Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AD370AFB
	for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207264; cv=pass; b=lqVclTy+xXlx1h+SuqWWQYONOAPasVMdYmHzn3iVURE/KFhABE5XTY0hoqxGN6vISJBMrb+o7Fgnzxwi8xAWw5uEVJRkESO3B93YpfBa0KKihWEs7quHFTc5fq5RcJKW8svITjX3Ot10w0dpDJVRj4GQxcw6xdg/YTeG9IcOmss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207264; c=relaxed/simple;
	bh=lIsDmZ53swgi62/lXyTRsvtF6ZbNbxx93c90ruKS3gs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+8SiypLn+SK4poI+O3sfj/WcXtIvs3FzbOwbwGXh6VWVZCL/0ekkqkSliZV/QmkA/Uhk+WCHGWHoCuXQW3mEyJjTJZ/TiR++DE035geVTuImYnrNtTX7xnpRlXK1vFnRu0ej7PGD6nx9O8Macfz5nyUkXJSDveJ4jDywv2s9IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=L/Rioj0a; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="L/Rioj0a"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4D6693F7BD
	for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782207260;
	bh=k/jZC0jxAqjvGzOmb9VX8r5AMgUUP3sAniVJUnbB+gc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=L/Rioj0aQTXCV2YHcwsK9Av5v2oNc0vkUfDrKXxSAFA9mp198ZZW5vdNEl8BgRzl9
	 O/ylHHIsLRB6ph7jdEwlPuWz68atQewVf7Pzd4S6LraFXgQoB4dIuZD76/hwNdkgNJ
	 TLlXjbcGMpriNtILGzXPGZ26wE4M3pFueGrntCnihF6+Xv1zYXNj4xGw6tLTwH8GQF
	 z031DnTmdwa1hPsIBivZQTwP8Tj8E0R7LbfAc0U1Qa+FQEnxuvXFTX110HG6JmDTWi
	 YRqCrxTwec2v683ZxSJq7Iaz2LKFyNyzcNm37KUvV7XuKSUJ2IBekFt6fBtbqI+tys
	 xOG30fmYivv9obQw8Cxc13Jn/Od34moUVjv8XGTIZ30xOHaUJf3qOvWSkD87PYIf2m
	 zq7fWMszXSx1eSeaUx+7u9kjH4lZS9u87+mrX1jLrocYpi5g1J872H2bkIy4IdHmjV
	 /wAa3L/ITMO90wOQ2Ny39x8DVteZJ3ATT/p8UzzgemWAb+8Z9RryaMFEjshmxHZ9yq
	 Y+NHR0NaaHURymXzcLnO8kU6TeNNpLrKa29CHXmXXTza/Ke2UxWhxw1NWO9gtfNRpN
	 V4E+szcXUiVdX/nPB1/Ngi5W2HphJ3A9xg0KBW4zIOH0nlaXSV2BG4whxJ0dAB+xog
	 n9CKSSMOenIGGWhj2Q/DWkaI=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c0bcdf949d5so368155266b.2
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 02:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782207260; cv=none;
        d=google.com; s=arc-20240605;
        b=f8VDIQ3fVb7ste54FAYPrAWTFOPMmuYOgrSaS5GyJh998LAIuNWTk1wNhfsnaagcUx
         KEcHJgGJhTh74396C6BgZ+X3BhYxqMpCEE2exjpPasMY9T0AlGUUE/G9rIBslapYP2gm
         Z4T4m/KGpcxXa9cE4mPUSzwRmoI7NmJ1niB7BWmZnmTXaavPRlcbuXWC2qfgYehokK14
         wsisHt0Ibvg063vxJx8yfHyysmn15C5y+y/3IBpWXdiCXX2EoOqKx5OHgWe2rEWe3p6Y
         Y4SbtBjezBZeE/rj3Qvz/PGWIG3aPcdDBiE5UWTLGL1EXLPetL6fRbfuvLlEhy+Ea30z
         +cSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version;
        bh=k/jZC0jxAqjvGzOmb9VX8r5AMgUUP3sAniVJUnbB+gc=;
        fh=qw4/MDA9DN0xIet6UesTiwCyjZAyPGinlHpsMBxFlKc=;
        b=K87qI5nMuQM56OO6z7csvRNTIIQ2v8E4SuudAH311VTIdC4ayl0xiBhnkmxZCgFqH+
         UbaGpdV99gXXpQ0T97LOoonzSTYLgPhWRueR+wVbuAvZt19mAOYu0xKeElPjogB/Eh3K
         JS9eHyeToXefHlf4tbLSAyLadCVLazZoqFpEUbxFXL7lrPsk16wJVWDdqW2horBZ8WWK
         vuUML/Xg0cILS/gJLvPC3Ho56pACNc7AzlnZNhpXuwSPTSLdYC3EQbDmLLRtTS2+sDvl
         dM6CX0r7USFciv+ymcctO35kT8FWefCpf1YeQvyTwY9r0kB1C3uDZUpScbWAlarADeO0
         3iow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207260; x=1782812060;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/jZC0jxAqjvGzOmb9VX8r5AMgUUP3sAniVJUnbB+gc=;
        b=HGNuxDCGgQpv+npKkaZyIcsohmMqgTr9AEJI19qd86OKmecY6D6UMnDfq6IJVmfLC4
         Z/ete5MEkh1sFUxc+D3YkL6KupjxR23hr5KM4eAfzGuIRSNmbrAChQ0YD1x1oDMogL4E
         ERH2RASEsPbVGzAmnP7acHf6s1x3Ip1umyVuGUXS9T3QmbbCb/xxCdI+L7IPRnWRHHHo
         lSq9JBrO6uqPUbvfmLAbZI/HTAWT/xqni5K5va6VdGj+vjiK8Oss8Em6L+3GcZlnYX+m
         xGibJKYJH2IMAVMI8sgXdlz2UiLlfXDGuTxtLnlspIehIQx6k25VIx917PKxu8cn427e
         BP4w==
X-Forwarded-Encrypted: i=1; AFNElJ+Lvm8uh4p/pEqU39cfTvakm3q6dCllcO7isLrPm/DhmkZDpNGQKUFGh/eXGsVF+cLzQ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1WKKGc3vy86yOzf7nR8bU5BrJRW00NE0xjyRUkn2uEXO1Gf5
	47EwNCOznqUg6wFGZNahqP89Yup0scBTkH27mlVgwqRBCyc8ouRJp8Kb0jFLaz8DIToI48W8XMr
	GUsvY7TcvCgSMYsolM1AzOYp4JDnTMRkHTu5zKyHTWr5us1YeV/KMJF7pqLqka+ue0PweBRv8rR
	DbZ3nWhb2YUtLADKEy51/OIGRxFDL2Za70p6ucGBmcPLIl
X-Gm-Gg: AfdE7cn2yQZBsdoj/px+ypV/t4qIR8y7HV2RdgoLP2zceNgAE8xa9uw7ZNaiuXHQzlR
	TcxnczOzijGyR+S6XAw9+6Rsvh6rZGVn8zqpP0Jpb2FIArVy0+8PziSYDEfuq4iNYHFnHzS0zvj
	oPNCOPxOB/7TWvrgXoVEXeqKTa4TkMfrbm1ignbZe+ARkfi4g9EP+UTmKQLxmlNvtnOw==
X-Received: by 2002:a17:906:ef06:b0:c0f:c475:6bd6 with SMTP id a640c23a62f3a-c108db17c0cmr92554866b.13.1782207259725;
        Tue, 23 Jun 2026 02:34:19 -0700 (PDT)
X-Received: by 2002:a17:906:ef06:b0:c0f:c475:6bd6 with SMTP id
 a640c23a62f3a-c108db17c0cmr92552666b.13.1782207259313; Tue, 23 Jun 2026
 02:34:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:34:18 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 05:34:18 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ajlW4oSzEqav6gxc@MacBook-0RXW5>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
 <ajQPAk_ALP-84obp@MacBook-0RXW5> <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
 <ajlW4oSzEqav6gxc@MacBook-0RXW5>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Tue, 23 Jun 2026 05:34:18 -0400
X-Gm-Features: AVVi8CdojB9okAozVltix1WQqZPQNDUlWinUTJkCeQ22W9Cw9M6UJGdyZafHpRM
Message-ID: <CAJM55Z_7N40ARWGoZg04p-NnAy-w10v4=Em-e4Bx4+oNYMGBLg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, 
	neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>, 
	Zqiang <qiang.zhang@linux.dev>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, Sarah Emery <sarah.emery@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Boqun Feng (2026-06-22 17:38:10)
> On Sat, Jun 20, 2026 at 05:25:25AM -0400, Emil Renner Berthing wrote:
> > Quoting Boqun Feng (2026-06-18 17:30:10)
> > > On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
> > > > Quoting Boqun Feng (2026-03-20 23:29:16)
> > > > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > > > happen basically everywhere (including where a scheduler lock is held),
> > > > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > > > the work to start process_srcu().
> > > > >
> > > > > [boqun: Apply Joel's feedback]
> > > > > [boqun: Apply Andrea's test feedback]
> > > > >
> > > > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > > > Tested-by: Andrea Righi <arighi@nvidia.com>
> > > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > > >
> > > > Thanks for the patch, which is now upstream as
> > > > 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
> > > >
> > > > Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
> > > > SoC both on the 7.0 and 7.1 kernels:
> > > >
> > >
> > > By "single-core", is it only one CPU in that system?
> > >
> > > > https://esmil.dk/d1-7.0.txt
> > > > https://esmil.dk/d1-7.1.txt
> > > >
> >
> > Yes, the SoC only has one CPU core capable of running Linux at least.
> >
> > > From the callstack,
> > >
> > > [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
> > > [  243.021858] Workqueue: device_link_wq device_link_release_fn
> > > [  243.027587] Call Trace:
> > > [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
> > > [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
> > > [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
> > > [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
> > > [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
> > > [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
> > > [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
> > > [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
> > > [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
> > > [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
> > > [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> > > [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> > > [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
> > > [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
> > > [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
> > > [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
> > > [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18
> > >
> > > I will guess for some reasons the irq_work was missed or the IPI never
> > > happened. Is it possible for you to enable trace points ipi_send_cpu and
> > > ipi_entry to get more information?
> >
> > I have to admit I've not used tracepoints before, but it seems like only
> > ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
> > I've now added trace_event=ipi:* and tp_printk to the command line, and this
>
> Thank you! Yeah, this is what I meant ;-)
>
> > is what I get:
> > https://esmil.dk/d1-7.0-2.txt
> >
>
>
> [    0.071132] rcu:     Max phase no-delay instances is 1000.
> [    0.077837] ipi_send_cpu: cpu=0 callsite=irq_work_queue+0x22/0x4c callback=srcu_irq_work+0x0/0x58
>
> Is this the last line you can see from your (serial?) console, or we are
> missing a few more lines? Maybe it'll should the same hung task
> messages?

Yes, sorry for not being clear about that. This is the exact same binary booted
without the two extra command line parametrs:
https://esmil.dk/d1-7.0-3.txt

But with the two parameters added the board reboots before getting to the hung
task messages. The bootloader enables the watchdog, so I think what happens is
that the kernel halts earlier with the tracepoints enabled, and doesn't get to
load the watchdog driver to keep the machine from rebooting.

The same happens with just trace_event=ipi:* added, just without the last
message above.

>
> The ipi_send_cpu message means RCU was able to send an IPI, now if there
> is no ipi_handler between the send and the hung task, that would mean
> the IPI was missed.
>
> Regards,
> Boqun
>
> > Let me know if there is something I'm missing or something else I can do to help
> > find the bug.
> >
> > /Emil
