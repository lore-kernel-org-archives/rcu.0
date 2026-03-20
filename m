Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08B3CF67E
	for <rcu@vger.kernel.org>; Fri, 20 Mar 2026 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023345; cv=none; b=UU9RPHYB8O5e4Gsw3Lrg2mcfTmiwGstRg5ZQ3rnnmi+6AbqSOhq0rS8zXte6w6mYmTRRL0HbVdrIa+8uV1Ffld3ArnzXiGSwrEsQo5BnJrpaCXaqK56AGAFmI4R3pDMjMC4ZGF+vK7lRSJODxE0VQ6wEryCuAdk087Mb35uc73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023345; c=relaxed/simple;
	bh=Qc4So4ZdFq75/8echA0G/oL58X0JIklmFSXlRFRE0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7WYDjr9a9xkrNrkxwa8LgqH+hZ9Go7dfLLbcJk1K0DpmXiBNx6vKrB5wPQmuQmPwunCA4m2J34BQUfRGSRmbplS8I7cmxCyxNzu0372srOsC/33UCDN0K3flZ2R42WkMEZpBDRUuKLMzWSfvXD5UD7G+2RF17pZCohBo+4H/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjo/2XTY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjo/2XTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B39C19425;
	Fri, 20 Mar 2026 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774023345;
	bh=Qc4So4ZdFq75/8echA0G/oL58X0JIklmFSXlRFRE0Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjo/2XTYq3XyccbjiTmvP07KSRS5StPDqnMko4s1qs9DuVOsahsJjBfoFhrooYBhV
	 aGXVNpUZM3eYBUyBcr/PwNWdXccHVeTXG+a5WmwoOEEA1i0Q1BeK2/sIUjt9hJusMa
	 7sV7ub7Hssj+fn5PQpadcGt6lGizpjjwf0iVdoqWukNkjTcVpaMTjOISIRHiPrZeB2
	 sKecMas4mNN6J4pkPT2EkbHhrkh7Dz4XEkr2o6tqET/TipaGERkmrzgJt/gdXTETVx
	 xGtjbeR2cQvKsJz4eyVsTznEyHBSdhmQuDaQKEKhcvk2r+eWrFQKI67EWJvtcW3ncC
	 VQHba1ISTtADg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B272F4006E;
	Fri, 20 Mar 2026 12:15:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 20 Mar 2026 12:15:44 -0400
X-ME-Sender: <xms:sHK9aQ8w3XmPo1KdU9G8WEHX5XLMeTSyfqe0YsX5o5ARn_tI2gyB6Q>
    <xme:sHK9aTEFZHPZ65DX-IS714Am5KCYsHYmE2L-4gBN33ckG0WMWPohYtFDxzACGk1gc
    XrgXXXL5UwMumsmQNscm9Ft3-bd_QD08H1-T7zplFc4SBKH1cstNgA>
X-ME-Received: <xmr:sHK9acLbMvKrwCoPyrQEo2XhGrBMTY_NRPPUgD_Emn82cx9m8mngG-R_6yK7o4FXecUUPcHkjuOJ_Q4vuu0AR7hjtDFEtBnR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtfeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sHK9abkBV7877GuozC8vuNYDHexOwDbY1-GbuxRftrpajA59p_t2ZQ>
    <xmx:sHK9adz2TjzgmsagBsiTseXpAewLntgt8fbBVGNlQMLwj86nuspZbQ>
    <xmx:sHK9ads24y11X4-MpCLcX8hzTCpuXlm0A67zVT4h4Eft_JKMLliGqA>
    <xmx:sHK9aXGNzolSIN62AVXNQtndKjaousuScnurfQHN9IKFv6qV50CotA>
    <xmx:sHK9ab6Ow_gZm9OyOeOEn4GH7JfQ92i7jqxpjd5AB2_sNo_BUhJmFrs_>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 12:15:43 -0400 (EDT)
Date: Fri, 20 Mar 2026 09:15:42 -0700
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
Message-ID: <ab1yrtsiEdyqN4pY@tardis.local>
References: <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abxZEE4SAMkNEleq@tardis.local>

On Thu, Mar 19, 2026 at 01:14:08PM -0700, Boqun Feng wrote:
[...]
> > Also, any unconditional deferral in the caller for APIs that can "hold
> > locks" to avoid all this is not without its cost.
> > 
> > The implementation of RCU knows and can stay in sync with those
> > conditions for when deferral is needed, and hide all that complexity
> > from the caller. The cost should definitely be paid by the caller if
> > we would break the API's broad contract, e.g., by trying to invoke it
> 
> The thing is, lots of the synchronization primitives existed before BPF,
> and they were not designed or implemented with "BPF safe" in mind, and
> they could be dragged into BPF core code path if we begin to use them.
> For example, irq_work may be just "happen-to-work" here, or there is a

Correction: irq_work is designed to be NMI safe (at least when queueing
on the local CPU), so it's potential the bpf_defer() I proposed.

Regards,
Boqun

> bug that we are missing. It would be rather easier or clearer if we
> design a dedicate defer mechanism with BPF core in mind, and then we use
> that for all the deferrable operations.
> 
> Regards,
> Boqun
> 
> > in NMI which it is not supposed to run in yet, in that case we already
> > handle things using irq_work. Anything more complicated than that is
> > hard to scale. All of this may also change in the future where we
> > support call_rcu_nolock() to make it work everywhere, and only defer
> > when we detect reentrancy (in the same or different context).
> > 
> > 
> > 
[..]
