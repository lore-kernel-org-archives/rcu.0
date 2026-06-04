Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546737702A;
	Thu,  4 Jun 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598461; cv=none; b=VBpMThSVpbQQwrDaN3i7llfNSkrTDfIth2Wg7nLITGH/N9O98Sy52vErl6VkZL35yOhMRGyBmgd4zcxZnKeJrLn60IDaAbq8WXIDKRDxi7pklDV8Ptb4UtmrS9JNfekOhhJORKuPq/LcZm3KQsGZ2SUegjjd5rEYFTGeQ+g+acE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598461; c=relaxed/simple;
	bh=FBR7XtEG6MB9m06M9SbJMgYfqt2bCVlstrwkBb0PVjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/t7W9hEa0BplfKKTClYNkMxp/if0YvZyzKo39lpzV2m1Caq+Qwnj7RvYs/zHoFtzGAP1acfAgSfg7aIbsXP2QfK2RcB9YXBdg7TeFeC1hoSDzd6SVKPDm+6MSK+BtV/NKqwXt+uafUQwZ6WNvY6vqSUKD4c73/JQdGo+7Tn3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDIZEU51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDIZEU51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38FC1F00893;
	Thu,  4 Jun 2026 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780598459;
	bh=1yaK+TkgohSKgFcKopUCyuSH71lXoPphoiSqw+5WXhA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=dDIZEU51OFQG+RLLfVc12G6/5XfEkmnpKO3EWOP4OdWjOajxgASsVc9DgVwQJqGr4
	 j5ks97EEHDaDC2rf0UAopOKpGDy2rlaKyfL5ngvtAI9UT8Zq2zg7Cufmw0py8QQrdU
	 5RikY2y/eIJClnFe9oXqBc0KNvbtblOvnim9mtkaCE4Tf6x2gk0Mo3dBUa00nVZlku
	 g/hg0Hvao6sELW/aLUk5mlXgn94d3QtGJmXxZqMygCCOgUTMhUu1WXKCPbyRfEhiKj
	 6aRFzyzffPpn4AHlToVlygccaaT4Kq0z1J7LMGZfJNWmj0tUePy/6kWLpPvOoNrMvx
	 pK+TRQw2wAWmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54616CE0555; Thu,  4 Jun 2026 11:40:59 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:40:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, fujita.tomonori@gmail.com,
	tamird@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v9 1/4] rust: helpers: add SRCU helpers
Message-ID: <5d82d96f-5dbb-46bd-b34b-25411be157ce@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260529134004.396743-1-work@onurozkan.dev>
 <20260529134004.396743-2-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BbNVR7QFd503bRKP"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529134004.396743-2-work@onurozkan.dev>


--BbNVR7QFd503bRKP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 29, 2026 at 04:39:51PM +0300, Onur Özkan wrote:
> Add helper wrappers for SRCU functions that are exposed to Rust
> through generated bindings.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> 
> ---
>  include/linux/srcu.h   | 29 ++++++++++++++++++++---------
>  kernel/rcu/srcutiny.c  | 10 +++++-----
>  kernel/rcu/srcutree.c  |  9 +++++----
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/srcu.c    | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 61 insertions(+), 18 deletions(-)
>  create mode 100644 rust/helpers/srcu.c

On the next version, please split the rust/helpers changes into a
separate patch.  It looks like the simplification to SRCU adds code
rather than deleting it?

But let me see if I understand the structure.

> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 81b1938512d5..a028a5b5ebef 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -25,20 +25,19 @@ context_lock_struct(srcu_struct, __reentrant_ctx_lock);
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
> -int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
> +int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
> +				     struct lock_class_key *key);
> +static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
> +				     struct lock_class_key *key)
> +{
> +	return init_srcu_struct_lockdep(ssp, name, key);
> +}

__init_srcu_struct() invokes init_srcu_struct_lockdep()...

>  #ifndef CONFIG_TINY_SRCU
>  int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
>  int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
>  				   struct lock_class_key *key);
>  #endif // #ifndef CONFIG_TINY_SRCU
>  
> -#define init_srcu_struct(ssp) \
> -({ \
> -	static struct lock_class_key __srcu_key; \
> -	\
> -	__init_srcu_struct((ssp), #ssp, &__srcu_key); \
> -})

init_srcu_struct() invokes __init_srcu_struct()...  (moved)

>  #define init_srcu_struct_fast(ssp) \
>  ({ \
>  	static struct lock_class_key __srcu_key; \
> @@ -56,7 +55,12 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
>  #define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
> -int init_srcu_struct(struct srcu_struct *ssp);
> +int init_srcu_struct_generic(struct srcu_struct *ssp);
> +static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
> +				     struct lock_class_key *key)
> +{
> +	return init_srcu_struct_generic(ssp);
> +}

__init_srcu_struct() invokes init_srcu_struct_generic()...

>  #ifndef CONFIG_TINY_SRCU
>  int init_srcu_struct_fast(struct srcu_struct *ssp);
>  int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
> @@ -65,6 +69,13 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
>  #define __SRCU_DEP_MAP_INIT(srcu_name)
>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
> +#define init_srcu_struct(ssp) \
> +({ \
> +	static struct lock_class_key __srcu_key; \
> +	\
> +	__init_srcu_struct((ssp), #ssp, &__srcu_key); \
> +})

...and here is where it moved to.

> +
>  /* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used by rcutorture. */
>  #define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().
>  #define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index a2e2d516e51b..780a95e8cad7 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -48,15 +48,15 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  
> -int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
> -		       struct lock_class_key *key)
> +int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
> +		     struct lock_class_key *key)
>  {
>  	/* Don't re-initialize a lock while it is held. */
>  	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
>  	lockdep_init_map(&ssp->dep_map, name, key, 0);
>  	return init_srcu_struct_fields(ssp);
>  }
> -EXPORT_SYMBOL_GPL(__init_srcu_struct);
> +EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);

init_srcu_struct_lockdep() invokes init_srcu_struct_fields()...

>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
> @@ -68,11 +68,11 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct);
>   * to any other function.  Each srcu_struct represents a separate domain
>   * of SRCU protection.
>   */
> -int init_srcu_struct(struct srcu_struct *ssp)
> +int init_srcu_struct_generic(struct srcu_struct *ssp)
>  {
>  	return init_srcu_struct_fields(ssp);
>  }
> -EXPORT_SYMBOL_GPL(init_srcu_struct);
> +EXPORT_SYMBOL_GPL(init_srcu_struct_generic);

init_srcu_struct_generic() invokes init_srcu_struct_fields()...

>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0d01cd8c4b4a..45154630c54e 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -266,12 +266,13 @@ __init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock
>  	return init_srcu_struct_fields(ssp, false);
>  }
>  
> -int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
> +int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
> +			     struct lock_class_key *key)
>  {
>  	ssp->srcu_reader_flavor = 0;
>  	return __init_srcu_struct_common(ssp, name, key);
>  }
> -EXPORT_SYMBOL_GPL(__init_srcu_struct);
> +EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);

init_srcu_struct_lockdep() invokes __init_srcu_struct_common()...

>  int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
>  {
> @@ -301,12 +302,12 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
>   * to any other function.  Each srcu_struct represents a separate domain
>   * of SRCU protection.
>   */
> -int init_srcu_struct(struct srcu_struct *ssp)
> +int init_srcu_struct_generic(struct srcu_struct *ssp)
>  {
>  	ssp->srcu_reader_flavor = 0;
>  	return init_srcu_struct_fields(ssp, false);
>  }
> -EXPORT_SYMBOL_GPL(init_srcu_struct);
> +EXPORT_SYMBOL_GPL(init_srcu_struct_generic);

init_srcu_struct_generic() invokes init_srcu_struct_fields()...

This gets me the structure shown in the attached PDF.  Did I get it
right?

I am surprised not to see any changes involving cleanup_srcu_struct().
What did I miss?

And again, please put the following in a later patch to allow separate
evaluation of the restructuring.

							Thanx, Paul

>  /**
>   * init_srcu_struct_fast - initialize a fast-reader sleep-RCU structure
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
> index 000000000000..225b3bf9334a
> --- /dev/null
> +++ b/rust/helpers/srcu.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/srcu.h>
> +
> +__rust_helper int rust_helper_init_srcu_struct_with_key(struct srcu_struct *ssp,
> +							const char *name,
> +							struct lock_class_key *key)
> +{
> +	return __init_srcu_struct(ssp, name, key);
> +}
> +
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

--BbNVR7QFd503bRKP
Content-Type: application/pdf
Content-Description: init_srcu_struct.pdf
Content-Disposition: attachment; filename="argh.pdf"
Content-Transfer-Encoding: base64

JVBERi0xLjUKJbXtrvsKNCAwIG9iago8PCAvTGVuZ3RoIDUgMCBSCiAgIC9GaWx0ZXIgL0Zs
YXRlRGVjb2RlCj4+CnN0cmVhbQp4nN1YTW8bNxC981ewN+lgmsNvAoaBKi0KBMihrW9JUASK
nLqV3TQfaPvv+2bI5a4ry9GhaYvCkLXD3SFnZ97MvBFpi78zwr9gg97eql+VlbXvvtHnr6x+
816R/g1rT/H5ST1/qa2x+rUiq5/p5JNJ5DV5q28XUjU1kI45mUxVUyg6WmeKT3K91cEVU6MX
yadqbKxqqPUF2XQ7S87K91AlN2+K6+10nBJx2NLVlpZu9ff9Hd+90ZsrRcFYa10I3RdDDDZj
/1h9gZ43qVaH17m6VefXZ/bMatJX1+r56oc1lfbv5u7mw/rM1Sa9x6VfvVufhdV27eLqI1Zr
X+XHcrv3ETcTFhSvvFitKa72v6zJsVJY/bymvHq9PvOr3dsX6/XLq6fq66s5RClaA5856zgA
XSBq/i/B+KCds8NTfM3uJ+O75GM0Ljk1tPqCbLkdElXX3d9UqYTZ/bjeTqcplrohk9LCyJN9
72vGQeJ7Z+NR3x963A2PhwOPp9njsYeA9ZQ4nFqU7jlcotEevLn7A99x9UAQFuA23kZEYqzE
ZCylWU5wZ6mznL0pJd93y2Lf1JzNT9V7+5a2steh1nvP7PWP6lBvo7zPJpLrSBlSD7rLFt9R
EEGlLLBC2Cu7LFKwhlKYodLkHtcuTDGf9BgO044NKNNZkNQwZFJbmnkyVor7b0FFNHe79YNg
CVyJHFfFaHIsHIySTEXqMFjgIU/F5MDRg0t81S4lE3KWmKdKR7DiUjYEp1HBt8/Y1mG7mFG6
SgQKCpDhgL62YgWnjJVDvY3KuRhCsXQ5QB4SzueoZ8ILRISooswi6oKVKhUY+9t2I1pvopSV
rtUXZM/tLKUgYZ80Y5q3xPV2HKZYHJZ0raWdJ4MlBj/QkvPnRAtH/vz7t6/u9MWFPv9y++Hj
q/3V7vcP+uJ6d31tbUr41Et9eak3Xz1p51M//+KSygUspkvBz7MnfzGPjdit/Wr/ms9thswQ
TI9WKw8UMK6oGjgRRSUGg0bsXDWEagGEIAURgIBSD7zFiuyF41wk9tYR/OFdTIyoIKiBCfFG
N+LuCX3GIde8PXZCTUe1cziQqx7j71BvowJOdjZ3/A2pI8knMIBEAjOX6wJ/VC0YQBSJkEUh
xRmAfaGDZUgdSkMVMBubCgL7cUrEYUtXW1p6MgIp+YlWPIbAv5NWiKIgF9XLr27XZ5T6f1m4
Y+ykGcpRwLV7AD2OkJ4pC3q4iqPOONfwwszM4hsFrnJskMg2IDtDNSk7+c71WK9jdFUuASEb
W4vUL/YNhyQiAIwfvpc848cBK71+HeihfgFL2Xkt1XUSUOeketnCYM8oNLF1pcxRTraBH0JM
jWE2BTXkWKTENQGbCrPpasGO7QJ3zX4Krqfjm4LSC9tOL1m189CsE32+iiUYUA+VjOSAWAev
BSRJy23Y4UiD83FoI1pVQnrAThE5lz3INnshHKsYEXiohHQAm2i7oioZEE4m8ELWUTE4qgG9
D33du9DYzYHeRlUgIvCaDCKz1CaKguQu1IaPArfOg0j2CBqfCCkhF4UJT2p9oc8MQ+oTxVAF
WxmbyiDSj2uDyLClqy0tPRkA3AX/lUHkC0HKoDz3xhEUiLd88RBeKvASFnjhF7Bx4CWD+zAt
7njJPOP5+gm8ZPDG5OLAQmMmntICLxlJmzlIHRuMl0M94IXzyNbOhofUeS04szAm5rxTaBsb
zvB+zo0NJ5QCu5yc+kLnrpM0MdtJlUnwwIsQ4n6cEnGyZVJbWno6XmwdHebzM+I3u7vdOrS7
N7jrVnM3eXRuWuRin5vGSp+bhtznpiE/OjcVNPf788/s8GlKKkQHc9Oh3kYBSUGGV+EiQ5pI
hWXTgzCOmtKCixSwbt+lgl7plmS4L3TaMKROKoYqV9RpU+Ei/bjGRYYtE4VZWHr66JToH2LD
n0bKo2NTtcwiGCveOOLYVCRUcIwVwuzgUVlTK9CgVzwy1GwXSVbh+ugyXGdJmF4t1MYrlyTY
NUOd2QrYxtEaVEENozyFaSlL7QBWArMesJTiAKOKXphr28hhjGNgHarxkBUaPUL0hfdm9DW+
yTw8EIonoeFYVnIGsUFRtXwCk59ydAzEgNjIMTvD8jiX8J4+C7OV8XGPFbRZJvxMyHqRPNSD
hfAMtyqPt4B5k8R0TKpdkKbqMfTHPuDzNTgSyjF3RpYCgiPQn9T6gmy6nSWf2hw4qYJsjE1d
kXIaWlNlcdjS1ZaWnv7rHvuzsSrPFPX/OQjOZH79YKsuAAOjsLSfkVAqXftBwGMwK8BNBhuK
aN2emGCDBqF1W7gaKGX4HoEhnuLO7D1mAzx12+LHP/d6a6rjtEg9AbxDh2p5cqi2UZ5JP6MV
4fKJ13xtv+V6ZHJgLp6c/JICTbwKgENeBlePNzmaKBFAYDaAD6ZhYZ8gudyF2EKKnMqMRm7Z
3iOFYm3s80Bvo75VfwL4x8b1CmVuZHN0cmVhbQplbmRvYmoKNSAwIG9iagogICAxODM0CmVu
ZG9iagozIDAgb2JqCjw8CiAgIC9FeHRHU3RhdGUgPDwKICAgICAgL2EwIDw8IC9DQSAxIC9j
YSAxID4+CiAgID4+CiAgIC9Gb250IDw8CiAgICAgIC9mLTAtMCA2IDAgUgogICAgICAvZi0w
LTEgNyAwIFIKICAgPj4KPj4KZW5kb2JqCjIgMCBvYmoKPDwgL1R5cGUgL1BhZ2UgJSAxCiAg
IC9QYXJlbnQgMSAwIFIKICAgL01lZGlhQm94IFsgMCAwIDExNTQgNDA0IF0KICAgL0NvbnRl
bnRzIDQgMCBSCiAgIC9Hcm91cCA8PAogICAgICAvVHlwZSAvR3JvdXAKICAgICAgL1MgL1Ry
YW5zcGFyZW5jeQogICAgICAvSSB0cnVlCiAgICAgIC9DUyAvRGV2aWNlUkdCCiAgID4+CiAg
IC9SZXNvdXJjZXMgMyAwIFIKPj4KZW5kb2JqCjggMCBvYmoKPDwgL0xlbmd0aCA5IDAgUgog
ICAvRmlsdGVyIC9GbGF0ZURlY29kZQogICAvTGVuZ3RoMSA3MDQ0Cj4+CnN0cmVhbQp4nNVY
e1xU150/5/7umffcxzxheMwMCCMwwDiIiM+rokk0MVaNRRMCKgIOGrG+UQJJ4yMRRJTgIyQQ
Y0lr24g2SYmaiikxT+u2MU2ysd20koddwqfduv0Yi5f93Rk06e52/+zu3sOdc8/7e37n+/ue
cyCUEGIiDQSIb/nqpTUfe5++SYjUQAi3ZPnG9b7mvB9eI8R2mRDaWlFTufrzhj/1EeKowVa7
K1dtqajMdG3B7x8RIl6qWrG0PKVN3YPlQ5g3rgozbD5zLyHOsZgeVbV6/eb7s/UVmC7G9MJV
a5YvJaT9C0xje1K8eunmGn4dyyPExWPaV/OdFTUbtuj+gulRhLAHCUcq1Da+gh1FtHriUSz8
G0T3BjWwEo4nuX2XBsYQ6dLApYGQXfbLaX7ZX8GToXWQMPSp2qYXrv/bd3QZBOerJvFEXY19
iC+RHZQnXO670YYh6vTnYwssnDcPAeB4s/GnjF0hZuIkdyluMNpqHe2SpVYgoLMGLQG7GJRD
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
y7c30az/sw/53wbwPz64i/wHLvCfDAplbmRzdHJlYW0KZW5kb2JqCjkgMCBvYmoKICAgNDk5
NAplbmRvYmoKMTAgMCBvYmoKPDwgL0xlbmd0aCAxMSAwIFIKICAgL0ZpbHRlciAvRmxhdGVE
ZWNvZGUKPj4Kc3RyZWFtCnicXZLNboMwDMfveQofu0NFSFfYJIQ0dRcO+9DYHgASp4s0QhTo
gbefE1edtAP4F/vvDxyKU/fcebdC8R5n3eMK1nkTcZkvUSOMeHZelAqM0+v1lN96GoIoKLnf
lhWnzttZNA0UHxRc1rjB7snMI94JACjeosHo/Bl2X6eeXf0lhB+c0K8gRduCQUvlXobwOkwI
RU7ed4bibt32lPan+NwCgsrnkkfSs8ElDBrj4M8oGilbaKxtBXrzL6Ykp4xWfw9RNEdLUinJ
iKZ6zEyGGJmRuL7PTIb4wHxIrJhV0rO/yv4j+4/E6iEzGdJo1ujE3LfKfUfmMTH3qlKviutU
qU4tuaZMNXlOleasmes8s2G9SZqSNWXy1+yv80KuX55Wk+7wtnN9iZHWnS867zlt2Hm8/Qth
DikrP787+J19CmVuZHN0cmVhbQplbmRvYmoKMTEgMCBvYmoKICAgMzE3CmVuZG9iagoxMiAw
IG9iago8PCAvVHlwZSAvRm9udERlc2NyaXB0b3IKICAgL0ZvbnROYW1lIC9JUUxTU0orRGVq
YVZ1U2VyaWYKICAgL0ZvbnRGYW1pbHkgKERlamFWdSBTZXJpZikKICAgL0ZsYWdzIDMyCiAg
IC9Gb250QkJveCBbIC03NjkgLTM0NiAyMTA1IDExMDkgXQogICAvSXRhbGljQW5nbGUgMAog
ICAvQXNjZW50IDkyOAogICAvRGVzY2VudCAtMjM1CiAgIC9DYXBIZWlnaHQgMTEwOQogICAv
U3RlbVYgODAKICAgL1N0ZW1IIDgwCiAgIC9Gb250RmlsZTIgOCAwIFIKPj4KZW5kb2JqCjYg
MCBvYmoKPDwgL1R5cGUgL0ZvbnQKICAgL1N1YnR5cGUgL1RydWVUeXBlCiAgIC9CYXNlRm9u
dCAvSVFMU1NKK0RlamFWdVNlcmlmCiAgIC9GaXJzdENoYXIgMzIKICAgL0xhc3RDaGFyIDEy
MQogICAvRm9udERlc2NyaXB0b3IgMTIgMCBSCiAgIC9FbmNvZGluZyAvV2luQW5zaUVuY29k
aW5nCiAgIC9XaWR0aHMgWyAwIDQwMSAwIDAgMCAwIDAgMCAzOTAgMzkwIDAgMCAwIDAgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAw
IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCA1MDAgMCAwIDAgNTYw
IDY0MCA1OTEgMCA2NDAgMCAzMTkgMCA2MDUgMzE5IDk0OCA2NDQgNjAyIDY0MCAwIDQ3OCA1
MTMgNDAxIDY0NCAwIDAgMCA1NjQgXQogICAgL1RvVW5pY29kZSAxMCAwIFIKPj4KZW5kb2Jq
CjEzIDAgb2JqCjw8IC9MZW5ndGggMTQgMCBSCiAgIC9GaWx0ZXIgL0ZsYXRlRGVjb2RlCiAg
IC9MZW5ndGgxIDI1MTYKPj4Kc3RyZWFtCniczVRpbFTXFb5vvntm9YzfeJ7BBi9jj6fGeBtm
gLAY+mxMMTghDibEbhkwMNiOl2D2xZlk0gSxxWYJHZaQ1kmQ2pqGDq1KJ5i2JoWQKvKvQEOk
/kgkUJsIoaZNq2LBo2cGokqV2r/tPbrvnvU7y9V9QhFC2ERMQKjrtm3xHgyd+UoI5TLvo+19
Hb1/jH3JPFrY60BHz872uwNCZ/4U26d0rl8TKY4bg2y/ybqZnazI8jreEULmsVzS2btlh90n
EiynYqw9G9at4bgelhtYzuhds6NPtlGI5eUse/s2re/butP8d5a3CEGrhEm0G3HZTqe5OouY
pGfIq8J8VbFS2CRF9eVrt6cJ9drta7cDHneR21/kLmqX4t5mTL53y4hbXP/4yyZzmVDEEsYq
NWuiWET1aZY8kaPusopiebBw44QsF+y7JllPaRlKpXDOy/RUWDJLHRXClptd4baUTp4Y8Klf
1dwO3gxeu3zztnqT6c40UV1zJ3hnYtC48/v31TvBrNmzA7pNLaku2VAyVCKVsNKYyF7e8ivh
ezDK2X1M+iz3Y7NaldIqxVdszleK3KHsohkh99enb0ZoxvSZoeCEibJ6FXb1nxg0XT17//Nz
9788e/+LRCLxxa1nzreSWVnx9OCJyL0FXV1Ydu9s6tvdduWDSZOFYhebeVZJ8SHTR8w9LrrE
RrFHDDF/S/Sn9ZekNUWs+YRSvh+JpFLGfqYUKdU8f5P4NeOE2HaL/dtZHhJr0/ZxjKXpJMZM
24UJTcw1pSOGRBJzpcTYw52O+lDMExfEcIqnMRFnv2XiY6Y6Rl8iLopPlJfFaeW6iIoBsVmy
WeQrdrrOtXSJtXQ9TX8WK9OZU7ouus63NyS6uM+LjH76oV4pU5ahDe1KC3doUobRwNrdoku2
MZWmqT7d38MeTKZ+zv+oXzFmWmkqk6XKMOdJ5Rhj/GExj+tt50obeJtS9eNzMYQMrjCXLokl
liXmDMVsiYrlbO1HSDlpzhdtIorljLCUdQNiqfIxZxGaOG8mCZMiKrxqwuRfHEnoT7V4P2gt
qqz4N9GrWrwJ0ZRw7vQmHzxoapGTqTVBeQn4rQnp9332n4yfVVY0NrV4E79bWP8IdWFbPeua
W5hNSaxm/cL6Sn5yqbtalRz+U8Pg6syav4lCa2rq4g+tU1d/fd69cX+OesP6aeqdcidK2oG/
ll4jXwh3/t0b9/rUG4/0/1omyROjFak3ll71qf/Cw3wmmygXx9NoqjjB71dIh/JXlmXSFNM/
vWrgfQ+uXC6hKxFc0eXlEvzWifculdJ7EVwqxWgYv4niogMjDlx4V6MLQbyrIRnELw2cN/AL
Az838DMD5xKL6Nw4EovwUwNno3jHwE9cODOcQWc0DGfgx0H8KIIfFuB0EG+/FaG3DbwVwZtx
F73px9AOOw358YNGfF/FG1U4tbeAThl4/aRKr+fjpIoTx110wo/j7HfcheO6PMaBxzQci8m4
C3Fdfs+Po68E6KiB14546DU/jhx20hEPjiQVXbfJw4fsdNiJw0lF6IvlITsOjcqDG6J0cASD
Lzlo0I1BXQ4wNzAHrx4YoVcNHNgfpgMjOBCT+/f5aX8Y+3W5j+va58fePW7aW4C9yQej+gO5
x43dnHp3BK8E8PIEfDeOlxyIRSIUM/Bij0ov5uKFqIteCCLqwvP9mfS8B/2Z2BXHTjd22LF9
m5e2j2Pb1jza5sXWPGzhoC0F2Gxgk4GNfU7aaKDPiT5dbojiud759Fw3euejpzuDelT0xGR3
Brp12cUpu8bxbOcIPWugsyNMnSPojMmOdj91hNGhy3Y/1rPT+nFEIliXjbUG1hhoW11FbQZW
V2GVgbCBlY34ThTfNtBajxYDzxhYMYKnDTRHsEzDU0E0PZlJTVE8mYmltXodHndgSQSLi620
OI6GIBZBpUUefCsLC012WpiL+gUequ/GgjqVFnhQV+ugOhW1uo1qHdBt0FNzbJbfjGO+rKT5
T2BejUbzGlEz1041Gmp0OdeOObOzaE4Ys2e5aXYWZrnxmBMzDcyYrtEMA9NDHpquIRS0U8iD
4DQbBe0IPryfaTYEqnMoUI/qqmyqzkH1qKwqsFNVNqpistIWoco4Kso1qmhEOTdRrqFcl1O5
9KkRlE0JUFktpnBhUwIo5aPUwDfmwO/MIX8YJb4sKmmGj8N8WfDpstiKIm8OFYXhLXSTNwfe
UVnIyQrdKIzJAjsKdJnvQ14mJpdgUm6AJjUjl1FzA8gxMJGTTjQwQUW2plF2NzSPhzQNmi49
HmSxX9YI3DxetwGVD7UOmVx/ZhwutrkMOBnAmQOnLjMMOFhw6LO6YWcfexS2CKwWN1k1WNww
U5DMURDHURCSwWQlGNRkh9IMYUBJKpHdA0r5/+0S/+sC/uviv/U/AZ8pQSMKZW5kc3RyZWFt
CmVuZG9iagoxNCAwIG9iagogICAxODAxCmVuZG9iagoxNSAwIG9iago8PCAvTGVuZ3RoIDE2
IDAgUgogICAvRmlsdGVyIC9GbGF0ZURlY29kZQo+PgpzdHJlYW0KeJxdkM9qwzAMxu9+Ch3b
Q3HTcwiM7pLD/tBsD+DYcmZoZKM4h7z9ZDd0MIEtJH0/81n62r/2FDLoT452wAw+kGNc4soW
YcQpkGou4ILNe1VvO5uktMDDtmSce/JRtS3omwyXzBscXlwc8agAQH+wQw40weH7Ojxaw5rS
HWekDGfVdeDQy3NvJr2bGUFX+NQ7mYe8nQT7U3xtCeFS6+ZhyUaHSzIW2dCEqj1LdNB6iU4h
uX/znRq9/TFc1U1Rj5KKeu8XrnzyacquzOKnbqIaKRYC4XNZKaZC1fMLU5FwyAplbmRzdHJl
YW0KZW5kb2JqCjE2IDAgb2JqCiAgIDIyMwplbmRvYmoKMTcgMCBvYmoKPDwgL1R5cGUgL0Zv
bnREZXNjcmlwdG9yCiAgIC9Gb250TmFtZSAvUFBGSEpRK0RlamFWdVNlcmlmCiAgIC9Gb250
RmFtaWx5IChEZWphVnUgU2VyaWYpCiAgIC9GbGFncyA0CiAgIC9Gb250QkJveCBbIC03Njkg
LTM0NiAyMTA1IDExMDkgXQogICAvSXRhbGljQW5nbGUgMAogICAvQXNjZW50IDkyOAogICAv
RGVzY2VudCAtMjM1CiAgIC9DYXBIZWlnaHQgMTEwOQogICAvU3RlbVYgODAKICAgL1N0ZW1I
IDgwCiAgIC9Gb250RmlsZTIgMTMgMCBSCj4+CmVuZG9iagoxOCAwIG9iago8PCAvVHlwZSAv
Rm9udAogICAvU3VidHlwZSAvQ0lERm9udFR5cGUyCiAgIC9CYXNlRm9udCAvUFBGSEpRK0Rl
amFWdVNlcmlmCiAgIC9DSURTeXN0ZW1JbmZvCiAgIDw8IC9SZWdpc3RyeSAoQWRvYmUpCiAg
ICAgIC9PcmRlcmluZyAoSWRlbnRpdHkpCiAgICAgIC9TdXBwbGVtZW50IDAKICAgPj4KICAg
L0ZvbnREZXNjcmlwdG9yIDE3IDAgUgogICAvVyBbMCBbIDYwMCA2NjYgXV0KPj4KZW5kb2Jq
CjcgMCBvYmoKPDwgL1R5cGUgL0ZvbnQKICAgL1N1YnR5cGUgL1R5cGUwCiAgIC9CYXNlRm9u
dCAvUFBGSEpRK0RlamFWdVNlcmlmCiAgIC9FbmNvZGluZyAvSWRlbnRpdHktSAogICAvRGVz
Y2VuZGFudEZvbnRzIFsgMTggMCBSXQogICAvVG9Vbmljb2RlIDE1IDAgUgo+PgplbmRvYmoK
MSAwIG9iago8PCAvVHlwZSAvUGFnZXMKICAgL0tpZHMgWyAyIDAgUiBdCiAgIC9Db3VudCAx
Cj4+CmVuZG9iagoxOSAwIG9iago8PCAvUHJvZHVjZXIgKGNhaXJvIDEuMTYuMCAoaHR0cHM6
Ly9jYWlyb2dyYXBoaWNzLm9yZykpCiAgIC9DcmVhdGlvbkRhdGUgKEQ6MjAyNjA2MDQxMTM4
MjgtMDcnMDApCj4+CmVuZG9iagoyMCAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZwogICAvUGFn
ZXMgMSAwIFIKPj4KZW5kb2JqCnhyZWYKMCAyMQowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAw
MTE0NDggMDAwMDAgbiAKMDAwMDAwMjA3NyAwMDAwMCBuIAowMDAwMDAxOTQ5IDAwMDAwIG4g
CjAwMDAwMDAwMTUgMDAwMDAgbiAKMDAwMDAwMTkyNiAwMDAwMCBuIAowMDAwMDA4MDk4IDAw
MDAwIG4gCjAwMDAwMTEyODcgMDAwMDAgbiAKMDAwMDAwMjI5NiAwMDAwMCBuIAowMDAwMDA3
Mzg0IDAwMDAwIG4gCjAwMDAwMDc0MDcgMDAwMDAgbiAKMDAwMDAwNzgwMyAwMDAwMCBuIAow
MDAwMDA3ODI2IDAwMDAwIG4gCjAwMDAwMDg1MzMgMDAwMDAgbiAKMDAwMDAxMDQzMCAwMDAw
MCBuIAowMDAwMDEwNDU0IDAwMDAwIG4gCjAwMDAwMTA3NTYgMDAwMDAgbiAKMDAwMDAxMDc3
OSAwMDAwMCBuIAowMDAwMDExMDUxIDAwMDAwIG4gCjAwMDAwMTE1MTMgMDAwMDAgbiAKMDAw
MDAxMTYzMCAwMDAwMCBuIAp0cmFpbGVyCjw8IC9TaXplIDIxCiAgIC9Sb290IDIwIDAgUgog
ICAvSW5mbyAxOSAwIFIKPj4Kc3RhcnR4cmVmCjExNjgzCiUlRU9GCg==

--BbNVR7QFd503bRKP--
