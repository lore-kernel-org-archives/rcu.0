Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69088455623;
	Wed,  9 Sep 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986111; cv=none; b=Og+9bwdrWwxgWi0ZFyKHz614DGCF0JJOQhuhMDotIBNrV+hwHxX0uws5KZeBW+bZxKzbaZ8ECUD071/oJxYvgONSPmIBcEIoktwxFW2JIzpgfRIMc7wr2NCFXfUB89cEDXCluvMk2zQ3J6c2EEaXmuTTINzTAIgSrRlxe7FevuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986111; c=relaxed/simple;
	bh=qTOVOMVmT8J4M+LsKWK+E3umusQPuxxuEH4iYapnq6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js4loAhAFLE8gUqzyXU3VviJVCMXt5P6ubmP/WtF401aGQbiraJcwJTHvYyMehZs8fcefJbBoJQTl2rens4oz5GsrD3i2eUWNIgNlBx9yrD/7Kd1T23lwem3q6z025UuereQ0DOKqUCVKS+pqxVflu3F5spyeB20JT2hNIKSZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFEp55DQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFEp55DQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2DF1F000FF;
	Wed,  9 Sep 2026 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986105;
	bh=DLabXkP/qpY4Ri5lK3XmzpMWavMVny5ZhPmfr9w7W/g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=FFEp55DQeMaSS/ZOIuyjRdo00wGAh0rFLGQOBP8Unm1zKLl3qi4nvKPMEdNTJF9o4
	 V15jdm2tjjnFxifB5ejynMao/Cqtai4tWMwSM7CNcRmWZY0cIRkr3XiyZ0WH6eVryZ
	 VFzPERcOmWQxKXscRQ6Xw645X80Nnfbpda58Raq6ees5WdfsegJJC4yRTRWInZqQyV
	 9xcb3P0LjwbfmmSz0wIxlfyINoPRp0PQxRWZzARzhETr5Ea4EO5ijb78G/joDDUrap
	 Col/LldxHxb4400wsgGXulPSfgmHwOIPW6epaSFS3LWgHbjIUiq60JmscF8grpSDWm
	 ZwYZthxDa5tvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 56A70CE086B; Wed,  9 Sep 2026 13:35:05 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:35:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Dan Carpenter <error27@gmail.com>,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Fix casting while dereferencing rcu pointers
Message-ID: <edaaf05a-46a2-4a70-8fb2-32519f1e3931@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
 <20260825-unqual-v1-1-7024fb81b4f9@chromium.org>
 <20260826105527.7ebbb4b1@pumpkin>
 <CANiDSCtKVT9fnkx=-d2-aOd=uqODERFw-fAm6bg2eX=RXGMaXw@mail.gmail.com>
 <20260826142204.7269edf7@pumpkin>
 <CANiDSCuAWhEZerLE2Ki-agDgZ-WEZLr216siKRq+Zj2PnaRWMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCuAWhEZerLE2Ki-agDgZ-WEZLr216siKRq+Zj2PnaRWMw@mail.gmail.com>

On Wed, Aug 26, 2026 at 04:03:14PM +0200, Ricardo Ribalda wrote:
> Hi David, Dan and Paul
> 
> On Wed, 26 Aug 2026 at 15:22, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > On Wed, 26 Aug 2026 13:28:42 +0200
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > > Hi David
> > >
> > > On Wed, 26 Aug 2026 at 11:55, David Laight <david.laight.linux@gmail.com> wrote:
> > > >
> > > > On Tue, 25 Aug 2026 20:02:10 +0000
> > > > Ricardo Ribalda <ribalda@chromium.org> wrote:
> > > > >
> > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > index 44c07a66edff..80276cedda80 100644
> > > > > --- a/include/linux/rcupdate.h
> > > > > +++ b/include/linux/rcupdate.h
> > > > > @@ -488,7 +488,7 @@ static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx
> > > > >  context_unsafe(                                                              \
> > > > >       typeof(*p) *local = (typeof(*p) *__force)(p);                   \
> > > > >       rcu_check_sparse(p, __rcu);                                     \
> > > > > -     ((typeof(*p) __force __kernel *)(local))                        \
> > > > > +     ((TYPEOF_UNQUAL(*p) __force __kernel *)(local))                 \
> > > >
> > > > Ugg... TYPEOF_UNQUAL() is absolutely horrid...
> > > > When __CHECKER__ is undefined the whole thing is just (p).
> > >
> > > About using __CHECKER__: Are you suggesting using #ifdef __CHECKER__
> > > to use TYPEOF_UNQUAL or the current code?
> > >
> > > I am open to doing that, but I would like to hear from Paul if he
> > > favors adding the (also horrid) #ifdef to save some CPU cycles on
> > > older compilers.
> > >
> > > >
> > > > I suspect reducing all the definitions would measurably improve
> > > > kernel compile time (even before these changes).
> > >
> > > When I checked earlier in the other patch in this patchset, with my
> > > compiler I can hardly see any difference in compilation times [1].
> > > This is probably because GCC15 direclty maps TYPEOF_UNQUAL to the
> > > built-in __typeof_unqual__.
> >
> > I was thinking of the _Generic() version.
> >
> > But here you only want to remove the (I think) __user marker.
> > I don't think you want to get rid of 'const'.
> > So you don't really want gcc to remove any qualifiers.
> 
> Yeah, I see your point, removing `const` might hide other issues.
> 
> Dan, what would be the best "sparse-approved" way of removing the
> address space qualifiers (__user __rcu)  but keeping the other ones
> (const) ?
> 
> Paul, would you accept an #ifdef __CHECKER__  block to keep Sparse
> happy without affecting GCC type checking?

Potentially...

For example, if this be done so that there is just one such #ifdef
__CHECKER__  block that defines empty/non-empty macros that are used by
the various conversion macros.

In contrast, providing a full separate definition of each macro that
uses __rcu?  That would be quite unfriendly to future readers of the code,
so please, no.

							Thanx, Paul

> Thanks!
> 
> >
> > There is an similar(ish) issue when an __force cast is used to
> > remove one of the extra qualifiers.
> > You really want the compiler to ignore the cast - so it checks
> > the actual types match.
> >
> > David
> >
> > >
> > >
> > > Thanks!
> > >
> > >
> > > [1] https://lore.kernel.org/all/CANiDSCsMrULsrGQg76x28GRXLg+HSKFWhhA14Zcn8hdm4KyOVw@mail.gmail.com/
> > >
> > > >
> > > > David
> >
> 
> 
> -- 
> Ricardo Ribalda
