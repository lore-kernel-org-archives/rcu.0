Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3C1C683;
	Sun, 12 May 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715525871; cv=none; b=tkc4jDU2m9lgTMcfp8TlxaxFkHHfTnbat94E704vAW1N5T/2aJQsqZ8Pe+tJQgTyTAJgSh3CRONao0LKluc0ii6TGXh0/I06Q7RcZQuS5n4RR8XGtOItpeWQqJv19Xp19s3yEVM4wfC6MmckK+qB1wvtCCubdXvm2fki7RQgf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715525871; c=relaxed/simple;
	bh=q9eH8/eFg6/9RnNca9YlQBwsiRfQ4xzp1iIUc84JUa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX5EBjMqbwC3/7KLtAzXdVv33sJ0Pg7k9X6fZw+HnZSmYIjln6cWjYTc2rPsmCr83LI2vIHoxnvoS6lrJq7xlKutMDjp52VLWz99B3xMq2r/Tf4EpmDhDj0So7d/WljEVK+oMkFy9CQJwsUJ0r/9ys8NRUUxJmdHOnq2crGFhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVSj0Oht; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVSj0Oht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D574C116B1;
	Sun, 12 May 2024 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715525871;
	bh=q9eH8/eFg6/9RnNca9YlQBwsiRfQ4xzp1iIUc84JUa8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cVSj0OhtDq8l0Jj/CKq6Ythv6D7HpvruflZM+djSyZc+49ww12/j4vbhxBZFHTH48
	 nZas8B/kfFT2ZoMnDvxkTmFX9Gclhh5x6cB9LWzUVeJS4Jcs4/i46KNG6xMdGezPHP
	 Dd/KpYXNzFrhSJ+CxbQF8PaPZS2RAjh5izxcHWqqSmK2sxTp3QhPJWdio6Ah15VzmF
	 XWdaEWT2w3Owj+DjFkPnqfDSqSQTAXLOYvX1IYhAel6rYHnGYageW4Nq7DSSRybHe+
	 Tg2Z4N6INfMwa05dChYR1TFKj8MlcnlZCsfa6lKWrkA4/zXILJN0z5UlHQ5t+XDI9G
	 GzOji2qSZjPhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A3D1CE105C; Sun, 12 May 2024 07:57:50 -0700 (PDT)
Date: Sun, 12 May 2024 07:57:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <26f2d843-b76f-452a-a5d0-b3a146351bb2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240509151312.GA22612@redhat.com>
 <f0a02cfe-7fc2-494c-8734-e5583f42a8f7@paulmck-laptop>
 <20240510113149.GA24764@redhat.com>
 <8ca02df3-5034-4483-8e64-3fc22eb14431@paulmck-laptop>
 <20240512105305.GB7541@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512105305.GB7541@redhat.com>

On Sun, May 12, 2024 at 12:53:06PM +0200, Oleg Nesterov wrote:
> On 05/10, Paul E. McKenney wrote:
> >
> > On Fri, May 10, 2024 at 01:31:49PM +0200, Oleg Nesterov wrote:
> >
> > > Why is that?
> >
> > Because I run KCSAN on RCU using Kconfig options that cause KCSAN
> > to be more strict.
> 
> Yes, I see now.
> 
> > > but how can KCSAN detect that all accesses to X are properly marked? I see nothing
> > > KCSAN-related in the definition of WRITE_ONCE() or READ_ONCE().
> >
> > The trick is that KCSAN sees the volatile cast that both READ_ONCE()
> > and WRITE_ONCE() use.
> 
> Hmm. grep-grep-grep... I seem to understand, DEFINE_TSAN_VOLATILE_READ_WRITE.
> So __tsan_volatile_readX() will use KCSAN_ACCESS_ATOMIC.
> 
> Thanks!

You got it!!!

> > > And what does the "all accesses" above actually mean? The 2nd version does
> > >
> > > 	WRITE_ONCE(X, X+1);
> > >
> > > but "X + 1" is the plain/unmarked access?
> >
> > ...
> >
> > In that case, the "X+1" cannot be involved in a data race, so KCSAN
> > won't complain.
> 
> Yes, yes, I understand now.
> 
> Paul, thanks for your explanations! and sorry for wasting your time by
> provoking the unnecessarily long discussion.

Not a problem and absolutely no need to apologize!  Of course, please do
pass this information on to anyone else needing it.

> I am going to send the trivial patch which moves these WARN_ON()'s under
> spin_lock(), this looks more clean to me. But I won't argue if you prefer
> your original patch.

Actually, I like your patch quite a bit better than I do my original.
In fact, I feel quite foolish that I did not think of this to begin with.
With your way, we have strict locking for that field and can therefore
just use plain C-language accesses for all accesses to it.  KCSAN will
then warn us of any buggy lockless access to that field, even if that
buggy access uses READ_ONCE().  Much much better your way!!!

So thank you for persisting on this!

							Thanx, Paul
