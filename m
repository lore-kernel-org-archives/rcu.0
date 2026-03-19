Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB2393DEE;
	Thu, 19 Mar 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951253; cv=none; b=ihoiq9b9wfuc1570+ptLIp9pGH0p7jrfpLkdqmcet1QpfvB/CA1m2UYqPEYTS/cbRkzCELdQ+oHrl0nCiOUgbJOibyCeiOftWwJ6V1lREZuP3Hrz2sVSvXByXbdjubfe/qbtlzIx5X63fRBIcN0JRJQHweny1w53xEY5UIhhchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951253; c=relaxed/simple;
	bh=ffkv/+bdWwNbwdoOHkX7FajyW0d9F9DZCOd0v7uK6/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr07j4YG+gWtqi28ygyd3UlAFCrIYJ+jpfxdfzvK3AjVuoGmpku/zHCG5G6MRcm2XCSuN0sS+r87Unlig31DMoFg7NyGz+NDVrOTTKd61nm261wVOQ+x/bczsgbIVcPkod/jul91aJ6JN88M8xzSRZCocCkKBkLEXRKoCF7D2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzHwSYHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzHwSYHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E292C2BCAF;
	Thu, 19 Mar 2026 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773951252;
	bh=ffkv/+bdWwNbwdoOHkX7FajyW0d9F9DZCOd0v7uK6/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzHwSYHMO7I/Tdi66X2nC+vUw991QerA90iMAKSaugLisy1oafZL+5+PKlMwFEoru
	 MlzOZUUSf+Phkpp61XwAqSzNEVIUtSazpR+vX90dK1OaollosCZyEiAM2x7zy3BlIv
	 SdDlKJ0V1wg556sAG4eLPS7GIw+EC05A/uRv16y28LCA8prXpnAOvymq29zDfHnPEe
	 wH3b87NePjCI6YeEpxtMZOs6/zk5ajs3SqmpDJK7bQCTQDd7Vk2IgLQK9GhulWOiDZ
	 EbwBO7Xg8nM/4P3QkMLkkiw+FUK2G37suZI35wrCkKZNBUAzt5iM5HK3uJRGMBTG8z
	 cPfyXWWcrhnTQ==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 44A00F40087;
	Thu, 19 Mar 2026 16:14:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 19 Mar 2026 16:14:10 -0400
X-ME-Sender: <xms:Elm8aUvWMUrK071clNzOOydNGmgHb6-O0xYabKye3k9qAY2omrf_MQ>
    <xme:Elm8ab20GHydRUNIxKTeVJKS0jR-cjuPSkl66QAF1KjcI0I1181TwrTOzH1Lia-uV
    EaAfOtFnjeJMUME9WNM3PljuxDGTbXS05TN7HhVMmceAH8n6JU6pA>
X-ME-Received: <xmr:Elm8aV5i6TnECFldpl_gN7yw0v8aLagjYHXRxvtQVK4sPpeQU_Q_9f173WbJQKh9vPK5cJ8SaWQrDPXJrD_OLw8vOY7hYevA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgv
    mhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslhhinhhuth
    hrohhnihigrdguvgdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdr
    ihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Elm8aSV6zqSEH3vdRvfS8G3Jqgt9PA2unEfEYTCu1yefgrt9MKwuTQ>
    <xmx:Elm8adhE7vHMgyxJL8xkENlYxCVE1iNE5FPvlWiDEc90BsSjbDMJRA>
    <xmx:Elm8aSfTFw-BQdNO1yOAjlxF9ZjxomX_V4-9Ihp1-N0JGPXPCGEbxw>
    <xmx:Elm8ac1hsa8556ve4vweKjEzVFPKIhkgqX0u4ALklt3NAQFSjaEqDg>
    <xmx:Elm8aeqh8nGLp2HHmw5NFtzGQXrQtw0EmxDcXxIqYEnI6hNIqo7s5Vfk>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 16:14:09 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:14:08 -0700
From: Boqun Feng <boqun@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abxZEE4SAMkNEleq@tardis.local>
References: <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>

On Thu, Mar 19, 2026 at 07:41:06PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, 19 Mar 2026 at 18:27, Boqun Feng <boqun@kernel.org> wrote:
> >
> > On Thu, Mar 19, 2026 at 05:59:40PM +0100, Kumar Kartikeya Dwivedi wrote:
> > > On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
> > > >
> > > > On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> > > > > On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> > > > > > On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > > > > > > Please just use the queue_delayed_work() with a delay >0.
> > > > > > >
> > > > > >
> > > > > > That doesn't work since queue_delayed_work() with a positive delay will
> > > > > > still acquire timer base lock, and we can have BPF instrument with timer
> > > > > > base lock held i.e. calling call_srcu() with timer base lock.
> > > > > >
> > > > > > irq_work on the other hand doesn't use any locking.
> > > > >
> > > > > Could we please restrict BPF somehow so it does roam free? It is
> > > > > absolutely awful to have irq_work() in call_srcu() just because it
> > > > > might acquire locks.
> > > > >
> > > >
> > > > I agree it's not RCU's fault ;-)
> > > >
> > > > I guess it'll be difficult to restrict BPF, however maybe BPF can call
> > > > call_srcu() in irq_work instead? Or a more systematic defer mechanism
> > > > that allows BPF to defer any lock holding functions to a different
> > > > context. (We have a similar issue that BPF cannot call kfree_rcu() in
> > > > some cases IIRC).
> > > >
> > > > But we need to fix this in v7.0, so this short-term fix is still needed.
> > > >
> > >
> > > I don't think this is an option, even longer term. We already do it
> > > when it's incorrect to invoke call_rcu() or any other API in a
> > > specific context (e.g., NMI, where we punt it using irq_work).
> > > However, the case reported in this thread is different. It was an
> > > existing user which worked fine before but got broken now. We were
> > > using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
> > > is held before, so the conversion underneath to call_srcu() should
> > > continue to remain transparent in this respect.
> > >
> >
> > I'm not sure that's a real argument here, kernel doesn't have a stable
> > internal API, which allows developers to refactor the code into a saner
> > way. There are currently multiple issues that suggest we may need a
> > defer mechanism for BPF core, and if it makes the code more easier to
> > reason about then why not? Think about it like a process that we learn
> > about all the defer patterns that BPF currently needs and wrap them in a
> > nice and maintainable way.
> 
> This is all right in theory, but I don't understand how your
> theoretical deferral mechanism for BPF will help here in the case
> we're discussing, or is even appealing.
> 
> How do we decide when to defer? Will we annotate all locks that can be
> held by RCU internals to be able to check if they are held (on the
> current cpu, which is non-trivial except by maintaining a held lock
> table, testing the locked bit is too conservative), and then deferring
> the call_srcu() from the caller in BPF? What if you gain new locks? It
> doesn't seem practical to me. Plus it pushes the burden of detection
> and deferral to the caller, making everything more complicated and
> error-prone.
> 

My suggestion would be: deferring all call_srcu()s that in BPF
core. For new locks, I think every lock usage in BPF core should be
carefully audited because that's very similar to NMI. It's not hard to
trade BPF as a different context and let lockdep detect lock mis-usage,
similar as what we do for interrupts and NMIs.

Basically, if we want to use some synchronization in BPF core:

1. If it's re-entrant safe, then go ahead and use it.
2. If it has a lock, but can be deferred, use the general BPF defer
   mechanism to defer the operation.
3. If it cannot be deferred, it has to change or add a new variant that
   support either 1 or 2.

i.e. a universal solution.

> Also, any unconditional deferral in the caller for APIs that can "hold
> locks" to avoid all this is not without its cost.
> 
> The implementation of RCU knows and can stay in sync with those
> conditions for when deferral is needed, and hide all that complexity
> from the caller. The cost should definitely be paid by the caller if
> we would break the API's broad contract, e.g., by trying to invoke it

The thing is, lots of the synchronization primitives existed before BPF,
and they were not designed or implemented with "BPF safe" in mind, and
they could be dragged into BPF core code path if we begin to use them.
For example, irq_work may be just "happen-to-work" here, or there is a
bug that we are missing. It would be rather easier or clearer if we
design a dedicate defer mechanism with BPF core in mind, and then we use
that for all the deferrable operations.

Regards,
Boqun

> in NMI which it is not supposed to run in yet, in that case we already
> handle things using irq_work. Anything more complicated than that is
> hard to scale. All of this may also change in the future where we
> support call_rcu_nolock() to make it work everywhere, and only defer
> when we detect reentrancy (in the same or different context).
> 
> 
> 
> >
> > Regards,
> > Boqun
> >
> > > > Regars,
> > > > Boqun
> > > >
> > > > > > Regards,
> > > > > > Boqun
> > > > > >
> > > > > Sebastian
