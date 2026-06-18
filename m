Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881A301708
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796615; cv=none; b=GcTzULG+oxKbbCEBFVwqjaIidXd1YlbBQgK6qgY2WWWuCv5CIFymJzBjCnWY8eJxOQ49f+VC4d5k/n2PLk8cO6dIM6w5R28ivJiKqP/pxWZbt4Jde0HGvZWkgjuPlbhls3lIafWp5FYBxpfP7PLNRhGrFw5FQC67dhyK9sqQVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796615; c=relaxed/simple;
	bh=F0XHc5tffhJfH2pxJrKh1dRi5hlbamYiIhKbtvvu7wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhYifxmtI9LWgfY0wQaTWNF2y1ySc/cshd6XOsTGXQWFyDhWhhapT1sarAnaWVRdCWWrwCHsDDuDC3fH9f3AbtN4IuzMNOsSlYgXmh/aituSVsHbDlXOFtNe+tH3A46hGOuKjrjgCxbbeXIvA21zJjKq8JNI9hlEGSNYV6YFpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6bhc/hS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6bhc/hS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723B01F00A3A;
	Thu, 18 Jun 2026 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796613;
	bh=G0BFgogMIJaXJGDiQZV8U4+rZmptmkIJn2CptvNFtEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T6bhc/hS1MHBzVVZKzC7XVkLTDaM/TdhjMUMJJKeAt5stfx0C67loUVDyLfaG+GHC
	 zr86q5BW/me0499BiyTCsfTsyNYeyYxt89bfS7udF299hBDWrAA9fVyo9VVFtyNuGS
	 QmvblVaaC5mcxb0CE9R3Go+IR2UuvXbpf4MZKnfnTedzEih14wPH8nvsa1HbIKABQS
	 q8TcyohO8D7s69hVgfuGxGu37Rg+QPEgl0zCDepNrqp1PDwuaiYUZDC41ENrvLTqv1
	 lYa9BJWGhHN8KfjSYFdKf98FCZVHgoR1zVlXXpcKApRUbYU21xWVV/MdtdAPjnJQs1
	 m0ajXT/RWrJ8g==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id A31B3F40082;
	Thu, 18 Jun 2026 11:30:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 11:30:12 -0400
X-ME-Sender: <xms:BA80asNdm4zfeiaBzam79lJw3tcCGaYgs6S-Gq28UcCJ6cAzM812VQ>
    <xme:BA80an31-XoElJPaZ8UAjINBag02b3TjWULPS6FWTiqNfw2-B9PYHIE8etYHjDTZo
    5f8vjolCza9H5pMNf3ZdkTxgbWhPtASbI5iIjmQvBPHYykNv53LIA>
X-ME-Received: <xmr:BA80ar0chNeqDGcHwK667pBFihJT8iZUrsiS8Q8ehieYN4o1XvogBxdHf1Q21rWiEpTKFC77PGYkd7Ex_S6atJCsG7FZ64KL>
X-ME-Proxy-Cause: dmFkZTFMbSsA9J0WA0JULckOoW50HX4x9J7CjHhu7BPf2uJHl9tL6yhfYmd3fMQmaZnC7G
    Tr/s4dTY1dimqtLUA/YZxW5i13LqojtflIgd4qePbDl9cbd7L+fsC5SiCXaYmv9BDlIyJW
    6x0jQMH9i+a38GTWd/jiHTQw7rOWqdzDIc0PDwuy3TYnzwSiQcSsQ9Fz2xWGaA5zW2aIae
    wdTncdObWpOmv3iy8Ty7W/8VRKBfVNtIbFDT4nsW+sqww6ua5ZkM+1cqv67HjSRf5CE+Wd
    8HZS1bExz/22zkg8ZXi3O2ei9xVRhG0mGUwNJQrfNNkrbXDVloyOHB1jdcg9c5iDdFZSH8
    zGFHXGzLSKdX2E2XN5Mec2ykR8p1BWTmzA+P2zaoPD0E6JNH+0njNk0H0ihMZpJ71GaA9x
    SHeygttBoPEDOdF0HVLZglB73bp/I1cg/I+jym6LvZfaB1xPoCyob4axdlBxF+JCJzaEfO
    Fv4prp0UhhgnsEunGdDQCOJ+CiublHU2jnQcYkxyZ1tb17y59pZr9ef3VeMMisAFtDQR0H
    LdyFEiWrC0/xGWPRikpHJ3d8dLPoNt0urnEkFD/KZczA8pdIrsQqsubBlOgd5rdrsSkt0q
    ibCxLV/X3NeKLZjD4W663RcLECpAd4Hyf0v/0xwiQpjKunV7/zuSiCsJqJWw
X-ME-Proxy: <xmx:BA80al9ZUbW6v9VLLraQyxNt3khO62Ln66VEiaRbEuNuQVDkfIPgeg>
    <xmx:BA80anZOlhjWzK85EIMgg7DhiQnm2GiBrXFqd1muzhy0amkZF__HRA>
    <xmx:BA80akxWuH7DqRvmMJ6Buave3_hderdbGJzDjOaTHafOLPf3F-qdgw>
    <xmx:BA80al-_gIOcs3PcdKvxsDpgrNkdx9z4bu7MlsuH8MvMv7u6Nv9aRw>
    <xmx:BA80agxssDfbSnCBIzh0f27rlH-WnzVstuKAjp3xbiCvX7EBfH-A-hXo>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 11:30:11 -0400 (EDT)
Date: Thu, 18 Jun 2026 08:30:10 -0700
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
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
Message-ID: <ajQPAk_ALP-84obp@MacBook-0RXW5>
References: <ab2yd35rm6OgZUmb@gpd4>
 <20260320222916.19987-1-boqun@kernel.org>
 <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>

On Thu, Jun 18, 2026 at 08:11:36AM -0500, Emil Renner Berthing wrote:
> Quoting Boqun Feng (2026-03-20 23:29:16)
> > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> > happen basically everywhere (including where a scheduler lock is held),
> > call_srcu() now needs to avoid acquiring scheduler lock because
> > otherwise it could cause deadlock [1]. Fix this by following what the
> > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > the work to start process_srcu().
> >
> > [boqun: Apply Joel's feedback]
> > [boqun: Apply Andrea's test feedback]
> >
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Tested-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> 
> Thanks for the patch, which is now upstream as
> 7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")
> 
> Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
> SoC both on the 7.0 and 7.1 kernels:
> 

By "single-core", is it only one CPU in that system?

> https://esmil.dk/d1-7.0.txt
> https://esmil.dk/d1-7.1.txt
> 

From the callstack,

[  243.002818] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  243.010681] task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
[  243.021858] Workqueue: device_link_wq device_link_release_fn
[  243.027587] Call Trace:
[  243.030079] [<ffffffff80745b66>] __schedule+0x232/0x530
[  243.035365] [<ffffffff80745e82>] schedule+0x1e/0x94
[  243.040298] [<ffffffff8074aa7a>] schedule_timeout+0x6e/0xa8
[  243.045929] [<ffffffff8004d6a0>] wakeup_preempt+0x8c/0x98
[  243.051380] [<ffffffff80746aee>] wait_for_completion+0x3a/0xb0
[  243.057267] [<ffffffff80087226>] __synchronize_srcu.part.0+0x4e/0x60
[  243.063712] [<ffffffff80084414>] rcu_tasks_get_gp_data+0xc/0x10
[  243.069699] [<ffffffff80490898>] device_link_release_fn+0x14/0x80
[  243.075850] [<ffffffff8003dbd0>] process_one_work+0xf8/0x1c8
[  243.081583] [<ffffffff8003e282>] worker_thread+0x11a/0x254
[  243.087127] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
[  243.092755] [<ffffffff8003e164>] rescuer_thread+0x3a0/0x3a4
[  243.098381] [<ffffffff8004499e>] kthread+0xbe/0xe4
[  243.103231] [<ffffffff8001349e>] ret_from_fork_kernel+0x6/0xd0
[  243.109127] [<ffffffff800517a8>] schedule_tail+0x8/0xac
[  243.114410] [<ffffffff800448dc>] kthreads_online_cpu+0x0/0x4
[  243.120121] [<ffffffff8074be0a>] ret_from_fork_kernel_asm+0x12/0x18

I will guess for some reasons the irq_work was missed or the IPI never
happened. Is it possible for you to enable trace points ipi_send_cpu and
ipi_entry to get more information?

> Reverting this patch seems to fix the issue although it then breaks when loading
> modules which is can be fixed by reverting:
> d6e152d905bd ("clockevents: Prevent timer interrupt starvation")
> 
> This might be a side-effect of reverting this patch though.
> 

I'm not so sure about this, i.e. you might have *two* problems :(

Regards,
Boqun

> We'd really like to continue support for this SoC on the 7.0 kernel, but since
> this patch is a bugfix just shippping the revert doesn't sound appealing.
> So some guidance would be much appreciated, thanks!
> 
> /Emil
