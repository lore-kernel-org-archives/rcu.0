Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F13D5258;
	Tue, 24 Mar 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373772; cv=none; b=XbKVOSlPdwfn/4IxZBGBnv3DKPbm9cu8k6JDugeemutHOcU5W/wbwXU4CasIzPkp4/vTfldaxndaKp+Fl/+cKdePL4tWO91QkoUUfW++kmLYDBP/YM78ZJo+kf8/8gW368LyMRf1cz6fq6fKxQcS55qttANPY4h9Jft0x2u4K/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373772; c=relaxed/simple;
	bh=V0ZecmU2AMKGKl2aDUn7f5w7I0jXyQ7cAYdWe2OxXNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF8gPBbDx+GEgB/nExynWhYp28O5USSp4dXW59b86br/ZxTsJ9I6NYjLUUvT1Mk555dQ61bFM5dnyjCU6uyGn008wgrejiqNwr3k3CpJZIdqkUib1qFebknmjUn0dLCVs6xBy/4cT9pyC38ZSQJk2XtidEwjiQIpxUMIw1zKjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqD+XJ73; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqD+XJ73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEC4C19424;
	Tue, 24 Mar 2026 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774373771;
	bh=V0ZecmU2AMKGKl2aDUn7f5w7I0jXyQ7cAYdWe2OxXNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqD+XJ73xB8JtsFAPyFuDvX555CWAdod90jitRAdKE7OnWuHYupTqc4wbCLmgFMwf
	 +ColFY7MorE4jl30Mv8pu4bEK21R+tEDnDMknh3xts21hPBUvaKFYMaWUJYHqWb/gv
	 kySyQ10tEl006wZ8lItQYsZLPbfj2fCgMF+YaH9E0pSQQrPshdMsbwjqyWJGlKQgCS
	 Oxo9B/OwjpivSdZITZOZjEbruO52crB4gzEj4g0a9n/gv8FUInVdk40pT6zI7ezAsI
	 VOjg+e2xdzmHiZri7kQJq1rooVW8nOQRbbIQQVJauG4KTxf2alJPmcJHwLVUcyd6Uc
	 mAF/ftZUpWEgA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 53E46F4006C;
	Tue, 24 Mar 2026 13:36:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 13:36:10 -0400
X-ME-Sender: <xms:isvCaWDBsB9cusrSLVkCvA6toFQ8-IU_e1bdQuKFMR-ElZGKXR2L3g>
    <xme:isvCaSAyYJOWQeLR6yziveMgCZ0hHLcsYMBDBFleguimalVq3ahroe3kPIgw1A9_n
    rPtEgC2ssnmOc1MHUblP0aH5MsUJ_2APh7Oy8hF-gixAybzXw_EULk>
X-ME-Received: <xmr:isvCaXPwI0XbT06JZ1gzHPvyNIZaM0yvf4Bswk6xy_-9AhnEfttHIfylZIx1H54cfthoiPj767WU_s21kgNrAhK9Bp7sfTIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epteelkeejledtledtvefhhedtfeeghfeuhfeljeevffelgeeltefhieefvdeuteehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdduieejtdelkeegjeduqddujeejkeehheehvddqsghoqhhunheppehkvg
    hrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtoh
    hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvmhig
    ohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:isvCacNlGCs6Ztfvn0dw6df8MLVbVKITUDIyJ5rGY17U3-xL-Vf-3w>
    <xmx:isvCabshvcuPrvyrdLT3KaCRoND_bwUP0WSvNK78h-z01Qno8uMCYw>
    <xmx:isvCaR9-2Dj2RqErkLWg0j5zkspnW1Gujgdgbmu_nwd1nvgisik82Q>
    <xmx:isvCaXEkLD4TME-kg2ab2JHf_Yv9aXAINfz5nNFZ8qDYxyxJRCR03w>
    <xmx:isvCaYTJa1NzPHCFU1PBQlYKiFw_n4sFQ_09T37qbFZwGj_BMOH0kt5_>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 13:36:09 -0400 (EDT)
Date: Tue, 24 Mar 2026 10:36:08 -0700
From: Boqun Feng <boqun@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <acLLiKc5Ax586EuO@tardis.local>
References: <ab2yd35rm6OgZUmb@gpd4>
 <20260320222916.19987-1-boqun@kernel.org>
 <acJ1HRXomQhbTN4_@localhost.localdomain>
 <CAADnVQKcQNAGOeyt6SOAss0EK4k3A6jYp7-FvgpS0waO6pv-UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKcQNAGOeyt6SOAss0EK4k3A6jYp7-FvgpS0waO6pv-UA@mail.gmail.com>

On Tue, Mar 24, 2026 at 07:56:44AM -0700, Alexei Starovoitov wrote:
> On Tue, Mar 24, 2026 at 4:27 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Fri, Mar 20, 2026 at 03:29:16PM -0700, Boqun Feng a écrit :
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
> > I have the feeling that this problem should be solved at the BPF
> > level. Tracepoints can fire at any time, in that sense they are like NMIs,
> > and NMIs shouldn't acquire locks, let alone call call_rcu_*()
> >
> > BPF should arrange for delaying such operations to more appropriate contexts.
> >
> > I understand this is a regression trigerred by an RCU change but to me it
> > rather reveals a hidden design issue rather than an API breakage.
> 
> You all are still missing that rcu_tasks_trace was developed
> exclusively for bpf with bpf requirements.

I'm missing this for sure. But what would be a better design?

BPF is also calling normal RCU (via call_rcu()) as well, and I don't
think we can say normal call_rcu() was designed exclusively for BPF.
Plus BPF heavily uses irq_work to avoid deadlocks but irq_work_queue()
itself has a tracepoint in it (trace_ipi_send_cpu()), so in theory you
could hit a deadlock there too.

> Then srcu_fast was introduced and then it looked like that
> task_trace can be replaced with srcu_fast and that's where the problems
> discovered. So either task_trace need to be resurrected
> or srcu_fast needs to be fixed.
> Let's punt to bpf subsystem isn't an option.

I don't think we are suggesting that, i.e. "BPF should fix its own
issue", at least myself was hoping that we can redesign the APIs that
BPF relies on and make it clear that it's for BPF and we can in theory
avoid all the deadlocks (we will probably have to make some primitives
non-traceable) and BPF can use it combined with other general
synchronization primitives.

The current approach seems to me that we just whack-a-mole when an issue
happens, and it's not a systematic solution.

(It doesn't have to be a problem, it could be an opportunity ;-))

Regards,
Boqun

> At this rate we will have rcu_bpf. Which rcu_tasks_trace effectively was.
