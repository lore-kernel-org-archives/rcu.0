Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F11A267
	for <rcu@vger.kernel.org>; Sat, 20 Jun 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781947539; cv=pass; b=Kujr2QBv4Bz2MZuuBI/2cPaPC7ZYqki6gCIxDpwR7M1PV9NymPEmDe9NB8F+BOFFnEjI6K07IOkL2SOcvzE6m2fkyduaBCtPc5gtQr3va0KdHkYmTEwadEzSJs4mcWCHtKCo9tlmxKOjm5NrN/4+B7ukvJQA5PgtJDYmExRz29o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781947539; c=relaxed/simple;
	bh=L5ZewgzIWv1/RuyFosK1k/ns0h+OHVvOSVJi/9f520Q=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3iOgVbK36KCgHqe7YAES88T1wV9j2eigYTeCfFyCgPEkRCfnOBlIxYULdlo54qg2t9PzpuKvXCIe9VodKUV6fqH14e7aeCSRdL7FETqK9jfndBuB6DuVMieeeZIsUjvS6+mhe2RzlnmFU6KL8wIbNz6wWoLN/gb3q7FSs5gjWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=BIN4jicV; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="BIN4jicV"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA3043F97D
	for <rcu@vger.kernel.org>; Sat, 20 Jun 2026 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781947527;
	bh=n5xFsXHiCYeSu+z4b8f1V8P0TsaKnuNIhP0Q1tsDFRE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BIN4jicVvZe+oxNbZ8MVO5udLecTZ6qN1z9h73fPv6Yl2HCIPajTYvqbIMggqfgkt
	 UB1rNMOm+qIdgxpY1YWPrSB74fx7R6hDIe+fiQI5SBQu8ZsD4DFxh3kGfx/yCrVPOr
	 KzZPr3TjjM0vQDNAJQXBu94B0wzHW96wgKP7nD6mrH9gRkc9az+4k+4eZMTEZBrrms
	 FjSIkpD1O90If7rdKPhUaAUttgZ1ctcHzRFXZFNDWONW1mBSzImniZcJmlLPIfjUQe
	 WRDi7TeMQT32HhDjP1LZScpvWyI9dlLV1dTSWXAScpXSsjTyyjILnhaqcTdt/fuKuc
	 ytyyeXDQiAqsYi5Aqofrv1fVt/vY/M2gP9oaycQFcY3TExQ8jSCot4KxQw9QMnx66Q
	 /q7aAHkhYRJ2qEhc3ZtIuxsxH0CSrvrlHBS4EuHET3aVYTaMJIklBd36uHjPD6pzAP
	 NB6OeHfdPSodK/51AxjsQeBK8w7J15RFoP4JZ5vZ1AmW2WURxeTJHx8DQck8TfkmjS
	 Utwg/q3x1JU5o2Rwo6HxT6xwJX1gUulGVF9OQHL8/KH6zMLio+8LeHwN5d5j0VhwB2
	 BsV5Z63AMLD/yjas9m+fcCCfXIaLqhKfdyAgbBAmyuGJRZoFWHmLAPqjj3rfMc8eA9
	 Wn+9uq6t4yAQJBRTvgMISwsI=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c0762c0c862so175474166b.2
        for <rcu@vger.kernel.org>; Sat, 20 Jun 2026 02:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781947527; cv=none;
        d=google.com; s=arc-20240605;
        b=HnJ+OhY6mOCTh5qWjx37cEVockO4mF9fmwIUw8cjMUbK2cDAnP0AcchJCdvMwfWtdJ
         Pk0DT8BSLTl5ulFLpj4HnDvhdvoO4nN9YkXfTbTJBncjQSDgNNAH02j6acacD9puPW5o
         dR0WguuenePyXDAVEWYtsz1YinrDLabk/MYw2c/eyuUCtqRYSE78YuSpXIj9Lml8/MwV
         mg4KiFrtuRYiWfugydd7VfNNVAqGNiH/z4QNi0Nt9E57UZX7tJ0A42hB8ZUZ/CexvVBI
         x1AK19T1kAxvbBm/MES9YYzHQ+4+BsTLlBomOgJ3VuTpScO/Q4+zOfqvc7Ra3gv2CC68
         ufhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version;
        bh=n5xFsXHiCYeSu+z4b8f1V8P0TsaKnuNIhP0Q1tsDFRE=;
        fh=gtw2REDf/yiVDM1rBM430gcZO5Jnl3TOVbc5Qri0DNo=;
        b=iTbxxi7fO9PWekRfl1n5ozWLgmEbOmATJJBIyvY8lDkSpZCiFuUKjGmJC8E4bx1pBF
         457XRFSkZCQTlOJacQ/gh1cj2FgDQyfoVnLHjLg5Ok4WC0q9lVFe/p4MlqXtdodC+X+5
         mSyanaWRubd7z/34u8Wd/j7rFEjcaL8Q7xELJKP4CoHydCL4mH7FtVUUmTTjTei6KTIR
         xNul2FaHW0iagztFyiictBq84wmvIzi/Of+Cap/A/IElY6MlNQSJdnUNF3zdS1K+ZBZA
         nmnS9U7eCqvzZHTSA2UQOcGv0/VFedIKhGvRn0Z1yEWAIyOsHVedXBvaCbbZTF4EA9H8
         BD1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781947527; x=1782552327;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5xFsXHiCYeSu+z4b8f1V8P0TsaKnuNIhP0Q1tsDFRE=;
        b=EE4m+IUDA2wU3cYim8zmMCll9ixmIEAQMCg8QPKX4m1UEnS/76aobOrBuvZvYjl4Pu
         AcOEjJSje1dlG44mMvHPvVdw7+Y2h4yHgyFVCp682/toapKbauUS+jJ7Cxup//1Ey80k
         Xwjrgdr+K//M9jSYca929IBbbQz2WUGZHBUgAVVtTSrbMAAYgp5ZrJNPKISP+Gv7GZXg
         J3raBTW517md29Gcv3r5zGaBQ5dACoj4C7zpx0luQJEzri7eEe2QHgkInUS/CJy1iBrj
         4vyQ/Kx+8BlEWHce9//Zvf+YDahZMhLCKY4UjeKOxkc7+dNqxJPLEsd3vlDHy0eOrzkO
         fOlA==
X-Forwarded-Encrypted: i=1; AFNElJ/fCKGJv4HcxrubWrA96h1YWXrS0hImQuXspl3PvTrKdf6CoP+9qw6sUkJPS9c6bszZnFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2uss3ORsKlg0THweXQseNctDvKuhAZiWwItEWcM9nFL2Hz+H
	I+c4B8buC+yACTEeIdeOag8e5ZX9XrNZrN2tRtqQL/rB2HEN+nJnMzeA8y15RdzcajsZEn7RMHc
	fqpGa9lZZGo+m0YYlzjzUXNTOHHKnKtyxFDyI3biu0ZMsSqPtC16hHkEb6jJ2DCxOCgL4P0m6R7
	0wMJigKMsiLTo1mZPxUTXTS6340sWV88TAGCWRoOYDPSad
X-Gm-Gg: AfdE7cl2nU0Z5WCTh14GTHQOh8eRMA3c6dSyyOp1C9+3N8SxHC13fxJEcbUWHv5D+v2
	Ps5efRiZQYTSqums5I1zTmiYwoMMTkK9Y2JaFpzD2bzWEEhneXELjr2sbT4WYRav4Y8lp8OtfZy
	fM3j4tZg6ipsoegOpq2WFiDvhItb6GRrYvq6zDsAFqoSYah0Kj51qiO0BnOBhAIPBzlQ==
X-Received: by 2002:a17:907:a0a:b0:c05:7524:884d with SMTP id a640c23a62f3a-c097ccc63bdmr365480666b.37.1781947527096;
        Sat, 20 Jun 2026 02:25:27 -0700 (PDT)
X-Received: by 2002:a17:907:a0a:b0:c05:7524:884d with SMTP id
 a640c23a62f3a-c097ccc63bdmr365479066b.37.1781947526610; Sat, 20 Jun 2026
 02:25:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 20 Jun 2026 05:25:25 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 20 Jun 2026 05:25:25 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ajQPAk_ALP-84obp@MacBook-0RXW5>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com> <ajQPAk_ALP-84obp@MacBook-0RXW5>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Sat, 20 Jun 2026 05:25:25 -0400
X-Gm-Features: AVVi8CePAmtWU1wCLksbKKPXzz3ljeQkbOuCVyrO0kjLNvUr7HtE5CfeHsWd_MY
Message-ID: <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
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

Quoting Boqun Feng (2026-06-18 17:30:10)
> On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
> > Quoting Boqun Feng (2026-03-20 23:29:16)
> > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > happen basically everywhere (including where a scheduler lock is held),
> > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > the work to start process_srcu().
> > >
> > > [boqun: Apply Joel's feedback]
> > > [boqun: Apply Andrea's test feedback]
> > >
> > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > Tested-by: Andrea Righi <arighi@nvidia.com>
> > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> >
> > Thanks for the patch, which is now upstream as
> > 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
> >
> > Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
> > SoC both on the 7.0 and 7.1 kernels:
> >
>
> By "single-core", is it only one CPU in that system?
>
> > https://esmil.dk/d1-7.0.txt
> > https://esmil.dk/d1-7.1.txt
> >

Yes, the SoC only has one CPU core capable of running Linux at least.

> From the callstack,
>
> [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
> [  243.021858] Workqueue: device_link_wq device_link_release_fn
> [  243.027587] Call Trace:
> [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
> [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
> [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
> [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
> [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
> [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
> [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
> [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
> [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
> [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
> [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
> [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
> [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
> [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
> [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18
>
> I will guess for some reasons the irq_work was missed or the IPI never
> happened. Is it possible for you to enable trace points ipi_send_cpu and
> ipi_entry to get more information?

I have to admit I've not used tracepoints before, but it seems like only
ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
I've now added trace_event=ipi:* and tp_printk to the command line, and this
is what I get:
https://esmil.dk/d1-7.0-2.txt

Let me know if there is something I'm missing or something else I can do to help
find the bug.

/Emil
