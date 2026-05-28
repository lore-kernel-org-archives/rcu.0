Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3B2C11D9;
	Thu, 28 May 2026 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977886; cv=none; b=tjzf10y7e5ADWqwDYeiJ3+uRKt/+6kkGaG4AIhQWLs6wtHGHLX3w+feOJd23sMGJ0dmJC7VZgEksfCDBLSdMkjstgG47Yc1ICS9K8tvnCQuOUZDW9d22kFm/AOci8xFE5L4OeNu2b2dFG/rF/ZSUO4cr7vVOge2lfFOnuLVneXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977886; c=relaxed/simple;
	bh=Kh71jckMhPwexKKfMOFVe1qt6F/rTrq/TYX/0V0ajAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yldpw45m9ycUsEXPfpQe+N9xFPUUP0ddao/Pog8PDEdxEobSm6y/GunvLRnmSzV0N1TYLoNgwZmteCvX6tHX9AUU2P+hszt9NQmzR0AUDrJnm5ixmjHVcKzADBW6oQIz+yp6v51AXDVwjyFSdwgsjWW5DE7lcue2X/Xw8+nLbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnIu/eHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnIu/eHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA2D1F000E9;
	Thu, 28 May 2026 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779977881;
	bh=F6+dLjOo5LxUsB/HbhRhsmzidHOsFznhMXG/VVegOY4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=fnIu/eHbYkyBWIRqGntTWV0Q8TsjN5I53ZCdMIpSEnvU7zKv3cq/ZYdITXn6bCzbH
	 lKi+sYXgW9a8nTdLhasBQfQTAfjGVt79cpZGo1N9n3AWyfBmEr/7Q96EqmMR9+8giJ
	 QUvkCJKgg+wFuEcLG2ADjLF3TwbsuFEPO1U3V4tlmOFxl02FysSXDzLQcU53qdGGzc
	 xdK0NYpNZ/QBsk41aEB3HL2q+VIrjsYfDH3PCwqjmncDQTbCbVpWIvuNMdEhvs9gOv
	 GjRC+6gdeedXmpizoMv3elCsvttm9YYa527f/2MX07RWoPLkOrx/WJ84/0quCKhWNX
	 jqd7QBkYWcblA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B4AFCE00BE; Thu, 28 May 2026 07:18:01 -0700 (PDT)
Date: Thu, 28 May 2026 07:18:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v5 1/4] rust: helpers: add SRCU helpers
Message-ID: <c6e129a5-e34a-45cd-8e87-8e0ac6a7000f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260527174120.510447-1-work@onurozkan.dev>
 <20260527174120.510447-2-work@onurozkan.dev>
 <05906890-cf06-414c-a625-02f9d7150d57@paulmck-laptop>
 <ahffdv0RpIhhagc4@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahffdv0RpIhhagc4@google.com>

On Thu, May 28, 2026 at 06:23:50AM +0000, Alice Ryhl wrote:
> On Wed, May 27, 2026 at 04:03:30PM -0700, Paul E. McKenney wrote:
> > On Wed, May 27, 2026 at 08:40:42PM +0300, Onur Özkan wrote:
> > > Add helper wrappers for SRCU functions that are exposed to Rust
> > > through generated bindings.
> > > 
> > > Signed-off-by: Onur Özkan <work@onurozkan.dev>
> > > ---
> > >  rust/helpers/helpers.c |  1 +
> > >  rust/helpers/srcu.c    | 34 ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > >  create mode 100644 rust/helpers/srcu.c
> > > 
> > > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > > index 625921e27dfb..f3562d3b3888 100644
> > > --- a/rust/helpers/helpers.c
> > > +++ b/rust/helpers/helpers.c
> > > @@ -88,6 +88,7 @@
> > >  #include "signal.c"
> > >  #include "slab.c"
> > >  #include "spinlock.c"
> > > +#include "srcu.c"
> > >  #include "sync.c"
> > >  #include "task.c"
> > >  #include "time.c"
> > > diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> > > new file mode 100644
> > > index 000000000000..79dd24a104ef
> > > --- /dev/null
> > > +++ b/rust/helpers/srcu.c
> > > @@ -0,0 +1,34 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/srcu.h>
> > > +
> > > +__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
> > > +							const char *name,
> > > +							struct lock_class_key *key)
> > > +{
> > > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +	return __init_srcu_struct(ssp, name, key);
> > > +#else /* !CONFIG_DEBUG_LOCK_ALLOC */
> > > +	return init_srcu_struct(ssp);
> > > +#endif /* CONFIG_DEBUG_LOCK_ALLOC */
> > > +}
> > 
> > Similar to Boqun's feedback on a later patch, could you please make
> > these be two functions under the corresponding legs of the existing
> > CONFIG_DEBUG_LOCK_ALLOC #ifdef in include/linux/srcu.h?  You are including
> > that file above, so it should work well.
> > 
> > Actually, you could just name thefunction __init_srcu_struct(), use the
> > existing definition under #ifdef CONFIG_DEBUG_LOCK_ALLOC, and just create
> > the simple wrapper in the other leg of this #ifdef.  That would be more
> > aligned with the Linux-kernel coding guidelines and also be less code.
> > 
> > Or is the "rust_helper_" prefix mandatory?  If so, you could make
> > rust_helper_init_srcu_struct() be a wrapper for __init_srcu_struct()
> > in this file, then just define __init_srcu_struct() as a wrapper around
> > init_srcu_struct() in the !CONFIG_DEBUG_LOCK_ALLOC leg of the #ifdef
> > in include/linux/srcu.h.
> 
> The rust_helper_ prefix helps avoid duplicate symbol errors.
> 
> When you invoke `bindings::foo` then it will prefer to call the symbol
> actually called `foo()`, but if there is no `foo` symbol, then it will
> fall back to `rust_helper_foo()`.
> 
> This is useful because many symbols are only marked inline under some
> configurations, and this makes it automatically pick the right one
> depending on whether the real symbol exists or not.

Thank you both for the Rust-bindings tutorial!  ;-)

							Thanx, Paul
