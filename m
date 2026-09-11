Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855835AC0C
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091425; cv=pass; b=VGxQkBdKfVZ61jMKnBqucbKVdnphSJkt4USYe/5ocROqljeA9TM3RuqlZ7mQWof65Wh/sQzMKu7Dfwzcl8yiDZzBGFbjUDTFU7hL0JFfXokYfLTK7NSRnHELod0R9TKloL3zDqjD1q90TelSIY7UoPw9dOB5nRniT4qiQ9/lN/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091425; c=relaxed/simple;
	bh=vx+ssvLQ/2n0xT68XYMop9NM0klSBbbzW7GdOKIDDYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L37nfJDDmcJGvO/iYxvy8jL+nQBGzibpxDDoXjhpUgyf+UIylzXG4ruDwwz4ORSlwDbSoQMNZ2XfNxWF6d3s57Gn2xPDXhtRTRGzfOmVlflMZg+S9rfV/iv/q3ZIOjW4OKJDiW4icmc8SLu+Umi1fpamuxpNqNveGtnwsJTiY60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVzV5k0q; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVzV5k0q"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b965570d7so4872915e9.0
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 18:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789091422; cv=none;
        d=google.com; s=arc-20260327;
        b=AkTFIDcQU9g4v0xdOXKcPcqhfDJBRaZtDjU84O0t1Pnt4LNZe47fy63Evq/vCGbQJS
         vuEFrhojwu0ZtId9CmkpXX99kehG55z6EidDPt+w5Yqf5IU1Q3WiGr8Q+WbVhhvFaDhm
         3padPvosvxwu/tAbR6uXa2IqKz4UPXFBRo0pLzMTqHainIEk6h7oQd/vMN/u0KKeqcKC
         98gmmchCWYGK1EOki52LI6b6Eo8mGU/y2gucdZBfjcl/vyjJCp9pHmQTOCRfKsk+GU7Z
         8U2gRQVDKG1PXzHl+WPqPAikCkwAvDjjgrcgj/ASOXKdzRS9OZNVYv4iAycp+0cRN/S2
         49TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QCPrKmDOLjswZ/G8gb4hedrH78EI5NhsoNyjf+nq07k=;
        fh=kMYYv4I+X66g9vyycUtXPSnjqGOzWqHTzq8SkjkFAvw=;
        b=gs/TvYxqQdAWNOsmI/LLtNGd3XTr//AmXF7q7UBdefbDiKwt8AF/ccgCd2/tQnbePh
         qymHr+Ql3ZdoZ+fOk3fF4K2spa6ZFCW444pIafJuNz0M/9cRL0iqTmpuXxLgAFIeWq1F
         u2wAHFkQxuG+zlcmvXJO6pVHwnS8vV+E8V+QhUi4eFZTfzWyOs0Mak2PQ8FvXzdibF3O
         7joMPfYKXcBhheGtd6m5OzsEaE8GjJGf+OyPAP/VVXK1NuUj61ZoJ1CkbmAUcxR99zfR
         XvQLUO4NX8nFJr8Fb6hLVRXlVMj5lhzV1DzOoCHPIFPFTei9QCFR4pYkdR87tIAZ1OEY
         5Osg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789091422; x=1789696222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QCPrKmDOLjswZ/G8gb4hedrH78EI5NhsoNyjf+nq07k=;
        b=eVzV5k0qLx5hWDYWn+5hQQSM4bmYBZUR1AS2DJy38sbB/YC5dlIiyJYg9+fGVvsc76
         9pZ7hgvHuqkd8Ie/+F52HaBZ6lEmN3TPqZHhjt7RRhomD20izRz94rdrh5/SRrF1i5PO
         LZyz99alU1BVd7/8abqIvjqzQx+kWKr5GUiticqmITAiGq+IDSoN8wKdW6VYFxlXY5Fq
         BIX9Z18Ic9/okrd0wXE7yObWbj35xC8qGekJ5OaRdg/NEWKuwX37Fq8jjMgYFNZO5OfF
         Q6lmMsoNK1hpL0cHoMhvityBEg/zMMtCULxwu2A5YpyUlD4eBBYj7+Yavu8aGkYzoP8s
         WlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789091422; x=1789696222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCPrKmDOLjswZ/G8gb4hedrH78EI5NhsoNyjf+nq07k=;
        b=p8sUAxRVzu3ebLaH7YjQB5+oOj+T6KA9PcgV6NvbhaMULHJw2n/bRRWZwGhQIntiNE
         SMzmklcf1l9hpWSqOt9D8oI0unRZ4Nm3EqEdsgReouPLN9hmLwp/DQO2bRsZZj/Nt+L2
         ftyr68gw9fZnFrdCyzY0r8B03AeXaZ9Q6phmBX4iHqBsp42O4cijJ6R+F4eANz4J6Qq+
         KW9sOxx51189AXHXKHrOz1pOLYc8sRX6U+LfB5EVf92N2YyIJsbPs3dL0+peUdNrQ7Fj
         zjUmzNfkFVg/hSqV0FWqc2wxrEy8LFvWSBo3hefgg96XJoWQWzv403jaY7mfw130wKwk
         zVhg==
X-Forwarded-Encrypted: i=1; AKwUvByjDbTgTQ1ucTG/kdByTfTCRSvz0BUoCRUdAakb2k4yMpo7j5L/hB7YgtTCsA/UTY42A2s=@vger.kernel.org
X-Gm-Message-State: AFuF++m5HKa6eLos68rg+X1Cj4kNfvmmAu2YbrR9CjOdjtA50drs4PYz
	VQcTFYmqqmzuiZRQ4sNy1ULpZC/FGrLIAMtASA4VL3zZcFuXLOWP4Y4IiUK2hcE0UpkA3jBxuIg
	vHf6/TqmT7GcBJ6gHwICh/kRxN/+tq0o=
X-Gm-Gg: AYBFou1YfxR9VFaAkSFa98MAOm461EdRjaYyuSRuI4zT/Z3GZBDBrwuLriY+eGBr91c
	cYKGt7FN/oirj83D9O/sT4g6YKMFxWgBxS0Y8MNTCN/gCQ3xGUWa9h4Zk2O27z5sKA8BS7loNVG
	9K2+/SUP2NIwAUdd9Df1QOLukJnP3MWHW1obvre3J3IWOyyspQ8aU1fOcRMsnrI5FiawOq4Labx
	W7UhraxZdaQ2KwEXRIu8LdQ64PQYLS6WY14+we/RsyyGHK3QmEqpAkmFAunXRNIGpbf+7l6iob4
	4Llnz8FBYOCt0N8Jbu9i42tBqMqaahqT02/2vdE556AqiHV0oqkbifmdXUlBVLiP6aDpT/sjstG
	Dk8fKy7+4NusFv00=
X-Received: by 2002:a05:600c:4f84:b0:49c:fc6e:8cb9 with SMTP id
 5b1f17b1804b1-49e619dbe1dmr16170215e9.29.1789091421145; Thu, 10 Sep 2026
 18:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910084629.3695383-1-kunwu.chan@gmail.com> <d1bf830e-8755-4eef-a8f6-35612640a478@paulmck-laptop>
In-Reply-To: <d1bf830e-8755-4eef-a8f6-35612640a478@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 11 Sep 2026 09:50:09 +0800
X-Gm-Features: AcwNN1VvrNWvy6Z_lG_xJ7XlHcRflo55ggo_837jUIbeAoVb3xV3EQxAkPXSWis
Message-ID: <CAN_Opa_X1Gq4DxMhZvM_8XPg96Anw6UWW2EnndtVJ6vPYKE0YQ@mail.gmail.com>
Subject: Re: [PATCH v2] srcutree: Add WARN_ON_ONCE() for atomic SRCU in srcu_gp_end()
To: paulmck@kernel.org
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:58=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Thu, Sep 10, 2026 at 04:46:29PM +0800, Kunwu Chan wrote:
> > Atomic SRCU remain in the small size state, so add a
> > WARN_ON_ONCE() before the transition check to catch any future
> > code path that might violate this invariant.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> > Changes since v1:
> > - Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
> >   per Paul McKenney's suggestion.
> > - v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@l=
inux.dev/
> > ---
> >  kernel/rcu/srcutree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 84c022ec8e09..68441c32cebf 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1074,6 +1074,8 @@ static void srcu_gp_end(struct srcu_struct *ssp, =
bool is_atomic)
> >       }
> >
> >       /* Transition to big if needed. */
> > +     WARN_ON_ONCE(ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_ATOM=
IC &&
> > +                     ss_state !=3D SRCU_SIZE_SMALL);
>
> Also much better, but we also need to avoid doing the transition in this
> case, because doing that transition breaks atomic SRCU.  On way to make
> this happen is something like this:
>
>         if (ssp->srcu_reader_flavor =3D=3D SRCU_READ_FLAVOR_ATOMIC && ss_=
state !=3D SRCU_SIZE_SMALL) {
>                 WARN_ON_ONCE(1);
>         } else if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SI=
ZE_BIG) {
>                 if (ss_state =3D=3D SRCU_SIZE_ALLOC)
>                         init_srcu_struct_nodes(ssp, GFP_KERNEL);
>

Thanks, Paul. Good point. The original !is_atomic guard in v1
already prevented the transition for atomic SRCU. I was mainly
thinking of the WARN as a diagnostic, since this state should not
occur with the current code. I agree that retaining the protection
against the transition is safer if the invariant is ever violated.

> Other approaches might take advantage of the fact that WARN_ON_ONCE()
> returns the value of its argument, allowing WARN_ON_ONCE() to be used
> as a condition in an "if" statement.
>

I prefer the first approach. Using !WARN_ON_ONCE() directly in the
existing condition would make it rather long and less readable,
while the explicit if/else keeps the control flow clear.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> >       if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG)=
 {
> >               if (ss_state =3D=3D SRCU_SIZE_ALLOC)
> >                       init_srcu_struct_nodes(ssp, GFP_KERNEL);
> > --
> > 2.43.0
> >
