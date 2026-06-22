Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A953B7B8E
	for <rcu@vger.kernel.org>; Mon, 22 Jun 2026 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142696; cv=none; b=M1uAbwVU4Lsn5AGXTqZQVcGFmMEMxg15k5gBE50ynX7ZNT8aaHB8ZIjPvUXLvb9O33nEVtmxwvtmFi1WHJlkbBcPM4IBFlgu38r81+IB+ipREGBTTZOqrS66uD2W79PHZ6JBZU6XI3Bjl2+ExPOk7fZ0E9Vxco1Qs78FXhIVFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142696; c=relaxed/simple;
	bh=o/s+o7dVem5gBGp9wdtfJofJ/Z0TDtuyhz7cSJ5Ah6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuOnFdbxtMKPyCJd9UlYDp8REKithD9JzDt9+h5hPbjc55SVX3/gIVWeR7wbT1nSoHSvFmJNRTjQltbi0uHqqMQGJ2bNOP383/wZeovcL4FL8Xydj0oJT9pvVS1M9SWOVOnrQXwMumwkWuuzLFf1kd0H+oErEYNWPh2Wljb1ACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCq4WLLU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCq4WLLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D669C1F00A3D;
	Mon, 22 Jun 2026 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782142693;
	bh=Cc/bXyRMUG5SseM+Z+uSARrGPTs5LuLmI0Wv6RXM2XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MCq4WLLUzDUdEWfbhPNnW2Us+JlqS0/YYCbERnUn5PHtaALBYYfX7l7Jn6qzE2aAp
	 FUPpGVyjocnZ2OiaLJV9ubo5Xkx55GaEihRd18aQ8zyqJOddaarBNWP6oTI3ppNDoy
	 7pXAJcTtdSPqBsfLwV+ZTZiOsZpkwBtbuVpcIE6W48cAnvOvcPzed5uGecOgD1bh79
	 ZXKpp2Ep4x5EjbFfjBfHhFKn/jbhIRsxo0FEGxISnbbSqdEoZxCQRmRHCeZ9656xFK
	 QacxKHo14LPMHam3PSAiojBwKkAdH5nEzBdVSSww63/1TBEA/fpb2x3/OAsEOaPfTp
	 Ycpc24oC+xFUA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 39DAEF4008E;
	Mon, 22 Jun 2026 11:38:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 11:38:12 -0400
X-ME-Sender: <xms:5FY5agE1p7WcLSj3ACtDk9Qgm3PTdCgmzEzZvBNXghg0orV5zSbyAQ>
    <xme:5FY5agYOGA1GUfNMIqAK6VwI2toJKCgfc_KtOdpS0TalJKS0od-c_YI_7t7ySTbhQ
    Viq7teZjaiWGp9Lsfm2ry_l38KfRbr0_AYFpDMqY-Y1KRJTZlvp3g>
X-ME-Received: <xmr:5FY5ah1-KVv8f0rpHG3W-l6ErcDM6ktc2yBNJBqFu0PPMT9vJ9XgwWFtwg>
X-ME-Proxy-Cause: dmFkZTE1yAaDXhS8pNjst5KLDg3T0FBwcxDwJ8QMFA5Z8edu+Cn7xCutCu2FFknyQMbpDp
    NMsgSTo8kfxxQrsqN7iwgsXMP0foAsL0vTLRGibR40uvw1CUyxK5Qpo4h9Kx+/cXs9mezw
    0q9w3jNVbPb5aJcOeBWfZWKoHo0sJvQ06hhx8tm7o7Qc1oIfGYysn9s1iaTxxxUpyWIVzY
    4U2mnls/E2ZLKAxhjScnDiFaJ13dY0o9rapl7+DzIkwMCflJmq/Im8U7ASVgzpZZXP5UGQ
    31ixObCeMWoso/RSKyjIbZ5L912bxa966sAdd8vymQAogNQ2IZ/yJxBiBvUAcJri/8daEg
    0BUoXcd/3ayS2IL8WHNSGP3r4p1+vFFX4YHfsgi6kdZfbIfomHw7m2B1re0STyaijliCvn
    awzPufFAU4N3dGJKs1vD30UsxX8Vp0YYKBJJGpSxc+LoSAdktjsyRXsMWhSGfgnNH3H44b
    s9DZ+opfJX94feOGTF7puHyx/fAzu5HuxjBbk1DUvNTuaOScpH33nljvok7Zg7sXwGz8nl
    IaQrm8VuOnBDTy9ZDw2Gfm3MIm/Sb7MxVD/npDhlvM9vJJLpPSfMwtBYjx2xP4ciGaXu0H
    f1OiqVlpEWgOdPwtUQbEzVvALAFuRfuPYnDTCHOTC6FWJSfwS5GHPqkjXU7Q
X-ME-Proxy: <xmx:5FY5aod0w0qGe8QrjF_q0DXDH0Ro90yOaXcq2OjNy4oPXxYimuIDnA>
    <xmx:5FY5ajD1F23cFLE09J7eQd2FIqRWlayOTqr9DTILOlaBcHsjfFfzcw>
    <xmx:5FY5aq02jj8Tysf0S4eNdtAzA8d2zDSGd_xgtnKAfyyGKJiS8OHW0g>
    <xmx:5FY5ajO6V92ZF1LAUsU90qV4CCGOsbLA3zOX6IEYL1glpJO5W0dU0Q>
    <xmx:5FY5aofBY5vuK7Z3G-DCwbcnE-hhXIyqL1F58zfHZjljQViGCRAGgFqy>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 11:38:11 -0400 (EDT)
Date: Mon, 22 Jun 2026 08:38:10 -0700
From: Boqun Feng <boqun@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org,
	Sarah Emery <sarah.emery@canonical.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
Message-ID: <ajlW4oSzEqav6gxc@MacBook-0RXW5>
References: <ab2yd35rm6OgZUmb@gpd4>
 <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
 <ajQPAk_ALP-84obp@MacBook-0RXW5>
 <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z_15U7GssTOims1=J34CYSj=8CDE_di1kJYs5hE3=J53w@mail.gmail.com>

On Sat, Jun 20, 2026 at 05:25:25AM -0400, Emil Renner Berthing wrote:
> Quoting Boqun Feng (2026-06-18 17:30:10)
> > On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
> > > Quoting Boqun Feng (2026-03-20 23:29:16)
> > > > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > > > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > > > happen basically everywhere (including where a scheduler lock is held),
> > > > call_srcu() now needs to avoid acquiring scheduler lock because
> > > > otherwise it could cause deadlock [1]. Fix this by following what the
> > > > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > > > the work to start process_srcu().
> > > >
> > > > [boqun: Apply Joel's feedback]
> > > > [boqun: Apply Andrea's test feedback]
> > > >
> > > > Reported-by: Andrea Righi <arighi@nvidia.com>
> > > > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > > > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > > > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > > > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > > > Tested-by: Andrea Righi <arighi@nvidia.com>
> > > > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > >
> > > Thanks for the patch, which is now upstream as
> > > 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
> > >
> > > Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
> > > SoC both on the 7.0 and 7.1 kernels:
> > >
> >
> > By "single-core", is it only one CPU in that system?
> >
> > > https://esmil.dk/d1-7.0.txt
> > > https://esmil.dk/d1-7.1.txt
> > >
> 
> Yes, the SoC only has one CPU core capable of running Linux at least.
> 
> > From the callstack,
> >
> > [  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
> > [  243.021858] Workqueue: device_link_wq device_link_release_fn
> > [  243.027587] Call Trace:
> > [  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
> > [  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
> > [  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
> > [  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
> > [  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
> > [  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
> > [  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
> > [  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
> > [  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
> > [  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
> > [  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> > [  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
> > [  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
> > [  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
> > [  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
> > [  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
> > [  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18
> >
> > I will guess for some reasons the irq_work was missed or the IPI never
> > happened. Is it possible for you to enable trace points ipi_send_cpu and
> > ipi_entry to get more information?
> 
> I have to admit I've not used tracepoints before, but it seems like only
> ipi_send_cpu and ipi_send_cpumask is available on RISC-V.
> I've now added trace_event=ipi:* and tp_printk to the command line, and this

Thank you! Yeah, this is what I meant ;-)

> is what I get:
> https://esmil.dk/d1-7.0-2.txt
> 


[    0.071132] rcu: 	Max phase no-delay instances is 1000.
[    0.077837] ipi_send_cpu: cpu=0 callsite=irq_work_queue+0x22/0x4c callback=srcu_irq_work+0x0/0x58

Is this the last line you can see from your (serial?) console, or we are
missing a few more lines? Maybe it'll should the same hung task
messages?

The ipi_send_cpu message means RCU was able to send an IPI, now if there
is no ipi_handler between the send and the hung task, that would mean
the IPI was missed.

Regards,
Boqun

> Let me know if there is something I'm missing or something else I can do to help
> find the bug.
> 
> /Emil
