Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202EA83CD6;
	Tue, 22 Oct 2024 02:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562477; cv=none; b=GQ0byrKnWwEvez68t+Vt4UvtuWw2ZRwMyG0YGCSSWhLsR++ZkD03vb0k1uhe9gzwLLovQhU9USIbOgMq0u49FbGBVjzBdtFsKSV1DU9JKT577PqK39CKUndg49I3oZGNE+2f0o+ynWgK+gtVwWb+AGvj881/bS2PK4Y23GFUWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562477; c=relaxed/simple;
	bh=o6Un0vRMRUqycL4MmnrAjs1Ms4xRyK/xfz+CckTV5pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU5eEgxwSX28UaA5oK0FCG1pn01acnaTaMOZxDlw0kDqoQ7mts9LAzHagRGeowF0uBDuW+0y/b3i04Ehr6yG9sXFhLZjiwSZHmfIwXSZ2OUpRpjfkkUuTOflNdBreR4ocq7xMQek+uf3+bqQM3sPRZAAD8liJ1WzM0+2ywTeFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ08WxWt; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ08WxWt"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4048159a12.2;
        Mon, 21 Oct 2024 19:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729562475; x=1730167275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqWSsJAT5CNspq5A+SSkQskz+lBebgcxEADf0JhvbYs=;
        b=HQ08WxWtJ862AwgLuLeJHLBmflc0+shUefs2J+AJLA0etZoF9+nhFD6zc5K9GJYaAl
         /sXCWET6Y/nzG9CT5/mjKhcKNBR3xmcfV7gRGswS8s2QWxP+XjO/CDZZaOcWptbHX/zR
         SwM42O7f78z2l3Z44OetRoRMAk4ODI/fBVzu5+LwJmM282w5WtHsDQBfxFuZrNwHe2DY
         7H3WLn6yHojn2ADCn+qG5leRcK9CuptFZQlKRYwcNDTKNBCDBWr2Vy+Wkduqct2ssLYW
         Q2VI3d2MkB3E9qzi8ON3dn+M7ar2Rf3z87PxAyhmkclobvWIDN05R8GrA0oztO5fvLEP
         UUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562475; x=1730167275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqWSsJAT5CNspq5A+SSkQskz+lBebgcxEADf0JhvbYs=;
        b=gP7IW8BVnubHh2CBIn9UOt4oB5HOBJvLksaYO1v/MFLqlPSUgS991zTe1Twrb48jGH
         eAeoWT1cM37bm/cCboW51IoXu0fQCXSI3UaYjPRp9iSznFYz4THI0fXDRd3eaE6G1b+1
         SINCfAJ6VKf7Vwfd/yy/LBfZyAahq+z4b3VD38jriFVEcPSS7z+eD0GAZ+QCxnbTpvn5
         DfBdZ3S7ONmyVD7Vz5R6duYNYpjXetj8dRZTxr2Y8ZU9zD3dJmQHHiNQ8dQrgjwN2UBW
         Y/8OrriV2msYZcGO82jEhZ02Rpn6/eS3DFqmfxakxIROOANUYANsCI7zqf9JdfC7qSoY
         +pmg==
X-Forwarded-Encrypted: i=1; AJvYcCWLwgew3pLWn7JpTHpLSn7JlglvPGiN11YlCEmlrj14TYjV4stUcH6hdCUdZhcX8Yv9aLzofaHLeaKT5b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZckIVTZH6MhC0O88VfaKMdaduZxMXmPwtMRaet8y4BB5uk9a
	DoXLb6/m1wDttFzU9W4tijFWR6FRMJ5d0W0y92j5hoWtm+L8gTwtTEtGJKl1w4XvffaC6O38P+0
	I4RK+ldtDlde9bMjmBFcuDCPTOeg=
X-Google-Smtp-Source: AGHT+IFhP5j6y7ZS2yWSDvsNSQHVT7qtvC2GPgYS0LHkoG4Lp6+eIf2B85lDKyS+N+sFDohAxpridyp2S11du1hxG3U=
X-Received: by 2002:a05:6a21:458a:b0:1d7:2249:689 with SMTP id
 adf61e73a8af0-1d92c5729c2mr20355759637.33.1729562475143; Mon, 21 Oct 2024
 19:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com> <5fbd5ff1-8cb8-425f-be5f-7ed9fe4edf1c@paulmck-laptop>
In-Reply-To: <5fbd5ff1-8cb8-425f-be5f-7ed9fe4edf1c@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 19:01:02 -0700
Message-ID: <CAEf4BzbX5UtS=+Np5t68n8oRE2O2qGg5iDcikNFpvCTPBZU8kg@mail.gmail.com>
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from srcu_read_lock()
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, peterz@infradead.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:21=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Oct 21, 2024 at 04:50:44PM -0700, Andrii Nakryiko wrote:
> > On Mon, Oct 21, 2024 at 3:13=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > For almost 20 years, the int return value from srcu_read_lock() has
> > > been always either zero or one.  This commit therefore documents the
> > > fact that it will be non-negative.
> > >
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Andrii Nakryiko <andrii@kernel.org
> > >
> > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > index bab1dae3f69e6..512a8c54ba5ba 100644
> > > --- a/include/linux/srcu.h
> > > +++ b/include/linux/srcu.h
> > > @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct =
*ssp, int read_flavor);
> > >   * a mutex that is held elsewhere while calling synchronize_srcu() o=
r
> > >   * synchronize_srcu_expedited().
> > >   *
> > > - * The return value from srcu_read_lock() must be passed unaltered
> > > - * to the matching srcu_read_unlock().  Note that srcu_read_lock() a=
nd
> > > - * the matching srcu_read_unlock() must occur in the same context, f=
or
> > > - * example, it is illegal to invoke srcu_read_unlock() in an irq han=
dler
> > > - * if the matching srcu_read_lock() was invoked in process context. =
 Or,
> > > - * for that matter to invoke srcu_read_unlock() from one task and th=
e
> > > - * matching srcu_read_lock() from another.
> > > + * The return value from srcu_read_lock() is guaranteed to be
> > > + * non-negative.  This value must be passed unaltered to the matchin=
g
> > > + * srcu_read_unlock().  Note that srcu_read_lock() and the matching
> > > + * srcu_read_unlock() must occur in the same context, for example, i=
t is
> > > + * illegal to invoke srcu_read_unlock() in an irq handler if the mat=
ching
> > > + * srcu_read_lock() was invoked in process context.  Or, for that ma=
tter to
> > > + * invoke srcu_read_unlock() from one task and the matching srcu_rea=
d_lock()
> > > + * from another.
> >
> > For uprobe work I'm using __srcu_read_lock() and __srcu_read_unlock().
> > Presumably the same non-negative index will be returned/consumed there
> > as well, right? Can we add a blurb to that effect for them as well?
>
> Does the change shown below cover it?

Yep, looks good, thank you! You might want to fix
s/srcu_read_unlock/__srcu_read_unlock/, while at it, but that's
orthogonal.

>
> > Otherwise LGTM, thanks!
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thank you -- I will apply on my next rebase.
>
>                                                 Thanx, Paul
>
> > >   */
> > >  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires=
(ssp)
> > >  {
>
> ------------------------------------------------------------------------
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 07147efcb64d3..3d587bf2b2c12 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -738,7 +738,8 @@ EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
>  /*
>   * Counts the new reader in the appropriate per-CPU element of the
>   * srcu_struct.
> - * Returns an index that must be passed to the matching srcu_read_unlock=
().
> + * Returns a guaranteed non-negative index that must be passed to the
> + * matching srcu_read_unlock().
>   */
>  int __srcu_read_lock(struct srcu_struct *ssp)
>  {
