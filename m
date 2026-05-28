Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652D31F993
	for <rcu@vger.kernel.org>; Thu, 28 May 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948842; cv=none; b=WVbpTgTtyW6gywK6L6+G/7oDSujXJUHu4Y0N0XTKiGSFOUgRII9UXaa42g+mDIczdEojLMAHnF4PN6jsODC2s0NWT3iBNQ021q6N1O1JeP60zM+kZFrt55G+/Qavt2ylukOQC634axBCb+didKXz0axqMA/h415Xxh7yDKQc6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948842; c=relaxed/simple;
	bh=6Zy2CeTCfFnKsiYcaNTkAPCaIn/Cq2LAUs1hTxxEHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohILE37HOD6/42L/K9bQ9RqAUzNwhJKrS8cJtxbARVQZ8kniNOG6gfEl20W2bg/LWwg5wKJ2m3nDTlLIoxBGcj+ys9XFJVVJdumvLXhx4OmmxYga5JiFuOeE7AZUzl6LkU2MRwRmQGWrNMBBSFExYsnk52dY0k6sdw5kbMTsrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=hRaijqcL; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="hRaijqcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779948835; x=1780208035;
	bh=QLxhPJnDuqhM/jpGSWu2wfrWgePJxvhfrx4X+6W5fuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hRaijqcLkeFn54inhEwquvoOxjK19wkOzRskhI69d08jTuH56S2xopFhA3Frp4+uY
	 Lz51VFG9cH0mgN9nzhn6bEC47yHSw3I/+UnrdgDhMlqHXNTjHuBQSD4O+VFe8ACvfn
	 xynQbBy3GYbhorz+o9R+3co9f76s/vTz3LySWpSZZ8/IBZvbe8xPs8wAb+/kuJqXql
	 7BA3P69Y5JzWlGzmB0irb00I5f6kr7AjCp/bU0bdWks7LGwwnNHC53RB06fxUVrPKU
	 wpFF3Ref5JOsnqDtXCEEfMrbPumWTr0kuA9NAC+SMTIpt8fcw3thUxeDYkLpEu666X
	 7L7m5ebC/8fgg==
X-Pm-Submission-Id: 4gQx584pb3z2ScWw
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v5 1/4] rust: helpers: add SRCU helpers
Date: Thu, 28 May 2026 09:13:44 +0300
Message-ID: <20260528061347.114509-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <05906890-cf06-414c-a625-02f9d7150d57@paulmck-laptop>
References: <20260527174120.510447-1-work@onurozkan.dev> <20260527174120.510447-2-work@onurozkan.dev> <05906890-cf06-414c-a625-02f9d7150d57@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 16:03:30 -0700=0D
"Paul E. McKenney" <paulmck@kernel.org> wrote:=0D
=0D
> On Wed, May 27, 2026 at 08:40:42PM +0300, Onur =C3=96zkan wrote:=0D
> > Add helper wrappers for SRCU functions that are exposed to Rust=0D
> > through generated bindings.=0D
> > =0D
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
> > ---=0D
> >  rust/helpers/helpers.c |  1 +=0D
> >  rust/helpers/srcu.c    | 34 ++++++++++++++++++++++++++++++++++=0D
> >  2 files changed, 35 insertions(+)=0D
> >  create mode 100644 rust/helpers/srcu.c=0D
> > =0D
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c=0D
> > index 625921e27dfb..f3562d3b3888 100644=0D
> > --- a/rust/helpers/helpers.c=0D
> > +++ b/rust/helpers/helpers.c=0D
> > @@ -88,6 +88,7 @@=0D
> >  #include "signal.c"=0D
> >  #include "slab.c"=0D
> >  #include "spinlock.c"=0D
> > +#include "srcu.c"=0D
> >  #include "sync.c"=0D
> >  #include "task.c"=0D
> >  #include "time.c"=0D
> > diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c=0D
> > new file mode 100644=0D
> > index 000000000000..79dd24a104ef=0D
> > --- /dev/null=0D
> > +++ b/rust/helpers/srcu.c=0D
> > @@ -0,0 +1,34 @@=0D
> > +// SPDX-License-Identifier: GPL-2.0=0D
> > +=0D
> > +#include <linux/srcu.h>=0D
> > +=0D
> > +__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_st=
ruct *ssp,=0D
> > +							const char *name,=0D
> > +							struct lock_class_key *key)=0D
> > +{=0D
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC=0D
> > +	return __init_srcu_struct(ssp, name, key);=0D
> > +#else /* !CONFIG_DEBUG_LOCK_ALLOC */=0D
> > +	return init_srcu_struct(ssp);=0D
> > +#endif /* CONFIG_DEBUG_LOCK_ALLOC */=0D
> > +}=0D
> =0D
> Similar to Boqun's feedback on a later patch, could you please make=0D
> these be two functions under the corresponding legs of the existing=0D
> CONFIG_DEBUG_LOCK_ALLOC #ifdef in include/linux/srcu.h?  You are includin=
g=0D
> that file above, so it should work well.=0D
> =0D
> Actually, you could just name thefunction __init_srcu_struct(), use the=0D
> existing definition under #ifdef CONFIG_DEBUG_LOCK_ALLOC, and just create=
=0D
> the simple wrapper in the other leg of this #ifdef.  That would be more=0D
> aligned with the Linux-kernel coding guidelines and also be less code.=0D
> =0D
> Or is the "rust_helper_" prefix mandatory?  If so, you could make=0D
=0D
That prefix is indeed mandatory.=0D
=0D
> rust_helper_init_srcu_struct() be a wrapper for __init_srcu_struct()=0D
> in this file, then just define __init_srcu_struct() as a wrapper around=0D
> init_srcu_struct() in the !CONFIG_DEBUG_LOCK_ALLOC leg of the #ifdef=0D
> in include/linux/srcu.h.=0D
=0D
Sure, sounds good to me.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> =0D
> As a historical note, I didn't much like this rule 25 years ago, but=0D
> tried a new project both ways, and quickly abandoned the one that used=0D
> #ifdef with abandon.  So I quickly came around to the Linux-kernel way=0D
> of thinking on this particular point, anyway.  ;-)=0D
> =0D
> 							Thanx, Paul=0D
> =0D
> > +__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)=
=0D
> > +{=0D
> > +	return srcu_read_lock(ssp);=0D
> > +}=0D
> > +=0D
> > +__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ss=
p, int idx)=0D
> > +{=0D
> > +	srcu_read_unlock(ssp, idx);=0D
> > +}=0D
> > +=0D
> > +__rust_helper void rust_helper_srcu_barrier(struct srcu_struct *ssp)=0D
> > +{=0D
> > +	srcu_barrier(ssp);=0D
> > +}=0D
> > +=0D
> > +__rust_helper void rust_helper_synchronize_srcu_expedited(struct srcu_=
struct *ssp)=0D
> > +{=0D
> > +	synchronize_srcu_expedited(ssp);=0D
> > +}=0D
> > -- =0D
> > 2.51.2=0D
> > =0D
