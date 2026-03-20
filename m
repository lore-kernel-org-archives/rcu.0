Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E43C5538;
	Fri, 20 Mar 2026 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023880; cv=none; b=Mb4wMPgR9f3vbM/3ALCqP/A/cFsdfPQwjh3nY7DhEvvLXt6Hy703TUiAHfbUuHaI56NRs4BwEZDrZ0Pai3v07/zFLstJ4yFdk72YbspPlXZK74xvBe9VZkCEKrl6EVd5NLcHAro1tNuH5uyYYYcKIFEvHzXMeIDHAh7CSNKWlzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023880; c=relaxed/simple;
	bh=1bYt5vzaBhqAR8Q1YLmRpnsMUd43alSRduOAGEl0E5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9q+rTnEDQF+OmS2cr935IHgriQmeJoMiq0Z4nkWWOqJSH9m4zbemQQG3WW8LzCEbvzUebZq76fTe75nuK2cUttAz6PE2OYMkAPqssv/wq5IbHLL3MIT8mlOUQr/g/NCfassQ8ioCC6kCX0j+Qcdez5J3GFk2CIy09bDTbrIUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loAAPVrQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loAAPVrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C20C4CEF7;
	Fri, 20 Mar 2026 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774023879;
	bh=1bYt5vzaBhqAR8Q1YLmRpnsMUd43alSRduOAGEl0E5c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=loAAPVrQbXKiS6NhkM2lh65lxsfbjLLasER1/Yht1f9fXS8xupAMVXWhAxC+ixHjA
	 pBMzEsPDpafGF87T6Z9A/zB/NbSc8cQzABm6+W5+1OaeBF2S+NgwllvQHSgXX/4gOz
	 1GS+fHxTPsMZP36kxZYzHQjPDr3RCE5CvXog6ereuGHNyouqUjOU+E7J2wTy0uvSNu
	 H/VA0/lwP1UGS3sV03SylKFz5mGf8axlu7fj0UuQABSdUftGKuMQgSAb/eqOWoumTT
	 dBylOj8gJNWWXlztsPRPJU8duDXavhd569p5tuaqN2A1v9tDcYJVWAWrte3M2Ezo1e
	 YnG0JmwulUeOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30AAECE0AB1; Fri, 20 Mar 2026 09:24:37 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:24:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joel Fernandes <joelagnelf@nvidia.com>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com,
	rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <2b351380-5619-42e2-bb40-38f7f55a80d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
 <abwyGtG7hDpd8vBN@tardis.local>
 <CAP01T75S-NMgB=s_0jqq52xRwe1cQ29DzD33eeqUZHM3cSb=oA@mail.gmail.com>
 <abxZEE4SAMkNEleq@tardis.local>
 <ab1yrtsiEdyqN4pY@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1yrtsiEdyqN4pY@tardis.local>

On Fri, Mar 20, 2026 at 09:15:42AM -0700, Boqun Feng wrote:
> On Thu, Mar 19, 2026 at 01:14:08PM -0700, Boqun Feng wrote:
> [...]
> > > Also, any unconditional deferral in the caller for APIs that can "hold
> > > locks" to avoid all this is not without its cost.
> > > 
> > > The implementation of RCU knows and can stay in sync with those
> > > conditions for when deferral is needed, and hide all that complexity
> > > from the caller. The cost should definitely be paid by the caller if
> > > we would break the API's broad contract, e.g., by trying to invoke it
> > 
> > The thing is, lots of the synchronization primitives existed before BPF,
> > and they were not designed or implemented with "BPF safe" in mind, and
> > they could be dragged into BPF core code path if we begin to use them.
> > For example, irq_work may be just "happen-to-work" here, or there is a
> 
> Correction: irq_work is designed to be NMI safe (at least when queueing
> on the local CPU), so it's potential the bpf_defer() I proposed.

Completely agreed!

							Thanx, Paul

> Regards,
> Boqun
> 
> > bug that we are missing. It would be rather easier or clearer if we
> > design a dedicate defer mechanism with BPF core in mind, and then we use
> > that for all the deferrable operations.
> > 
> > Regards,
> > Boqun
> > 
> > > in NMI which it is not supposed to run in yet, in that case we already
> > > handle things using irq_work. Anything more complicated than that is
> > > hard to scale. All of this may also change in the future where we
> > > support call_rcu_nolock() to make it work everywhere, and only defer
> > > when we detect reentrancy (in the same or different context).
> > > 
> > > 
> > > 
> [..]
