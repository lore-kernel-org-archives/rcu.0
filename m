Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF213957B;
	Tue, 22 Oct 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568430; cv=none; b=Wrl3PjEz1yPNRjiLbRqc7/kGlEAft0HZUJ97PP39veU6uuB2Z3ij1JrF1HSH2Eu6uF8UaMZSqk5TGRquWPbf4/5NxyzQ+q6YBBXaHHfwE1sZuU6bNbJsDZeIBxc9y6VSo7qAJF34X1VmW9RyNQz76keshOHKvgDlGEKJ4NlEJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568430; c=relaxed/simple;
	bh=6dDi3qz50TuBesIjcJCS9Db6LXc38eCyjZ4+I/1n15c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRUrGQwGb+QeGPBieCPUqzT/Kp+PBCG5NE3zZMRr2Aw49OZ2FBK8uQkoE8mnul2jF8PCcmRdPilPgg2N857oh6VbLlFM2uHWEFRkHVltdTUBCWRCwDx6vscWma42AeQUijUTiTDftz81+1kBeCexvwD2UtphN1qiBV7os77RyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP+eGJwT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP+eGJwT"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc05007daso1040832eaf.1;
        Mon, 21 Oct 2024 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729568427; x=1730173227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsIBMtBRdHgmgd4OuwKprKni4fu/k/MvfWuk44rUY64=;
        b=dP+eGJwTNtyNiu8MBIy71QtoOjirgzpTtk3zH89EKYjKhK38OXzPHFgQex/x9ywb4d
         yRwnq2vzBMs3P1Y2oWUI31hg6aOx3cjQRRXgpYPw8Haswsn1CeHYBkF/QNwQQHHcRZuf
         TVRxq9MGTabnvx4449N0MOa+zxnGQ1d0Q/cUhsgGYYBNkRyVInjUjyWxR6G1k0j8EBbz
         9ZeDQjCkHZ8/9FojJ0nJuCn79I3gO9G0Pqrz47gzPhPYNzSdIigsi5FzxjUtabgSd16D
         /E2IeAB3Jgaxp0UioCs45xE2fOZOmBVycU8e3HSm4L2zFlxXxUyegT8C/7+F7H+fI7AT
         +mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729568427; x=1730173227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsIBMtBRdHgmgd4OuwKprKni4fu/k/MvfWuk44rUY64=;
        b=GCSTfi/hkeHjRsJ5CoMj8NDj5NhPInuzHP1HPjIA1Cr0ui+gWUT7R69klZwQyMil5n
         rmlPq+3y/cf5CNzL+1xBB00LqCWKekJSg5BkMcHh9pbMDRd2Y1vermABKR8xHbHe0yIO
         6QzQp5o+/fXp3WUPP87Sx1fN7OXpfKfRwF3XTzoe99Aqb0mTnAQV7unp+1qXQ34X+DLT
         daLucKjDznoh2dAHG67zrXYJsA78jRQSxGc4rtWempofYTZo6rHPYD0tEF1943vnANFv
         NV8Qf/OhA+KHQX6CjfUeBpHzHkGBeCu963z1UvAXRz8YNs1JAxNDE5vl0QDZvGw+Hb1i
         HfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhEFSoEaBrvXmYi02eRnBGEGh3H9P9XrMEFEo8KHHe77Vruray/rSMTt91riRtVzilYPYAOaxdjEu9/Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwETAVyXRkhbE4IcxdxTq3KY9jEChliZshHEF7Zq2pgrJLMlIZM
	BWU9tiVOtyi7LyLaWbK6nBdKMEn5d7gq7gTzbD6RXVzHL7B+ksU3GJUywv5oiuIAJpmT5AUv/dq
	EEj4DEnqdPERX/esBQxDO8eFmsSU=
X-Google-Smtp-Source: AGHT+IGe3Nw+1nbJUnYfqVAvcUuvQuavIukZTZbVhLPSYvrvk6LLBWU1vU6yR4jRs3HKGr9nJmTsuylApSB7vflQ76w=
X-Received: by 2002:a05:6870:8086:b0:288:679e:ca8a with SMTP id
 586e51a60fabf-28caff1eb49mr1237426fac.18.1729568427394; Mon, 21 Oct 2024
 20:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com>
 <5fbd5ff1-8cb8-425f-be5f-7ed9fe4edf1c@paulmck-laptop> <CAEf4BzbX5UtS=+Np5t68n8oRE2O2qGg5iDcikNFpvCTPBZU8kg@mail.gmail.com>
 <22a02204-8d14-41ae-af40-dfea79dec09d@paulmck-laptop>
In-Reply-To: <22a02204-8d14-41ae-af40-dfea79dec09d@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 20:40:14 -0700
Message-ID: <CAEf4Bza_XLALKvOzyc9f22hrXWkvcX7yb=D0W3FUFrAmPAZHHg@mail.gmail.com>
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from srcu_read_lock()
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, peterz@infradead.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:30=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Oct 21, 2024 at 07:01:02PM -0700, Andrii Nakryiko wrote:
> > On Mon, Oct 21, 2024 at 5:21=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 04:50:44PM -0700, Andrii Nakryiko wrote:
> > > > On Mon, Oct 21, 2024 at 3:13=E2=80=AFPM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > > > >
> > > > > For almost 20 years, the int return value from srcu_read_lock() h=
as
> > > > > been always either zero or one.  This commit therefore documents =
the
> > > > > fact that it will be non-negative.
> > > > >
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Cc: Andrii Nakryiko <andrii@kernel.org
> > > > >
> > > > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > > > index bab1dae3f69e6..512a8c54ba5ba 100644
> > > > > --- a/include/linux/srcu.h
> > > > > +++ b/include/linux/srcu.h
> > > > > @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_str=
uct *ssp, int read_flavor);
> > > > >   * a mutex that is held elsewhere while calling synchronize_srcu=
() or
> > > > >   * synchronize_srcu_expedited().
> > > > >   *
> > > > > - * The return value from srcu_read_lock() must be passed unalter=
ed
> > > > > - * to the matching srcu_read_unlock().  Note that srcu_read_lock=
() and
> > > > > - * the matching srcu_read_unlock() must occur in the same contex=
t, for
> > > > > - * example, it is illegal to invoke srcu_read_unlock() in an irq=
 handler
> > > > > - * if the matching srcu_read_lock() was invoked in process conte=
xt.  Or,
> > > > > - * for that matter to invoke srcu_read_unlock() from one task an=
d the
> > > > > - * matching srcu_read_lock() from another.
> > > > > + * The return value from srcu_read_lock() is guaranteed to be
> > > > > + * non-negative.  This value must be passed unaltered to the mat=
ching
> > > > > + * srcu_read_unlock().  Note that srcu_read_lock() and the match=
ing
> > > > > + * srcu_read_unlock() must occur in the same context, for exampl=
e, it is
> > > > > + * illegal to invoke srcu_read_unlock() in an irq handler if the=
 matching
> > > > > + * srcu_read_lock() was invoked in process context.  Or, for tha=
t matter to
> > > > > + * invoke srcu_read_unlock() from one task and the matching srcu=
_read_lock()
> > > > > + * from another.
> > > >
> > > > For uprobe work I'm using __srcu_read_lock() and __srcu_read_unlock=
().
> > > > Presumably the same non-negative index will be returned/consumed th=
ere
> > > > as well, right? Can we add a blurb to that effect for them as well?
> > >
> > > Does the change shown below cover it?
> >
> > Yep, looks good, thank you! You might want to fix
> > s/srcu_read_unlock/__srcu_read_unlock/, while at it, but that's
> > orthogonal.
>
> As long as we are in the area...  Please see below for the update.
>
> Thoughts?
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 4433b7d3785d8d2a700f5ed5ca234c64bc63180e
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Oct 21 15:09:39 2024 -0700
>
>     srcu: Guarantee non-negative return value from srcu_read_lock()
>
>     For almost 20 years, the int return value from srcu_read_lock() has
>     been always either zero or one.  This commit therefore documents the
>     fact that it will be non-negative, and does the same for the underlyi=
ng
>     __srcu_read_lock().
>
>     [ paulmck: Apply Andrii Nakryiko feedback. ]
>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index bab1dae3f69e6..512a8c54ba5ba 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp=
, int read_flavor);
>   * a mutex that is held elsewhere while calling synchronize_srcu() or
>   * synchronize_srcu_expedited().
>   *
> - * The return value from srcu_read_lock() must be passed unaltered
> - * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> - * the matching srcu_read_unlock() must occur in the same context, for
> - * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> - * if the matching srcu_read_lock() was invoked in process context.  Or,
> - * for that matter to invoke srcu_read_unlock() from one task and the
> - * matching srcu_read_lock() from another.
> + * The return value from srcu_read_lock() is guaranteed to be
> + * non-negative.  This value must be passed unaltered to the matching
> + * srcu_read_unlock().  Note that srcu_read_lock() and the matching
> + * srcu_read_unlock() must occur in the same context, for example, it is
> + * illegal to invoke srcu_read_unlock() in an irq handler if the matchin=
g
> + * srcu_read_lock() was invoked in process context.  Or, for that matter=
 to
> + * invoke srcu_read_unlock() from one task and the matching srcu_read_lo=
ck()
> + * from another.
>   */
>  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp=
)
>  {
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 07147efcb64d3..ae17c214e0de5 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -738,7 +738,8 @@ EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
>  /*
>   * Counts the new reader in the appropriate per-CPU element of the
>   * srcu_struct.
> - * Returns an index that must be passed to the matching srcu_read_unlock=
().
> + * Returns a guaranteed non-negative index that must be passed to the
> + * matching __srcu_read_unlock().
>   */
>  int __srcu_read_lock(struct srcu_struct *ssp)
>  {
