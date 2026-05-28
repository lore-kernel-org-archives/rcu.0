Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B61940B0
	for <rcu@vger.kernel.org>; Thu, 28 May 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949436; cv=none; b=orKieouG6dJql369inUk4dg6Y1UezTABC9W0cmtKfnc2unznpKJJcL3x301iQkSu57AGjucSOLTpYIrpnLFi4b2fwynp/uIHkNapo2U2JRb/0u3jf+CnwFZr67nJrl/cqRTl741OMNsHKGeJvj2jtlaJSIh3Pn1peVr1S0R3VUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949436; c=relaxed/simple;
	bh=TcgAg/TWpzmu+ozz5FEbeE+LZILi325DiXMDhIfXZ7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8e5FCUqvQsVnLzemUXjTUqTuEEtgpe/mdqc5V3bD9Ve0Y7WAinRImwW9m5ua1rs4UP71YRTfkhgGceYHXkt0SmtUD2v/hIQh+jcOMyqhY1O2dxwoQCuvWrHI5RPVujPFFs0oM74J94gBQKd5LsbeEzSGue+E16615XJ1lM+qUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFzehVG/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFzehVG/"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4904bbc6094so45418725e9.3
        for <rcu@vger.kernel.org>; Wed, 27 May 2026 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779949432; x=1780554232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFCTgxqHq2LzluJ+gBY4/IZyu9HSyEIvpy5GM7es4Ws=;
        b=OFzehVG/3eMQstEOGCtUwIJEF9hIg4aXg572HEWRqMY+2rYu0Hvwx1o51zXZtbs51D
         35AFATOuE5ohB+BhCQ/DpIJ6xIO8mdpQ8v7n7wX45qvYXRgmKEpTS/aUNaVdapyednBD
         coWmu88J2TTUrBc90LsIY6mA+YVR8G6+X5i7BMAhV8b1pxYn/yAL8Dk5ZNc8/nG1gNdQ
         pw/X583HK0wmptksH8v+hCP9cwS5fFdArE2hou7URcbneg1BzbdDJpRBa1gVkuiPLxh0
         ud3ep67Mmty3xcH5HKCAUngUC/JdN0EeNNghDP2YAySCdjrTy0ttBLnJT7b6/ACg9iKA
         VR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779949432; x=1780554232;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RFCTgxqHq2LzluJ+gBY4/IZyu9HSyEIvpy5GM7es4Ws=;
        b=PjrEaijYElBCDwKCXYIG5X2+x9vPU0L290Tqt3YVcWRkmd5pkTmxhmBpdYPbM9qy2O
         AzsXjh1yobcv+7/hWBkVihPuvLvgXtti+9SaV/HKG7jjFx6Eq6gphSnPOa5Nlzcu4tus
         CiagL46YaRWj4Fko3R/OJk4Y69I6NTQWvX/YQ9RkF75KmuV1/GNxiyLBiqVPm94bnZFa
         RcgUIj7EH8ERfbt6Bw1zxgG1ybjB+orswRt1POZ97t8ZeJYVfim4QTVzsFNm++j/wJJ+
         fHDUwz4OAB5DYR50aBqTBFDOMaOBiwTpTmdjjkkMufCAQn9UoUBeVsc+vcCDnYs7IATe
         b2EA==
X-Forwarded-Encrypted: i=1; AFNElJ/aBGGiK1vkHIIpw4EvpgPemr2NbTcjIe0X3yPg9YaOHhmq2IpDNN3t1IT5kRgbY5i1A4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4aIkz6ZCTgzvawkZx0xZy7cYlYLwES6n93+khwxfEN+J0i+n
	JHYy3j2ewtcpeXFny2ogaPSpZeH4JYNLPWBmXQRd3e849UhzAfzFGerL9Og+E8XwAfreqDS4XCA
	AaK7ZtGvZtSAyZRxzeg==
X-Received: from wmnl21.prod.google.com ([2002:a05:600c:16d5:b0:490:25ec:da5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b29:b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490546687c1mr329106895e9.12.1779949432014;
 Wed, 27 May 2026 23:23:52 -0700 (PDT)
Date: Thu, 28 May 2026 06:23:50 +0000
In-Reply-To: <05906890-cf06-414c-a625-02f9d7150d57@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527174120.510447-1-work@onurozkan.dev> <20260527174120.510447-2-work@onurozkan.dev>
 <05906890-cf06-414c-a625-02f9d7150d57@paulmck-laptop>
Message-ID: <ahffdv0RpIhhagc4@google.com>
Subject: Re: [PATCH v5 1/4] rust: helpers: add SRCU helpers
From: Alice Ryhl <aliceryhl@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, rcu@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	peterz@infradead.org, fujita.tomonori@gmail.com, tamird@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 04:03:30PM -0700, Paul E. McKenney wrote:
> On Wed, May 27, 2026 at 08:40:42PM +0300, Onur =C3=96zkan wrote:
> > Add helper wrappers for SRCU functions that are exposed to Rust
> > through generated bindings.
> >=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> >  rust/helpers/helpers.c |  1 +
> >  rust/helpers/srcu.c    | 34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 rust/helpers/srcu.c
> >=20
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 625921e27dfb..f3562d3b3888 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -88,6 +88,7 @@
> >  #include "signal.c"
> >  #include "slab.c"
> >  #include "spinlock.c"
> > +#include "srcu.c"
> >  #include "sync.c"
> >  #include "task.c"
> >  #include "time.c"
> > diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> > new file mode 100644
> > index 000000000000..79dd24a104ef
> > --- /dev/null
> > +++ b/rust/helpers/srcu.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/srcu.h>
> > +
> > +__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_st=
ruct *ssp,
> > +							const char *name,
> > +							struct lock_class_key *key)
> > +{
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	return __init_srcu_struct(ssp, name, key);
> > +#else /* !CONFIG_DEBUG_LOCK_ALLOC */
> > +	return init_srcu_struct(ssp);
> > +#endif /* CONFIG_DEBUG_LOCK_ALLOC */
> > +}
>=20
> Similar to Boqun's feedback on a later patch, could you please make
> these be two functions under the corresponding legs of the existing
> CONFIG_DEBUG_LOCK_ALLOC #ifdef in include/linux/srcu.h?  You are includin=
g
> that file above, so it should work well.
>=20
> Actually, you could just name thefunction __init_srcu_struct(), use the
> existing definition under #ifdef CONFIG_DEBUG_LOCK_ALLOC, and just create
> the simple wrapper in the other leg of this #ifdef.  That would be more
> aligned with the Linux-kernel coding guidelines and also be less code.
>=20
> Or is the "rust_helper_" prefix mandatory?  If so, you could make
> rust_helper_init_srcu_struct() be a wrapper for __init_srcu_struct()
> in this file, then just define __init_srcu_struct() as a wrapper around
> init_srcu_struct() in the !CONFIG_DEBUG_LOCK_ALLOC leg of the #ifdef
> in include/linux/srcu.h.

The rust_helper_ prefix helps avoid duplicate symbol errors.

When you invoke `bindings::foo` then it will prefer to call the symbol
actually called `foo()`, but if there is no `foo` symbol, then it will
fall back to `rust_helper_foo()`.

This is useful because many symbols are only marked inline under some
configurations, and this makes it automatically pick the right one
depending on whether the real symbol exists or not.

Alice
