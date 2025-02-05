Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E16191F60;
	Wed,  5 Feb 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770967; cv=none; b=h2n+0LGVweu+vzQm+Il/10E0cAj/Q4eMDzp4HUc6I5C/d9JI4mjulZ03UQqSjXw+7ZnZTCbt/Daks57I9jf53WgyHu8QYR9DwDmmcX3KSJj2ZXLqdf2w7Jllp5goMVHSlfowJPk5qskl0jWGMomP8e9IJZbi9P4VhceYJill8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770967; c=relaxed/simple;
	bh=ZS3IMLzrZT4ujFwlAknS0GB7bPyVQkzuUAMqbkw+4Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyfBCYEuI2UbJjXEdyKNih+7x0hWpUZ466V9zsdVQOYeRkpnT6AbjabcW7M9z4ZRmoXRSs0b07cRc3UZyhawVV9VGgsniLnKnjep+T9Qy9v75gd8AF64Nn221hqbXwfYxnn/UZtjp5pFyVYn4GYfm1o/fEDy2yoslzf6aWg7Uso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxXk0Auc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxXk0Auc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C880C4CED1;
	Wed,  5 Feb 2025 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738770967;
	bh=ZS3IMLzrZT4ujFwlAknS0GB7bPyVQkzuUAMqbkw+4Wk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DxXk0Auc2t1sh7zwE+qm6ReFr66wxEj2FJ6hLayzWRYg+V5kPtWKpGMJBLwOyyBQ7
	 p3z3XffotEhQ4Pnf9gI0lRk2baM4kCBPQd/L10N2XrsPRNpaycVvZ87J/ABN0HSsmW
	 cUy2FbnFEEi5NfU5G85pGS/YAmE7W3I4ueLq4ftoh4uEVfWpbHCaOlt/uaQby6neIi
	 JpoxcYeE8hURFHLnHApIRPgKYocgEzmg/+vCc8nay2a44QViGGi2hzrVAUIHt4HjrZ
	 wl2qOIffJjYIKGW7PZ51t0TJSLv5usuSCZsMn/MevIYXbbfz6wH0AjTK0C/K79dQD4
	 sZlt34PtoFmPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BDE65CE0749; Wed,  5 Feb 2025 07:56:06 -0800 (PST)
Date: Wed, 5 Feb 2025 07:56:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
Message-ID: <87f074af-a39c-48db-972f-5f46e57aa3db@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ecce7241-4238-4d86-8e4c-5080937129ce@paulmck-laptop>
 <15D1150A-9B7B-4EB7-91C6-2D881D6F48DA@joelfernandes.org>
 <861f1dc3-bfc0-4a81-9b78-c8e9995db4cd@paulmck-laptop>
 <CAEXW_YQ4W=upWV_x1woSgq-DJPFXmBjH2pVmUnBVb_n_UKrw7A@mail.gmail.com>
 <ec293223-2a33-4d2f-b3ca-c011c3d987f3@paulmck-laptop>
 <CAEXW_YQXgZANSjo835VfHMqY=z8gaSWQ2bgaWtVd4-3KX0hX8w@mail.gmail.com>
 <999751de-b891-424d-a7b5-80bfa98793ff@paulmck-laptop>
 <CAEXW_YT6bD=sAD77yg+BXC+Q0NW0RHCg6fEYZ_jsBeXkAd_1tg@mail.gmail.com>
 <e23ab8d2-1a64-458b-a83d-eabcf92a2382@paulmck-laptop>
 <CAEXW_YSFtF=Vx2P73m0tdfAYgSui-KSzGnyqiTY1rwOfWfFycA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSFtF=Vx2P73m0tdfAYgSui-KSzGnyqiTY1rwOfWfFycA@mail.gmail.com>

On Wed, Feb 05, 2025 at 10:45:08AM -0500, Joel Fernandes wrote:
> On Wed, Feb 5, 2025 at 5:28 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Feb 04, 2025 at 08:28:29PM -0500, Joel Fernandes wrote:
> > > On Tue, Feb 4, 2025 at 3:22 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 04, 2025 at 10:44:45AM -0500, Joel Fernandes wrote:
> > > > > On Thu, Jan 30, 2025 at 12:56 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > By "where we were initially", one might reasonably guess that you meant
> > > > > > that the initial value and the target are one and the same.  But I suspect
> > > > > > that you are thinking of a third value, the value of the underlying
> > > > > > grace-period sequence number at the time of the call to rcu_seq_snap().
> > > > > > But you might be thinking of something else entirely.
> > > > > >
> > > > > > > Now we move rcu_seq_done_exact. It has the exact same behavior except
> > > > > > > that instead of ULONG_MAX/2, the above situations are shrunk to about
> > > > > > > 10 counts from the target. So if target is 28, then the initial
> > > > > > > sequence should have been at least 18 to avoid false-positive, but
> > > > > > > again it is possible and I certain see in the code that it cannot be
> > > > > > > used this way.. (at least so far).. So all we are left with is the
> > > > > > > false-negative band of ~2.5 GPs..
> > > > > >
> > > > > > Here, I have the same questions.  As you no doubt guessed.
> > > > > >
> > > > > > > About "what are the consequences of failing to get this right".  I
> > > > > > > believe false-positive is unacceptable unless it is maybe debug code -
> > > > > > > that can break functionality in code, too short GPs and all that.
> > > > > > > However false-negative is OK as long as the usecase can retry later
> > > > > > > and can afford to wait. Did I get that much correct?
> > > > > >
> > > > > > Maybe?
> > > > > >
> > > > > > Please look at this on a per-use-case basis.
> > > > >
> > > > > Sure. FWIW, I started a world-editable document here. I am planning to
> > > > > work on this a bit more before our meeting this week. If others
> > > > > knowledgeable like Frederic and others could make edits/comments,
> > > > > that'd be welcomed. But I basically summarized this whole thread here:
> > > > > https://docs.google.com/document/d/1sFNuGH4U6DFCE8sunbdWMjFhJhb1aG4goOJAnS6c6gQ/edit?usp=sharing
> > > > >
> > > > > My thought is (AFAICS), this patch is still valid and
> > > > > rcu_seq_done_exact is a potentially better replacement to
> > > > > rcu_seq_done. But famous last words...
> > > >
> > > > Let's start with the use case where the sequence number is being used
> > > > by rcu_barrier().  What happens?
> > >
> > > The rcu_state.barrier_sequence is used to keep track of barrier in
> > > progress, as there can be concurrent rcu_barrier() calls happening so
> > > we optimize by batching multiples of these calls.
> > >
> > > It also handles the case where the entrain IPI came through but no
> > > rcu_barrier() is currently in-flight (which would be weird but maybe
> > > it happens somehow).
> > >
> > > It is also used to make sure we don't need to entrain on a CPU again
> > > if we already did an entraining for a certain rcu_barrier() invocation
> > > already. This is tracked by rdp->barrier_seq_snap which copies the
> > > value of rcu_state.barrier_sequence after the entraining. Al though I
> > > am currently unable to envision why the IPI handler would be called
> > > unnecessarily (hardware bug?) since we hold the rcu_barrier mutex
> > > throughout the rcu_barrier() function, including while waiting on
> > > CPUs.
> > >
> > > Going back to my first point, for the rcu_seq_done() in rcu_barrier(),
> > > we are checking if someone else did our work:
> > >     mutex_lock(&rcu_state.barrier_mutex);
> > >     /* Did someone else do our work for us? */
> > >     if (rcu_seq_done(&rcu_state.barrier_sequence, s))
> > >
> > > Here I think rcu_seq_done_exact() is better, because if too many
> > > rcu_barrier() calls concurrently made at the same time, the mutex may
> > > be contended. If enough time passes and we have a wrap around, we
> > > might end up in false-negative land which is much larger with
> > > rcu_seq_done() than ..done_exact(). However, that does seem to be a
> > > bug to begin with if the mutex contended for that long. OTOH, doing an
> > > rcu_barrier() again when we didn't need to doesn't seem like the end
> > > of the world especially if we contended on the mutex for that long.
> > > But at least it shows that rcu_seq_done_exact() cannot seem to hurt
> > > here.
> > >
> > > Hmmm,
> >
> > So...  Do we really care about the difference between rcu_seq_done()
> > and rcu_seq_done_exact() in the rcu_barrier() case?
> 
> In so far as to get rid of rcu_seq_done() API in favor of using
> rcu_seq_done_exact() but should not cause any functional or robustness
> changes to rcu_barrier() at least, AFAICS.

OK, *that* I might be able to get behind.  ;-)

							Thanx, Paul
