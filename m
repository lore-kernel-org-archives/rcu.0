Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369148;
	b=wivGGD/QjreAjE1dILqU+fBnLcafJFRAIpmZXgK+UhYuwJzYcsvBWX1L5paAzHrzZnYL
	 gbcS99f0RAXxOY6snCAzJpm+uXwd0MG645P2IvPNNEM35mbEa1BlxQUxcUIkyMi5H8pyX
	 MK7iDtsirLOzB4hnp7l/pLSgivw9sAXNGXrackmyFrWRvrB4BQUth+vdjFStg8CExKo6L
	 LZxZXYN0u6I/Dx2iAIRih6AqigpOxBNC5L4MbpMkz46QgMfwH3jmnnuoYfiKfQfz12M6m
	 uxMFC+cMip1mBAFdSX/jZpl2ocWlFVMxxNHy0hBO5PVQg6NZgwelk3R+W1ZzeYHctJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369148;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6AbepVJa4qHUTUKwjC/NUlqffa8+4uX4K7QcO3IO45k=;
	b=E3HtDnumInqjWtWpjUx/IMMDdRHz4C4sYR9jc2a74Tptk6KepPd7oSn8DsGdoY01tSi8
	 0G4EsPQtlIbCiufBb9t1WVKP9pcNA8WGnanbfvYyqTFhqpSG87ILpdhUsanKoNHuQjtd/
	 SK3mlV+8/FIbdqdA5AGDA2VCF+OtIcYhxpL9f4v4CypOj4GtOnvfZySgstcVUqfgYRdqC
	 vgaosrNgOI6sDRDKL98JLB/kUoz9Ql/QU3a3NudyBE+c5P+jnSl2bZz4VHznLwsHdx0cD
	 6SMY29hm4UCNM56mne2HFYURTCM8muvVFhoT5395I+Q+7VBR5pc6SK2wyJ4EDU2KwvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqZK0pTH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0030606A321;
	Wed, 11 Nov 2026 03:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqZK0pTH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A91C1F0093C;
	Wed, 11 Nov 2026 03:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369148;
	bh=6AbepVJa4qHUTUKwjC/NUlqffa8+4uX4K7QcO3IO45k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=fqZK0pTHo7mLXPaqRTNuL2e6ZBoQstWVHMEtscVjL2e1+y/ZFIvevACkiVjCWpdqi
	 gRYR5/ANBid7PKncuFfGt0C7wlghz5GzgWb8HLJkKBVedQy1O5aUfdiSP0aYi17Emk
	 /CutmJMnqLtCbER8V3DiPoq+262xib/Nz7wZ2MvN6VTahhcN2CVvCBgOY8pM9witCZ
	 TNsqNjgzFMTMJ0BcW7odgwkZa3AqtXWN9paam4Ufh4EMg0KHg1dnlTx2wGT9j47e4E
	 EWXZ/fXJy2jJciSZ6eZZuotACrQwsaoGhWua2vgS+tPwdCc9PVFB3Kfnboc8OVJGeF
	 0r0n5sOVNu1Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F0F5BCE251D; Tue, 10 Nov 2026 19:52:27 -0800 (PST)
Date: Tue, 10 Nov 2026 19:52:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Song Liu <song@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Breno Leitao <leitao@debian.org>,
	David Dai <david.dai@linux.dev>
Subject: Re: [PATCH v2 09/10] rcu-tasks: Disable callback contend/collapse
 messages by default
Message-ID: <0952b823-990f-4a57-b090-f2cb1a1388c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
 <20261007204511.1982646-9-paulmck@kernel.org>
 <CAPhsuW6jBj1Sjm8SO_HO13oBgq-5gqKptgT_h3OWYoLDQggL7w@mail.gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6jBj1Sjm8SO_HO13oBgq-5gqKptgT_h3OWYoLDQggL7w@mail.gmail.com>

On Tue, Nov 10, 2026 at 06:35:10PM -0800, Song Liu wrote:
> On Wed, Oct 7, 2026 at 1:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > index 627295396cd91..fcac7361ec51e 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -178,6 +178,8 @@ static int rcu_task_contend_lim __read_mostly = 100;
> >  module_param(rcu_task_contend_lim, int, 0444);
> >  static int rcu_task_collapse_lim __read_mostly = 10;
> >  module_param(rcu_task_collapse_lim, int, 0444);
> > +static bool rcu_task_collapse_debug __read_mostly;
> > +module_param(rcu_task_collapse_debug, bool, 0644);
> >  static int rcu_task_lazy_lim __read_mostly = 32;
> >  module_param(rcu_task_lazy_lim, int, 0444);
> 
> Rookie question: Instead of adding a new module_param and gating the
> pr_info with it, can we use pr_debug here?

Good question, actually.  If it is OK for everyone (not just our
employer!)  for the global pr_debug() control to also control this,
that would be fewer lines of code.

This one is already in mainline.  If you feel strongly enough about it and
are sure that pr_debug() works globally, would you like to send a patch?

							Thanx, Paul

> Thanks,
> Song
> 
> 
> > @@ -390,7 +392,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> >                         WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
> >                         WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
> >                         smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
> > -                       pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
> > +                       if (data_race(rcu_task_collapse_debug))
> > +                               pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
> [...]
