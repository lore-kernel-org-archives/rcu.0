Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566971368
	for <rcu@vger.kernel.org>; Fri,  8 Mar 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937114; cv=none; b=hOfCAcUuBbzpPF6u26d+ISKqVkHYEt4hvU3qO6D82F08IoCF4eW/0jr6F+rA7aPDTDvgye6ukIcmHSskjXohhZLgruWU/tTM8R0ayoMFbcvZ2dqmjPoh0AZp2xQNR8DP3EYnOizR8b1v/n1hNb/nAm8FhmOZ5vPs7i1KXz6GlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937114; c=relaxed/simple;
	bh=gML9UbTJAIfwx+JF6aO1wlpMho8RPO1UL/88nBvBQ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHgFF8wr7cCX7x7CRyZjauDZc5Tkq1tmhkAA+654VfZRglk6jr+wrE1aAtLPIjOvr+VcEM3qUOVswexG/yfbJuaamvSxaV+iVDMgcpXc2vXBDoxQwdtwu3XA8aqfVY7ny7O+KTu3LwizMtm1zLx+EOb3+TOCp71DdHrI+MhxhYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF6oy0c1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF6oy0c1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4128C433C7;
	Fri,  8 Mar 2024 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709937113;
	bh=gML9UbTJAIfwx+JF6aO1wlpMho8RPO1UL/88nBvBQ7g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nF6oy0c1lNb7HK0a6putuJie1sXU5JCnjPEdnUF6I14BTJN6K1ckh+BHI0hp5yHBy
	 HJsQp7Vc65DtkMM1qVvxLwEK6SWDISIPi+QF4USaJjWTCJtJ0wRVUd+OBFi9AbGJcF
	 /3KBnKzhTfwHB06O4h95fc79kdfyslpOrc0TvcBJp0u1sIBr93WHADe7TCAoy+ScNr
	 cximHe4X41x6jGhnsjwYjjBY9Ju4NgIbvGc7zQljdlFE1gXk8UGK3GDgcEWLAg0WV9
	 CI79O9cwYE+BSLuGIw7vlkZSV/W1GX8WnnZu7PABPue0Ngu0PPIuIxD6gNVdNECQo9
	 Y5syAhoALqL9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C8B8CE0548; Fri,  8 Mar 2024 14:31:53 -0800 (PST)
Date: Fri, 8 Mar 2024 14:31:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: rcu@vger.kernel.org, kasan-dev@googlegroups.com, dvyukov@google.com,
	glider@google.com
Subject: Re: [PATCH RFC rcu] Inform KCSAN of one-byte cmpxchg() in
 rcu_trc_cmpxchg_need_qs()
Message-ID: <53a68e29-cd33-451e-8cf0-f6576da40ced@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop>
 <CANpmjNO+0d82rPCQ22xrEEqW_3sk7T28Dv95k1jnB7YmG3amjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO+0d82rPCQ22xrEEqW_3sk7T28Dv95k1jnB7YmG3amjA@mail.gmail.com>

On Fri, Mar 08, 2024 at 11:02:28PM +0100, Marco Elver wrote:
> On Fri, 8 Mar 2024 at 22:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Tasks Trace RCU needs a single-byte cmpxchg(), but no such thing exists.
> 
> Because not all architectures support 1-byte cmpxchg?
> What prevents us from implementing it?

Nothing that I know of, but I didn't want to put up with the KCSAN report
in the interim.

> > Therefore, rcu_trc_cmpxchg_need_qs() emulates one using field substitution
> > and a four-byte cmpxchg(), such that the other three bytes are always
> > atomically updated to their old values.  This works, but results in
> > false-positive KCSAN failures because as far as KCSAN knows, this
> > cmpxchg() operation is updating all four bytes.
> >
> > This commit therefore encloses the cmpxchg() in a data_race() and adds
> > a single-byte instrument_atomic_read_write(), thus telling KCSAN exactly
> > what is going on so as to avoid the false positives.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Marco Elver <elver@google.com>
> >
> > ---
> >
> > Is this really the right way to do this?
> 
> This code has a real data race per definition of data race, right?
> KCSAN instruments the primitive precisely per its real semantics, but
> the desired semantics does not match the real semantics. As such, to
> me the right way would be implementing cmpxchgb().

No argument other than timeframe.  ;-)

Plus I suspect that a straightforward emulation of cmpxchgb() by cmpxchg()
would need to do something similar.

> Otherwise, the workaround below is perfectly adequate.

Thank you very much for checking!

							Thanx, Paul

> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index d5319bbe8c982..e83adcdb49b5f 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1460,6 +1460,7 @@ static void rcu_st_need_qs(struct task_struct *t, u8 v)
> >  /*
> >   * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
> >   * the four-byte operand-size restriction of some platforms.
> > + *
> >   * Returns the old value, which is often ignored.
> >   */
> >  u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
> > @@ -1471,7 +1472,13 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
> >         if (trs_old.b.need_qs != old)
> >                 return trs_old.b.need_qs;
> >         trs_new.b.need_qs = new;
> > -       ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
> > +
> > +       // Although cmpxchg() appears to KCSAN to update all four bytes,
> > +       // only the .b.need_qs byte actually changes.
> > +       instrument_atomic_read_write(&t->trc_reader_special.b.need_qs,
> > +                                    sizeof(t->trc_reader_special.b.need_qs));
> > +       ret.s = data_race(cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s));
> > +
> >         return ret.b.need_qs;
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
> >
