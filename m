Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794474857;
	b=noNIAF447t3Z3+6WriyT2g7zC6UB5hfo2HFY0DdYHzAe9gw4+3KOjdZIpuOHXQ8+7y99
	 HxVZOkj7WoLAv77OoLPwYR319H8W3Us6GxBrBWPgMTi7Mm7tCfkDP9UINgls2M4EH2qXQ
	 YCk+v7+ybqcRd9PNtuJpVIQkhkBura6JWa4cIOJn6+LkF4CDnpkNeryy93BIyQ0j8yzdU
	 ILAvKsSCMT4d13F7jdIPYTSHtQ14MKd0ZXJfPAuS2VieFHtTDffOYl/3s7BhMoG6m1oMJ
	 k24hAttsp+lp00CbsYMNFDrOqWdow5kY5ATiC57WCpicIjlhn7COwK5NoicQuzNa44g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VoI2Gu86mrP3eADBphQdgZoK4/GEKT8FnpX3YKlKF2k=;
	b=3RpHISFL4oky4cHMDa+LHp1n7liVLgAWABfrQVlLfhRnwzmpLaY5FsliHzYsVTtrWnOV
	 a9UN85Ld6QgnhTvcLwN6k5h9WhJIFnTCGvm5Nj+riHWH2fRYsNI324ijpqe89wpNnB5FE
	 2k53R5nsgAgd+nAzekMe0RBKPEuxzmlIu1Vkono2ilZsvS1mnZws1/nQE5DDHPPfFBfY8
	 6/jfsXanZf/FmixWcQh/9vMMVOM1og73lDrwce5g0x+RaG+sDmPLR3G6ivdf/8yyZbjmM
	 mzMmliN6JnvvI4DI5TSvAXPGHm0mStpnITH/0SzCEXJuFADdDNl9JWyMlDHffiCrpfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gFtwHnS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4E606A31C
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 09:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20D4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gFtwHnS
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so31495445e9.3
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 01:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474855; cv=none;
        d=google.com; s=arc-20260327;
        b=XxjfjsNM6tVptfKVtCPnBscV0vFYBW0q5gWoIwROQ3DWDo8H0vjfjyF4AsP9pGphE0
         O4a9Eoa8an8T7C4CwhHy51BFJID9r5oYkPwww7+WNOeaX2mVWIAgyCD+qKXp8NqhX9UL
         weEjnEciIq8gVfAolmdjPQdBTzw5RMS6DF8VhKogO3EovBG49xG2+SrcYKKvzSQsY0vW
         Dbm1GtE+XsXT+uKJvzzI9W7nLoNQUfXzig4EZV3k6nJySNC1E7Pviih0MtlzarNk4pgm
         YzEgdSMUHIPLg9UOMIx4LaQJ7l+kkXQhMR1RPna0s0ILftB/kFD0z2T3Qk3kIkF+bi4Y
         1+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VoI2Gu86mrP3eADBphQdgZoK4/GEKT8FnpX3YKlKF2k=;
        fh=8QDRLxIKhWSuNvzj4tR7PBHCVvDNcXzbz5HwvhW+VRs=;
        b=pC7vNKfRAdoelYuekPxoNUehbCMCP/4M40NYYlw2j4b+9oR1MX1oWXhTtuSOffZK9Y
         lsIs0X1hnUY/Ymta0bWbwrvgxJQ+0QM4YWTGAC6CKWvwwq3IbSXBfmMQOjUHXNRgDb3t
         MS/vJYu182WMEpH1FcDDHrHrE4CDUPeU+RH0JAKdLO4Ywmo7LKjM4olMI8ChkwldOm1y
         8DFjeUCl4xBreaK/iimiNgFvTvSMk9nmmCoW2U5hg/bNrD5TDAOmzHDiVsvoKeujgXJo
         9dwF22QsUnDgnYfyFy0gXc6kTmoZGwkl2sHoT4DPxobaxq1f0X9uhe8CkVvwQLdcKMQ5
         O05A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474855; x=1795079655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VoI2Gu86mrP3eADBphQdgZoK4/GEKT8FnpX3YKlKF2k=;
        b=0gFtwHnShn2C/o+jiCRQB3k3nLuLlZfzt/D8Wz8fDaj+97nYCBYAj93JDHHnuxmZ9S
         LNyD1rvlKEHOICKnY0tqrE2xszteV92SBlwryynUtDx78+ea85x246PdiX0AATBnESLY
         /D9C/pql2FShRGuLt1GvDlC7MsbjO8/+jjSrSi92gCijPjleqk5HlOX/BAC0ckkTqKAG
         2ThgiHzd0PJ/i9aFGz1EtrVJ2BAEtwWu7+KGs0qCCctVkpxdm/yLmiiOd0fynb4UWAt9
         dx3SL+8+eOxQTv0uVRpkhofwH4ZUiEgQnvif0J9C7wafS7hYsPM7Axcy/S1PuYdX9Hvk
         D10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474855; x=1795079655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VoI2Gu86mrP3eADBphQdgZoK4/GEKT8FnpX3YKlKF2k=;
        b=gPvHeWwTio8uWl7asHY+ZlDhTfUDWtZ2hiQLhu6KxTYB4O4rYiyt7zrNuvO9CmZAl2
         mO7eY5nqd+NNRSiq/Qc5zYmPL3g8nxg36strOxrzeqWrhuof3uSDKZEy57AD3zXWltb5
         goSlRr+ALTveG9ozVPMswd6wheGWkdQDFLQ6NgqadthSTeGf9+7P8hhI8HfKvRHBFECS
         oxDdQSnBvOZ9FYhj5RPa57UnLHj1H+gk/VpUzzr72EfM/BiIqVVYrjTaj4SXgQO4lKJ/
         QJTGT2tm2mqYTCK8YJOtYTh96G1fqXyUPBKOi8TGPoXWXV72CcoGI/gtON80IeoXQibG
         eHgg==
X-Forwarded-Encrypted: i=1; AL+hErFwk3yHPt5lq6lXuV5kHJTDgkxskSiKDeUd1zainCUFoxsS1sxqGkLUC+1K3XQvtfM388Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9C+Zk3yFAxAdIgdRX/vF0RKtR7zZdWBoZGIWxG0u7EVf2hpNE
	yYduQarPhYo5Zorbrlm/kGkYqN7U09G4zHH/8oQ55tE8MlkDBXkHDgsZ6hJSPPOp9t0edp0DnqX
	QBEY00NLa3IPl4EN7Ji/ggRFKfJWTDpmRDvXzT2w=
X-Gm-Gg: AYBFou2B7107qFIT4WDO45Qof+/DDunBoC2wE6Rqm8ZbeIoahahxuTEMEc695XNSazC
	yaCOwjhK0FPoOJIIAWNkk6xfiirC813YtBXQvHXvrZ2j7+v4deN2KnnS1+eZLgb3L6bGjHvFrj0
	NeQSfezjlCDiLP40wtoFSSncFj4U3ONq9gD+CPZjnHxAZUHMkGkYnc68zfJMtf178FdqqTKQJEb
	jX7IbcG561rRe+yzas05lduiaFDo0dyT+zHVl4bimYK3KUA+T4QW86FnJQlM5zih49dIBRISuI9
	sCss3d2EpqNFrTovMES9H1iE1otYko0kTtmE6lb6jdqWDJ6cCb5L4zngE8yJ2CeJicffJ5hjg5p
	3xJQWJI5tY/e36UpGBTSeUNaNc2OX7ytZt9bqBe091BN31zvhUUbC8yU3idQ=
X-Received: by 2002:a05:600c:4ecb:b0:4b9:ff69:19ac with SMTP id
 5b1f17b1804b1-4ba093811d3mr86501335e9.11.1794474854734; Thu, 12 Nov 2026
 01:14:14 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com> <20261111145949.70845-4-mathieu.desnoyers@efficios.com>
In-Reply-To: <20261111145949.70845-4-mathieu.desnoyers@efficios.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 12 Nov 2026 17:14:02 +0800
X-Gm-Features: AclHuK_dWrW_xJeY20DnlDcR725zYdAhmbejoXx7T_vAQBflKdgL48xqw5EE9N8
Message-ID: <CAN_Opa__N0OXoimufuJ5bNgVtYtqc2KTC=Cj3a6WiCUJ0ZRzDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] srcu: Make atomic SRCU readers NMI-safe
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Davidlohr Bueso <dave@stgolabs.net>, Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

On Wed, Nov 11, 2026 at 10:59=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Atomic SRCU readers count themselves with __srcu_read_lock(), whose
> this_cpu_inc() is not NMI-safe on every architecture. With
> CONFIG_PROVE_RCU, which lockdep enables, __srcu_check_read_flavor() also
> warns when an atomic reader runs in NMI. So an NMI handler cannot use
> atomic SRCU, while a tracer or a BPF program may need to read a
> structure that atomic SRCU protects.
>
> Count atomic readers with __srcu_read_lock_nmisafe() and
> __srcu_read_unlock_nmisafe() instead. They use NMI-safe increments on
> the architectures that need them, and keep the full barriers that
> synchronize_srcu_atomic() pairs with. The __srcu_read_lock_fast()
> helpers have no such barriers: they rely on a grace period that calls
> synchronize_rcu(), which synchronize_srcu_atomic() cannot do while it
> spins.
>
> Also accept the atomic flavor in NMI in __srcu_check_read_flavor().
> Annotate an atomic reader in NMI as a trylock for lockdep, as
> srcu_read_lock_nmisafe() does. An NMI can interrupt lockdep itself, and
> lockdep then reports any other acquisition of a lock that a grace
> period has used.
>
> On the architectures that need NMI-safe counters, every atomic reader
> now pays an atomic increment at lock and at unlock.
>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/srcu.h  | 18 ++++++++++++++----
>  kernel/rcu/srcutree.c |  3 ++-
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index d4dcaeb83e2b..e3b541ceb8dd 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -93,7 +93,7 @@ int init_srcu_struct_atomic(struct srcu_struct *ssp);
>  //                                     0x04            // SRCU-lite is n=
o longer with us.
>  #define SRCU_READ_FLAVOR_FAST          0x04            // srcu_read_lock=
_fast(), also NMI-safe.
>  #define SRCU_READ_FLAVOR_FAST_UPDOWN   0x08            // srcu_read_lock=
_fast_updown().
> -#define SRCU_READ_FLAVOR_ATOMIC                0x10            // srcu_r=
ead_lock_atomic().
> +#define SRCU_READ_FLAVOR_ATOMIC                0x10            // srcu_r=
ead_lock_atomic(), also NMI-safe.
>  #define SRCU_READ_FLAVOR_ALL           (SRCU_READ_FLAVOR_NORMAL | SRCU_R=
EAD_FLAVOR_NMI | \
>                                          SRCU_READ_FLAVOR_FAST | SRCU_REA=
D_FLAVOR_FAST_UPDOWN | \
>                                          SRCU_READ_FLAVOR_ATOMIC)
> @@ -372,6 +372,9 @@ static inline int srcu_read_lock(struct srcu_struct *=
ssp)
>   * The lock and matching srcu_read_unlock_atomic() must be invoked on
>   * the same CPU, from the same context; passing the return value to
>   * another task is not permitted for this flavor.
> + *
> + * This function is NMI-safe, in a manner similar to
> + * srcu_read_lock_nmisafe().
>   */
>  static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
>         __acquires_shared(ssp)
> @@ -391,8 +394,15 @@ static inline int srcu_read_lock_atomic(struct srcu_=
struct *ssp)
>         if (in_task())
>                 non_block_start();
>         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
> -       retval =3D __srcu_read_lock(ssp);
> -       srcu_lock_acquire(&ssp->dep_map);
> +       retval =3D __srcu_read_lock_nmisafe(ssp);
> +       /*
> +        * An NMI may interrupt lockdep itself.  Annotate it as a trylock
> +        * there, as srcu_read_lock_nmisafe() does.
> +        */
> +       if (in_nmi())
> +               rcu_try_lock_acquire(&ssp->dep_map);
> +       else
> +               srcu_lock_acquire(&ssp->dep_map);
>         return retval;
>  }
>
> @@ -599,7 +609,7 @@ static inline void srcu_read_unlock_atomic(struct src=
u_struct *ssp, int idx)
>         WARN_ON_ONCE(idx & ~0x1);
>         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
>         srcu_lock_release(&ssp->dep_map);
> -       __srcu_read_unlock(ssp, idx);
> +       __srcu_read_unlock_nmisafe(ssp, idx);
>         if (in_task())
>                 non_block_end();
>         preempt_enable();
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 8075da4b1bb5..8fa366861dcc 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -828,7 +828,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp=
, int read_flavor)
>
>         /* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flav=
or values. */
>         WARN_ON_ONCE(read_flavor !=3D SRCU_READ_FLAVOR_NMI &&
> -                    read_flavor !=3D SRCU_READ_FLAVOR_FAST && in_nmi());
> +                    read_flavor !=3D SRCU_READ_FLAVOR_FAST &&
> +                    read_flavor !=3D SRCU_READ_FLAVOR_ATOMIC && in_nmi()=
);
>         WARN_ON_ONCE(read_flavor & (read_flavor - 1));
>
>         sdp =3D raw_cpu_ptr(ssp->sda);
> --
> 2.47.3
>
