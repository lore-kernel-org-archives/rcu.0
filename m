Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0893A63F6
	for <rcu@vger.kernel.org>; Thu, 19 Mar 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952777; cv=none; b=qE6BiQF5w05CKcNz4pBGu2qvw0QcKHpVj0nZAm28fZ7YvB9bJunbIlNTuZ3lt6TLz8q2k5L+NhaJKruyOiPLNOA4ydvQ7PCqIgCjSJzBNYOseEfGIwB1cuNyCPu3+7vmdlJlTEFlKyiKQ6VkBxWX4iUEnfURrpGUsB0JovGtoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952777; c=relaxed/simple;
	bh=gSiDhWKaiD7adHK7MF1gYzB6wyCyr2ktTQkttJ6PAiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/4fcxeai9aNZj0K6bBvftYhb6kRllt0t1gt0x+0L9qUIz/MPbDDpxgTssCkgq6vx3OV0DOqMU2FhDR4w+apAtgs8fc/cFG7SdwVGUJ3OXZMG2lyXhgANUrH9oR7xdif3e7KNjjNe+b/TtFAZFtmccFPafxWq/m2GVx8NrVnloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUY7Z+Af; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUY7Z+Af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58738C19424;
	Thu, 19 Mar 2026 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773952777;
	bh=gSiDhWKaiD7adHK7MF1gYzB6wyCyr2ktTQkttJ6PAiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUY7Z+AfyL7PIkLD5TVwEnZDefMBIKDIdS6S56fu/otxvbxQXPIUGCfAIQ6pO5ks6
	 cqoNxDuhp7Ape/rNU3zHyiOpjID9UPx68OJM2+9SHP7puQJww14Ssxekae15mC5S7u
	 M7O3zRaYq5z5sb+L0hkjsQEcI2PUHnM0GN5vX+sXkUpaRZkfmBeMurITYH7ETdBndr
	 d0sTHBv1dJ2lujmLHNqIBPvs+TdGHaaF7K2W7k9usg2g6MOEuJN8ONyYCtzCu9zYbL
	 muK1bFXajkcJ6lJxYA+jxQRCCrF1pzfj82DSf6ZY3quBr/58myyTJKSbtmRRhUUFVV
	 PD8V12dv9dmaw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 21D6AF40071;
	Thu, 19 Mar 2026 16:39:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 19 Mar 2026 16:39:35 -0400
X-ME-Sender: <xms:B1-8adkBWRHY7FkGaDoGmk-i62LLjLY5lUZ3I2VSGQdGNwz2GXhhtw>
    <xme:B1-8aTPUz8PfL9-6Zx7h3pZJHXxTvKO7VjcH84-z1Sgi2Yzc57bzG5QBd-PmLeLh7
    L5sXNgrrfU5hpT21wBDXbGw2wtcqHODy2axnHviljLm8CNFDW3JZro>
X-ME-Received: <xmr:B1-8aZzL7Z334TXSS9ngT-pf2Vefq6qlU91foakjIKs0vYjutmA55Ed8jId0DQsjxwVnhn5QLURfybFiat8-Kw1JYdqvsGaB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhho
    vghlrghgnhgvlhhfsehnvhhiughirgdrtghomhdprhgtphhtthhopehmvghmgihorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsihhgvggrshihsehlihhnuhhtrhhonhhigidr
    uggvpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdr
    ihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B1-8aYv9ZPoOB6P5PP1B2WpyUMF2cTpzXDfSZ9n3HkAYd4OpK9hPyg>
    <xmx:B1-8aUbbGTO27kbH9ETaPrvyu9cXWG9MsbOgarIwyJNdA4Z9L8aznQ>
    <xmx:B1-8af2zNQlsNSlGAPlMYzyShggN2Tbep5gZQa_Uylm-Q9gEOBYNQg>
    <xmx:B1-8aetgst-NaVMbUoMHxH_sw2VDB1DBu2bftwd19OBM8hIT5rbGYg>
    <xmx:B1-8abA1PPvzbMOCeYuhBYQ8eJtCW9i_Iex3gmKW2ejgJRHfWS9wZwEK>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 16:39:34 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:39:33 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	paulmck@kernel.org, frederic@kernel.org, neeraj.iitr10@gmail.com,
	urezki@gmail.com, boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abxfBZ89wIJILuom@tardis.local>
References: <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89763fcd-3710-49a0-91ca-cd923b47fc1e@nvidia.com>

On Thu, Mar 19, 2026 at 04:21:45PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/19/2026 4:14 PM, Boqun Feng wrote:
> > On Thu, Mar 19, 2026 at 07:41:06PM +0100, Kumar Kartikeya Dwivedi wrote:
> >> On Thu, 19 Mar 2026 at 18:27, Boqun Feng <boqun@kernel.org> wrote:
> >>>
> >>> On Thu, Mar 19, 2026 at 05:59:40PM +0100, Kumar Kartikeya Dwivedi wrote:
> >>>> On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
> >>>>>
> >>>>> On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> >>>>>> On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> >>>>>>> On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> >>>>>>>> Please just use the queue_delayed_work() with a delay >0.
> >>>>>>>>
> >>>>>>>
> >>>>>>> That doesn't work since queue_delayed_work() with a positive delay will
> >>>>>>> still acquire timer base lock, and we can have BPF instrument with timer
> >>>>>>> base lock held i.e. calling call_srcu() with timer base lock.
> >>>>>>>
> >>>>>>> irq_work on the other hand doesn't use any locking.
> >>>>>>
> >>>>>> Could we please restrict BPF somehow so it does roam free? It is
> >>>>>> absolutely awful to have irq_work() in call_srcu() just because it
> >>>>>> might acquire locks.
> >>>>>>
> >>>>>
> >>>>> I agree it's not RCU's fault ;-)
> >>>>>
> >>>>> I guess it'll be difficult to restrict BPF, however maybe BPF can call
> >>>>> call_srcu() in irq_work instead? Or a more systematic defer mechanism
> >>>>> that allows BPF to defer any lock holding functions to a different
> >>>>> context. (We have a similar issue that BPF cannot call kfree_rcu() in
> >>>>> some cases IIRC).
> >>>>>
> >>>>> But we need to fix this in v7.0, so this short-term fix is still needed.
> >>>>>
> >>>>
> >>>> I don't think this is an option, even longer term. We already do it
> >>>> when it's incorrect to invoke call_rcu() or any other API in a
> >>>> specific context (e.g., NMI, where we punt it using irq_work).
> >>>> However, the case reported in this thread is different. It was an
> >>>> existing user which worked fine before but got broken now. We were
> >>>> using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
> >>>> is held before, so the conversion underneath to call_srcu() should
> >>>> continue to remain transparent in this respect.
> >>>>
> >>>
> >>> I'm not sure that's a real argument here, kernel doesn't have a stable
> >>> internal API, which allows developers to refactor the code into a saner
> >>> way. There are currently multiple issues that suggest we may need a
> >>> defer mechanism for BPF core, and if it makes the code more easier to
> >>> reason about then why not? Think about it like a process that we learn
> >>> about all the defer patterns that BPF currently needs and wrap them in a
> >>> nice and maintainable way.
> >>
> >> This is all right in theory, but I don't understand how your
> >> theoretical deferral mechanism for BPF will help here in the case
> >> we're discussing, or is even appealing.
> >>
> >> How do we decide when to defer? Will we annotate all locks that can be
> >> held by RCU internals to be able to check if they are held (on the
> >> current cpu, which is non-trivial except by maintaining a held lock
> >> table, testing the locked bit is too conservative), and then deferring
> >> the call_srcu() from the caller in BPF? What if you gain new locks? It
> >> doesn't seem practical to me. Plus it pushes the burden of detection
> >> and deferral to the caller, making everything more complicated and
> >> error-prone.
> >>
> > 
> > My suggestion would be: deferring all call_srcu()s that in BPF
> > core. [...]
> 
> isn't one of the issues is that BPF is using call_rcu_tasks_trace() which is now
> internally using call_srcu? So whether other parts of BPF use call_srcu() or

I was talking about the long term solution in that thread ;-)

Short-term, yes the switching from call_rcu_tasks_trace() to call_srcu()
is the cause the issue, and we have the lockdep report to prove that. So
in order to continue the process of switching to SRCU for BPF, we need
to restore the behavior of call_rcu_tasks_trace() in call_srcu().

> not, the issue still stands AFAICS.
> 

In an alternative universe, BPF has a defer mechanism, and BPF core
would just call (for example):

    bpf_defer(call_srcu, ...); // <- a lockless defer

so the issue won't happen.

> I think we have to fix RCU tasks trace, one way or the other.
> 
> Or did I miss something?
> 

No I don't think so ;-)

Regards,
Boqun

> thanks,
> 
> --
> Joel Fernandes
> 
> 
> 
