Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8E3CE48B
	for <rcu@vger.kernel.org>; Fri, 20 Mar 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022396; cv=none; b=tCblCVNTuIlsyRS0Yq2CMSbYBp1KpC4vuzDYAOA/lcWfvCui5GFMmJ5ejIQR/0L+UNJVOQrPH+zQjcfhfat5zJYb9vnt8IN2FTPUrEpANRSeZHOA0Vh/WymLhyqy7RXSdCjjUrJK+ewr80DgOcG+8IvjDg+ppd9looPpTumtV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022396; c=relaxed/simple;
	bh=SZQDr54yVRfV4wwz6bNgifDNdW6PQuYG77hQb2kbP8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/QMjhtCH3nG6idMml/4pOBGSJaiWd6g4P4RFt8PoxyIBAtHtHQUI5MmLeXXCMWHZVab6e+5mr5qzu9Z3Tcefztg9ActJVtGOebYUNreaKU9KYtQjbE3jdApizMrdMo6xgNjjZZCxn8tVVhYKofTZJOSK/TKKUGqeDwwcMIhcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXg8jkgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXg8jkgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F43C4AF0B;
	Fri, 20 Mar 2026 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774022396;
	bh=SZQDr54yVRfV4wwz6bNgifDNdW6PQuYG77hQb2kbP8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXg8jkgRdXGbQweqGgibtk08wfHzFTwOBN9HQp5nheUoA5e/AgpNXSrh8xBfkDu/D
	 dacEhBs4Oud+/O8RVyUrrZ5AvNxxGiMzSXHcLvV7N2hAd49hU8qAWW8kzniZ9i8FGp
	 8zJFxp0Acq+lW1f/CrIgBxBciVw/9UEy9Jg72uja7CNiZKg7iJ7yVlYufTQ/+/j9iS
	 0mmeg+Uby1MjUccNjynWLNN+zri8ogB8ijQBp6sW5dM4aQgLXfNu5wbE2eAn0k7fHr
	 r2VlauXlMlfplYSEsnOCFKUSpSjTQ2lwytIfZ/o2YMGJUAByPsDevRSfwqDHDjIO0y
	 7OdnpXE02SRpw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1C703F4008D;
	Fri, 20 Mar 2026 11:59:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 11:59:55 -0400
X-ME-Sender: <xms:-269aY6IRyzbR8kxGFkpvYeIO-pxGi1CiZx8VDRywKH2R_bwl-z5zA>
    <xme:-269aUTNQa24figJ8qTNMVMaGckA6X0CltHE8hokyRjQNPANeSszVIlxeEdFFCRAb
    dX08X9qum0VGXKnW7YXd8W15HP8EZ4y4vOJaroNCCgov0a6w_vCQg>
X-ME-Received: <xmr:-269adkd5sKxqMBFIfAKcy9TZpbb48JSJaPKRzfr6VAqBwp9XX6KMg--7hTOfDCH7JyAhPCclPWN_Fxr7wAklGfkKdVpexVj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    euieeileeffeeuhfelgeevjeeltdejveethffhteffvdekuefhgfffhfeugefhudenucff
    ohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdduieejtdelkeegjeduqddujeejkeehheehvddqsghoqhhunheppehkvg
    hrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphht
    thhopehmvghmgihorhesghhmrghilhdrtghomhdprhgtphhtthhopegsihhgvggrshihse
    hlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdrihhithhruddtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-269aYTPPojXexj_ywjZlX18buIf4vvuzNIj-Drga_p0jX7Nw8XHlg>
    <xmx:-269aUv4Cct6qa_OmdkLm9Y317Ot_lrHqbQ-haivqw4Jd-MxS71Y-g>
    <xmx:-269aR6NIIstW6XCEsKbgOKdTL6KqmvpmtN-GpMwZ1EvinAnzc9d7w>
    <xmx:-269afh5MPh_XfDh7_Lad8ZfTTNk0Esy1dORHCEBe86QfYpPbUlyYQ>
    <xmx:-269aTmOahFyN4dKqSFOYIZB6G3ZPWDfbn3xqeoLSFXa8_F4SGPnbdTh>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 11:59:53 -0400 (EDT)
Date: Fri, 20 Mar 2026 08:59:52 -0700
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <ab1u-AuqIbJakUYW@tardis.local>
References: <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
 <abxfBZ89wIJILuom@tardis.local>
 <c391f8b9-a168-4235-aa7b-6902b4f07002@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c391f8b9-a168-4235-aa7b-6902b4f07002@paulmck-laptop>

On Fri, Mar 20, 2026 at 08:34:41AM -0700, Paul E. McKenney wrote:
> On Thu, Mar 19, 2026 at 01:39:33PM -0700, Boqun Feng wrote:
> > On Thu, Mar 19, 2026 at 04:21:45PM -0400, Joel Fernandes wrote:
> > > On 3/19/2026 4:14 PM, Boqun Feng wrote:
> > > > On Thu, Mar 19, 2026 at 07:41:06PM +0100, Kumar Kartikeya Dwivedi wrote:
> > > >> On Thu, 19 Mar 2026 at 18:27, Boqun Feng <boqun@kernel.org> wrote:
> > > >>>
> > > >>> On Thu, Mar 19, 2026 at 05:59:40PM +0100, Kumar Kartikeya Dwivedi wrote:
> > > >>>> On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
> > > >>>>>
> > > >>>>> On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> > > >>>>>> On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> > > >>>>>>> On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > > >>>>>>>> Please just use the queue_delayed_work() with a delay >0.
> > > >>>>>>>>
> > > >>>>>>>
> > > >>>>>>> That doesn't work since queue_delayed_work() with a positive delay will
> > > >>>>>>> still acquire timer base lock, and we can have BPF instrument with timer
> > > >>>>>>> base lock held i.e. calling call_srcu() with timer base lock.
> > > >>>>>>>
> > > >>>>>>> irq_work on the other hand doesn't use any locking.
> > > >>>>>>
> > > >>>>>> Could we please restrict BPF somehow so it does roam free? It is
> > > >>>>>> absolutely awful to have irq_work() in call_srcu() just because it
> > > >>>>>> might acquire locks.
> > > >>>>>>
> > > >>>>>
> > > >>>>> I agree it's not RCU's fault ;-)
> > > >>>>>
> > > >>>>> I guess it'll be difficult to restrict BPF, however maybe BPF can call
> > > >>>>> call_srcu() in irq_work instead? Or a more systematic defer mechanism
> > > >>>>> that allows BPF to defer any lock holding functions to a different
> > > >>>>> context. (We have a similar issue that BPF cannot call kfree_rcu() in
> > > >>>>> some cases IIRC).
> > > >>>>>
> > > >>>>> But we need to fix this in v7.0, so this short-term fix is still needed.
> > > >>>>>
> > > >>>>
> > > >>>> I don't think this is an option, even longer term. We already do it
> > > >>>> when it's incorrect to invoke call_rcu() or any other API in a
> > > >>>> specific context (e.g., NMI, where we punt it using irq_work).
> > > >>>> However, the case reported in this thread is different. It was an
> > > >>>> existing user which worked fine before but got broken now. We were
> > > >>>> using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
> > > >>>> is held before, so the conversion underneath to call_srcu() should
> > > >>>> continue to remain transparent in this respect.
> > > >>>>
> > > >>>
> > > >>> I'm not sure that's a real argument here, kernel doesn't have a stable
> > > >>> internal API, which allows developers to refactor the code into a saner
> > > >>> way. There are currently multiple issues that suggest we may need a
> > > >>> defer mechanism for BPF core, and if it makes the code more easier to
> > > >>> reason about then why not? Think about it like a process that we learn
> > > >>> about all the defer patterns that BPF currently needs and wrap them in a
> > > >>> nice and maintainable way.
> > > >>
> > > >> This is all right in theory, but I don't understand how your
> > > >> theoretical deferral mechanism for BPF will help here in the case
> > > >> we're discussing, or is even appealing.
> > > >>
> > > >> How do we decide when to defer? Will we annotate all locks that can be
> > > >> held by RCU internals to be able to check if they are held (on the
> > > >> current cpu, which is non-trivial except by maintaining a held lock
> > > >> table, testing the locked bit is too conservative), and then deferring
> > > >> the call_srcu() from the caller in BPF? What if you gain new locks? It
> > > >> doesn't seem practical to me. Plus it pushes the burden of detection
> > > >> and deferral to the caller, making everything more complicated and
> > > >> error-prone.
> > > >>
> > > > 
> > > > My suggestion would be: deferring all call_srcu()s that in BPF
> > > > core. [...]
> > > 
> > > isn't one of the issues is that BPF is using call_rcu_tasks_trace() which is now
> > > internally using call_srcu? So whether other parts of BPF use call_srcu() or
> > 
> > I was talking about the long term solution in that thread ;-)
> > 
> > Short-term, yes the switching from call_rcu_tasks_trace() to call_srcu()
> > is the cause the issue, and we have the lockdep report to prove that. So
> > in order to continue the process of switching to SRCU for BPF, we need
> > to restore the behavior of call_rcu_tasks_trace() in call_srcu().
> > 
> > > not, the issue still stands AFAICS.
> > > 
> > 
> > In an alternative universe, BPF has a defer mechanism, and BPF core
> > would just call (for example):
> > 
> >     bpf_defer(call_srcu, ...); // <- a lockless defer
> > 
> > so the issue won't happen.
> 
> In theory, this is quite true.
> 
> In practice, unfortunately for keeping this part of RCU as simple as
> we might wish, when a BPF program gets attached to some function in
> the kernel, it does not know whether or not that function holds a given
> scheduler lock.  For example, there are any number of utility functions
> that can be (and are) called both with and without those scheduler
> locks held.  Worse yet, it might be attached to a function that is
> *never* invoked with a scheduler lock held -- until some out-of-tree
> module is loaded.  Which means that this module might well be loaded
> after BPF has JIT-ed the BPF program.
> 

Hmm.. maybe I failed to make myself more clear. I was suggesting we
treat BPF as a special context, and you cannot do everything, if there
is any call_srcu() needed, switch it to bpf_defer(). We should have the
same result as either 1) call_srcu() locklessly defer itself or 2) a
call_srcu_lockless().

Certainly we can call_srcu() do locklessly defer, but if it's only for
BPF, that looks like a whack-a-mole approach to me. Say later on we want
to use call_hazptr() in BPF for some reason (there is hoping!), then we
need to make it locklessly defer as well. Now we have two lockless logic
in both call_srcu() and call_hazptr(), if there is a third one, we need
to do that as well. So where's the end?

The lockless defer request comes from BPF being special, a proper way to
deal with it IMO would be BPF has a general defer mechanism. Whether
call_srcu() or call_srcu_lockless() can do lockless defer is
orthogonal.


BTW, an example to my point, I think we have a deadlock even with the
old call_rcu_tasks_trace(), because at:

https://elixir.bootlin.com/linux/v6.19.8/source/kernel/rcu/tasks.h#L384

We do a:

	mod_timer(&rtpcp->lazy_timer, rcu_tasks_lazy_time(rtp));

which means call_rcu_tasks_trace() may acquire timer base lock, and that
means if BPF was to trace a point where timer base lock is held, then we
may have a deadlock. So Now I wonder whether you had any magic to avoid
the deadlock pre-7.0 or we are just lucky ;-)


See, without a general defer mechanism, we will have a lot of fun
auditing all the primitives that BPF may use.

> So we really do need to make some variant of call_srcu() that deals
> with this.
> 
> We do have some options.  First, we could make call_srcu() deal with it
> directly, or second, we could create something like call_srcu_lockless()
> or call_srcu_nolock() or whatever that can safely be invoked from any
> context, including NMI handlers, and that invokes call_srcu() directly
> when it determines that it is safe to do so.  The advantage of the second
> approach is that it avoids incurring the overhead of checking in the
> common case.
> 

Within the RCU scope, I prefer the second option.

Regards,
Boqun

> Thoughts?
> 
> 						Thanx, Paul
> 
> > > I think we have to fix RCU tasks trace, one way or the other.
> > > 
> > > Or did I miss something?
> > > 
> > 
> > No I don't think so ;-)
> > 
> > Regards,
> > Boqun
> > 
> > > thanks,
> > > 
> > > --
> > > Joel Fernandes
> > > 
> > > 
> > > 
