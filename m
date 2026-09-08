Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50A3ABDA5;
	Tue,  8 Sep 2026 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908146; cv=none; b=sEr+oE8s4wZHzGK/1aA4NS13Lg4hcxGM8zWAXZ4upUz4nvNn34bZ+7FDj1IwkxZZw8Vv7QJXsb5jO59cDi7NmajtD3MZsFSTqU2UPgEOcuzkhO3TRfADy3dV1yeq5E2a7B6Y6MZsKUYQ4KxoCnjiZFa1wb1F+aFy29Y2HjOzru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908146; c=relaxed/simple;
	bh=ejEIMiove+CujFtrI7bxT2HXNP1JhepW+2/j8LcyZnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0VvziqFs8SgMoM6kQe9j4QzdW80W9rqLPNTolDyx6R+Riktur3eMhIjHSOm4ONcTRio3iIXJb884UFoFYflAVl8qGrAaMNId6yZD+eIjS14n6XmhQ8QZ6m3/EXyTIVoi/PWhI6Y+sTSzTqh5HF/UZU8Pa3/ggFBLK5AIP1JAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvojmhn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvojmhn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1301F00A3D;
	Tue,  8 Sep 2026 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908145;
	bh=Crz+3gMeo7BIEo+FlaISaL1txLTXL20OsHgOudIJaQc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=lvojmhn6kxuDS1usDONivrH1msh8EOrJDeQdII/1BRkFV+IYAd1WalyYC1APCYUth
	 5C1Bo6naFPkQxeLIlUFR6/lN489Pzow8M8Nv7JTdUy12J2qiVVm9XU+O8Lns01BloC
	 2CsG/MFb3bjz9fMcdsgj5ua8dvUfojeqT0rj89rHiSLpcnNBY9HvwO+89ZqA1Io3XR
	 ZxCiHnQ8ZBAjIgbqjpyBfJgf8/EbvtM0df/sMKBfB82Ko3S/F/26NhLh4wbM3NBRXq
	 dyEBVyE42J70CkVjhbG3brvas1CM5AwahtbPbOe3FjgJ9InMH3tVEN5TiK7jqyuTZF
	 SwjcmeB58TxQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EA73FCE0F83; Tue,  8 Sep 2026 15:55:44 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:55:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, jiangshanlai@gmail.com,
	josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] srcutree: Add reader-free fastpath to
 synchronize_srcu_atomic()
Message-ID: <31d90de9-4cf6-435b-a3e3-333ee0325a28@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-4-kunwu.chan@linux.dev>
 <b7bc58aa-4b8a-4eaa-a7e8-8d338f34d14a@paulmck-laptop>
 <d622a6ed07845e5b7c5ab87446ff8b622b4b80eb.camel@infradead.org>
 <40a4a925-d984-4f0b-b594-2d0a5ca7bde0@paulmck-laptop>
 <c5e946d3af034749111d9292c57cf2e3d0df5416.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e946d3af034749111d9292c57cf2e3d0df5416.camel@infradead.org>

On Tue, Sep 08, 2026 at 11:09:34PM +0100, David Woodhouse wrote:
> On Tue, 2026-09-08 at 14:54 -0700, Paul E. McKenney wrote:
> > 
> > And another option is to pull the fastpath up earlier, before
> > checking and/or acquiring ->srcu_atomic_gp_flag.  But this is a
> > bit more complicated from a concurrency viewpoint, at least if
> > we are to interact normally with get_state_synchronize_srcu() and
> > poll_state_synchronize_srcu().  For example:
> > 
> > 	srcu_state = get_state_synchronize_srcu(ssp);
> > 	synchronize_srcu_atomic(ssp);
> > 	WARN_ON_ONCE(!poll_state_synchronize_srcu(ssp, srcu_state));
> > 
> > Without at least some mucking with the grace-period mechanism, that
> > WARN_ON_ONCE() could trigger, which just might not be universally
> > considered to be a friendly act.  ;-)
> > 
> > So it would be very good to keep the fastpath where Kunwu put it, if
> > that works reasonably.
> 
> Could we not just declare that synchronize_srcu_atomic() *isn't*
> guaranteed to drive a GP, so the above code isn't valid? Why poll for a
> thing that's atomic? Is that a likely use case?

We *could*, but one more thing to explain and one more thing for users
to get wrong.

> And you've already forbidden start_poll_synchronize_srcu() for atomic,
> haven't you?

Yes, because there is no such thing as an asynchronous atomic SRCU
grace period.

> I concede that the same logic doesn't work quite as well for
> synchronize_srcu_expedited(), as it's an established API. Could we
> retcon that one?

My hope is that this same sort of approach works there as well.

Hey, I can dream, can't I?  ;-)

							Thanx, Paul
