Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A02E091E;
	Tue, 24 Mar 2026 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380226; cv=none; b=jA2Ne2613AaiaRdAFB8rdTKZhV4lG3IArNNpnF/5+wUvyq4Cwmk6d5jpDcjMjh7/T3k+Ou7ozqmHhlWOMBUnKKi1mdcAt4jnoa6UikEUrWMdUU5AhRgLtBGStBu6ykMjHfESk/SYDUcJ7RfqRHDkzReY+shnjwitUP3FMq0n6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380226; c=relaxed/simple;
	bh=pyTWkPzTmoPe/rKOR3GREfnJWxphKIB8ZdV5GPRsrOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2gYfcWHY+lqPKFLuz8dpJAl6XUGsZItdN/HyJuzBCofHpXuqX39Fwam/9s4JWVpzVmrv3PGytoIJzFero2RIs58K5gShGyehqBwUkiAp0f7cmLB+3muLmqBzRgd+XL0B4oBbiy9u5ClL9L2qceQPJYtt7/YOWHg9Dt9T93N2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR32Q9Lz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR32Q9Lz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCAEC19424;
	Tue, 24 Mar 2026 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774380225;
	bh=pyTWkPzTmoPe/rKOR3GREfnJWxphKIB8ZdV5GPRsrOo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eR32Q9LzfhOG7VRUIyxoeR34Pzooa9ZRieuNHYi9O6x6tyqprvdKSok4lkFBMpam7
	 K/ukoY8CWdb8dsPPDEIEtWivrsfmpZVRyNyK9CWi6r/7FgrAM/GOOAnsjeKJOIcO0t
	 WykhkAukdeUPB3cvbLJz9PDNi5/TkK4VL0wpAaUeFvDsOGbW4of/0WpXqb010ImpsJ
	 RjOwLKRN8/idZvdlDmTOr5INM53hlavhNksqwfO+XXr4pqH1EGz/hhvmaOOds0/ESD
	 gkRJHwnmrqbl4DBDuYg+2V5z+ogkQITowA6aaffVO41aoDwv3/UpP7lp/KD4w8nSgz
	 0JW5ieAPvmCJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 47680CE08B3; Tue, 24 Mar 2026 12:23:43 -0700 (PDT)
Date: Tue, 24 Mar 2026 12:23:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Neeraj upadhyay <neeraj.iitr10@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start
 process_srcu()
Message-ID: <ace5b095-93d4-450a-bfc5-a40cfdf8993e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ab2yd35rm6OgZUmb@gpd4>
 <20260320222916.19987-1-boqun@kernel.org>
 <acJ1HRXomQhbTN4_@localhost.localdomain>
 <CAADnVQKcQNAGOeyt6SOAss0EK4k3A6jYp7-FvgpS0waO6pv-UA@mail.gmail.com>
 <acLLiKc5Ax586EuO@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acLLiKc5Ax586EuO@tardis.local>

On Tue, Mar 24, 2026 at 10:36:08AM -0700, Boqun Feng wrote:
> On Tue, Mar 24, 2026 at 07:56:44AM -0700, Alexei Starovoitov wrote:
> > On Tue, Mar 24, 2026 at 4:27 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > Le Fri, Mar 20, 2026 at 03:29:16PM -0700, Boqun Feng a écrit :
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
> > > I have the feeling that this problem should be solved at the BPF
> > > level. Tracepoints can fire at any time, in that sense they are like NMIs,
> > > and NMIs shouldn't acquire locks, let alone call call_rcu_*()
> > >
> > > BPF should arrange for delaying such operations to more appropriate contexts.
> > >
> > > I understand this is a regression trigerred by an RCU change but to me it
> > > rather reveals a hidden design issue rather than an API breakage.
> > 
> > You all are still missing that rcu_tasks_trace was developed
> > exclusively for bpf with bpf requirements.
> 
> I'm missing this for sure. But what would be a better design?
> 
> BPF is also calling normal RCU (via call_rcu()) as well, and I don't
> think we can say normal call_rcu() was designed exclusively for BPF.
> Plus BPF heavily uses irq_work to avoid deadlocks but irq_work_queue()
> itself has a tracepoint in it (trace_ipi_send_cpu()), so in theory you
> could hit a deadlock there too.

My fault, I should have seen this one coming.  But here I am.

> > Then srcu_fast was introduced and then it looked like that
> > task_trace can be replaced with srcu_fast and that's where the problems
> > discovered. So either task_trace need to be resurrected
> > or srcu_fast needs to be fixed.
> > Let's punt to bpf subsystem isn't an option.
> 
> I don't think we are suggesting that, i.e. "BPF should fix its own
> issue", at least myself was hoping that we can redesign the APIs that
> BPF relies on and make it clear that it's for BPF and we can in theory
> avoid all the deadlocks (we will probably have to make some primitives
> non-traceable) and BPF can use it combined with other general
> synchronization primitives.
> 
> The current approach seems to me that we just whack-a-mole when an issue
> happens, and it's not a systematic solution.
> 
> (It doesn't have to be a problem, it could be an opportunity ;-))

I am hoping that we don't have too many more moles to whack.  Famous
last words...  ;-)

							Thanx, Paul

> Regards,
> Boqun
> 
> > At this rate we will have rcu_bpf. Which rcu_tasks_trace effectively was.
