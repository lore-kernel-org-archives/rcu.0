Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04373655CD;
	Wed, 27 May 2026 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923012; cv=none; b=BCBn+B3lmhGysUIJyG3MxXA99VBjQKNwOoItiXxm2+0BAT/tKi9yR+cQeZtNMMNlUsbuf1VurAr7bGeA4jW5Ed4xMRPNTSmWmxf4vPATBpPseYdYssIusL4g3zaH64x/b1gCYy5sS5HOL4DZv5MDDkAYOuonyfLQEZ/QkbHEhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923012; c=relaxed/simple;
	bh=wfEUeu4ZzJ1hxxYE1kLhkFuK/5RPsNwR1geO+WOxNXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uujkHU8qw/Sd6c8bNMeSzb8QLXfLBTfEmLWYVx+U7nm5YAHUszCPzDIcRBTUzW5pvzMRd6LqRGPneu3tjP8islSadMcJG4Tnj4Yf+8pYNXtSrL8MZzJTOLyQKuCyeyzBZ7f8KZs/d7IOoO2sBYEnKXtIjCjKUIAS30ehpXZzLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu5apb+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu5apb+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851281F000E9;
	Wed, 27 May 2026 23:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923010;
	bh=0lx+p4+BcxVry9iZ7s0HAhOQYV/TdFRVTqoUrX3PG3c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Lu5apb+5c48DguSpldx1x3ai0d4GHZijdnizBbjJIV/E0DfSGB2Q4KGnlgtUQC8a4
	 kVc+zf4IdnxoI4FHyzvwCFswrUgb2gkvPiZkffa6E4EdBtFrZjgh7X5C7vF5igU2ik
	 C0Q1k70SEWle8Uk4xSBrAOhf4f76lIQzMWZXBuknftnEosW2IoWkRElJePTCJGk/CB
	 y/4NBl/DYXff/hunac/Cckh4NLlaEOsuB2k6V5FMeYTUjwc84n3H2IctXXDjaMtury
	 wnJ8IMtDUXXk2wKJ8AawztAmgtf4ym0im6wiPpJXq0u3M9oQgEaMo1m3QTY1JhS1bJ
	 Bu0OXJIXnUcdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3CAFACE10CD; Wed, 27 May 2026 16:03:30 -0700 (PDT)
Date: Wed, 27 May 2026 16:03:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, fujita.tomonori@gmail.com,
	tamird@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v5 1/4] rust: helpers: add SRCU helpers
Message-ID: <05906890-cf06-414c-a625-02f9d7150d57@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260527174120.510447-1-work@onurozkan.dev>
 <20260527174120.510447-2-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527174120.510447-2-work@onurozkan.dev>

On Wed, May 27, 2026 at 08:40:42PM +0300, Onur Özkan wrote:
> Add helper wrappers for SRCU functions that are exposed to Rust
> through generated bindings.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/srcu.c    | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 rust/helpers/srcu.c
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 625921e27dfb..f3562d3b3888 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -88,6 +88,7 @@
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"
> +#include "srcu.c"
>  #include "sync.c"
>  #include "task.c"
>  #include "time.c"
> diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> new file mode 100644
> index 000000000000..79dd24a104ef
> --- /dev/null
> +++ b/rust/helpers/srcu.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/srcu.h>
> +
> +__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
> +							const char *name,
> +							struct lock_class_key *key)
> +{
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	return __init_srcu_struct(ssp, name, key);
> +#else /* !CONFIG_DEBUG_LOCK_ALLOC */
> +	return init_srcu_struct(ssp);
> +#endif /* CONFIG_DEBUG_LOCK_ALLOC */
> +}

Similar to Boqun's feedback on a later patch, could you please make
these be two functions under the corresponding legs of the existing
CONFIG_DEBUG_LOCK_ALLOC #ifdef in include/linux/srcu.h?  You are including
that file above, so it should work well.

Actually, you could just name thefunction __init_srcu_struct(), use the
existing definition under #ifdef CONFIG_DEBUG_LOCK_ALLOC, and just create
the simple wrapper in the other leg of this #ifdef.  That would be more
aligned with the Linux-kernel coding guidelines and also be less code.

Or is the "rust_helper_" prefix mandatory?  If so, you could make
rust_helper_init_srcu_struct() be a wrapper for __init_srcu_struct()
in this file, then just define __init_srcu_struct() as a wrapper around
init_srcu_struct() in the !CONFIG_DEBUG_LOCK_ALLOC leg of the #ifdef
in include/linux/srcu.h.

As a historical note, I didn't much like this rule 25 years ago, but
tried a new project both ways, and quickly abandoned the one that used
#ifdef with abandon.  So I quickly came around to the Linux-kernel way
of thinking on this particular point, anyway.  ;-)

							Thanx, Paul

> +__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
> +{
> +	return srcu_read_lock(ssp);
> +}
> +
> +__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ssp, int idx)
> +{
> +	srcu_read_unlock(ssp, idx);
> +}
> +
> +__rust_helper void rust_helper_srcu_barrier(struct srcu_struct *ssp)
> +{
> +	srcu_barrier(ssp);
> +}
> +
> +__rust_helper void rust_helper_synchronize_srcu_expedited(struct srcu_struct *ssp)
> +{
> +	synchronize_srcu_expedited(ssp);
> +}
> -- 
> 2.51.2
> 
