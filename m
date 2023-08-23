Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0CBEE4993
	for <rcu@archiver.kernel.org>; Wed, 23 Aug 2023 13:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjHWNWC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Aug 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjHWNWB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Aug 2023 09:22:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD110CEA
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 06:21:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so85832511fa.1
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692796837; x=1693401637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XkEjDAKSn5+dfOXNGlCtoCcAlW6lZFvfxb3mOVLv/E=;
        b=qa52udMWKviTeRqL2eJySgrpxKmyqfy5onwNaOAVzKHV+gXO6GU0B5mvAjUuTlT0cJ
         Woel2WQxbuifJPDn8yQbjxko2IRXmRDc5ZK6TWambnve7gdLHJ2RDDNbJF8YFyDz+42h
         av2vddJ31yHWrExGP0mCeAH6fk5INvuV3D8H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796837; x=1693401637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XkEjDAKSn5+dfOXNGlCtoCcAlW6lZFvfxb3mOVLv/E=;
        b=RaQ1Qze30bpB8DpTTpVGz+JbptV9OQvha1UGgc+AK259H76qaY98nlB5tDb6FP6YEt
         jGiS8+vVd/CugviAVJotlxPYu4GGN/KKrI3CfzRQ5cz3JWFvq2G7pNkfAz43KciSwC+3
         A0MnE7RQMSku39Ie6p7mRzTgKcOrOm1LyS8kXeINSBIMP/FOquBc47kCO9ZVQ+bxef71
         wZ2trwVGrwjJIDe/HPqtCTAJ+3+aZBMLiFAtlXEY/m0iFwZx4SJTLuYb2iHVJD56sJVh
         OtmLv+jExpf/4m7mtUTCZnLrzoWlE1+pnAS5dWOvdDb568o1xVA7yzhtfNk1kZIFWYwB
         7grg==
X-Gm-Message-State: AOJu0YyN/Gflvx+ragdrYPV2OLVo+blBXLw5WnfY+5dLfo/3VK9yFK9K
        cL+HUpawubtPrhDlMN8z1Dp5sbcmvxz3bYB+nsS9CQ==
X-Google-Smtp-Source: AGHT+IHiku0K9t8cE8WJF41+09dPt5KyLamAzs+QsVZ6ezZLvl1dSz2ajq8dUmG0z+eo/MloukBgfQwPNVK09jJrdwU=
X-Received: by 2002:a2e:3314:0:b0:2b9:e9c8:cb1 with SMTP id
 d20-20020a2e3314000000b002b9e9c80cb1mr9693536ljc.48.1692796836589; Wed, 23
 Aug 2023 06:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230817063429.31454-1-qiang.zhang1211@gmail.com>
 <CAEXW_YRizVup2Q5FQfV0N_N57mpQCcj2qnJ4nX=MsqXO=YvegA@mail.gmail.com> <CALm+0cXVGwXNgeGasVguqk0NCNAbRn6C8FHUFvs2a-SKwsSb=w@mail.gmail.com>
In-Reply-To: <CALm+0cXVGwXNgeGasVguqk0NCNAbRn6C8FHUFvs2a-SKwsSb=w@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 23 Aug 2023 09:20:25 -0400
Message-ID: <CAEXW_YREgW5T-yWSCqNnawqsrM32HGksOFWm9iGGR2XS1RLAWQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: Drop vmalloc memory info dump when double call_rcu()
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 22, 2023 at 10:27=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.com=
> wrote:
>
> >
> > On Thu, Aug 17, 2023 at 2:34=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.c=
om> wrote:
> > >
> > > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > > memory info, if the objects is not allocated from the slab allocator,
> > > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> > > need to be held, since the call_rcu() can be invoked in interrupt con=
text,
> > > therefore, there is a possibility of spinlock deadlock scenarios.
[..]
> > > -
> > > -       if (virt_addr_valid(object))
> > > +       if (is_vmalloc_addr(object))
> > > +               type =3D "vmalloc memory";
> > > +       else if (virt_addr_valid(object))
> > >                 type =3D "non-slab/vmalloc memory";
> > >         else if (object =3D=3D NULL)
> > >                 type =3D "NULL pointer";
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 93cf99aba335..224af955bcb5 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -4271,20 +4271,6 @@ void pcpu_free_vm_areas(struct vm_struct **vms=
, int nr_vms)
> > >  }
> > >  #endif /* CONFIG_SMP */
> > >
> > > -#ifdef CONFIG_PRINTK
> > > -bool vmalloc_dump_obj(void *object)
> > > -{
> > > -       struct vm_struct *vm;
> > > -       void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
> > > -
> > > -       vm =3D find_vm_area(objp);
> >
> > What about adding something like the following to vmalloc.c. Would it w=
ork?
> >
> > +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> > +{
> > +       struct vmap_area *va;
> > +
> > +       if (!spin_trylock(&vmap_area_lock))
> > +               return NULL;
> > +       va =3D __find_vmap_area(addr);
> > +       spin_unlock(&vmap_area_lock);
> > +
> > +       return va;
> > +}
> >
> > and call it from vmalloc_dump_obj():
> >
> > vm =3D find_vm_area_trylock(objp);
> >
> > And then keep the rest of your patch as it is but add back the call to
> > vmalloc_dump_obj() in mem_dump_obj():
> >
> >        if (vmalloc_dump_obj(object))
> >                return;
> >
> >  -       if (virt_addr_valid(object))
> >  +       if (is_vmalloc_addr(object))
> >  +               type =3D "vmalloc memory";
> >  +       else if (virt_addr_valid(object))
> >                  type =3D "non-slab/vmalloc memory";
> >
> >
> > If that still throws "sleeping function called" type warnings, then
> > that is a preempt RT issue because spin_trylock() on conversion to a
> > sleeping lock should not be sleeping as it is uncontended.
> >
>
> Hello, Joel
>
> I did a test in the RT kernel with the following modifications, and
> didn't trigger
> sleeping function called warning.
>
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..e07b0e34249b 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4272,12 +4272,24 @@ void pcpu_free_vm_areas(struct vm_struct
> **vms, int nr_vms)
>  #endif /* CONFIG_SMP */
>
>  #ifdef CONFIG_PRINTK
> +static struct vm_struct *find_vmap_area_trylock(unsigned long addr)
> +{
> +       struct vmap_area *va;
> +
> +       if (!spin_trylock(&vmap_area_lock))
> +               return NULL;
> +       va =3D __find_vmap_area(addr, &vmap_area_root);
> +       spin_unlock(&vmap_area_lock);
> +
> +       return va ? va->vm : NULL;
> +}
> +
>  bool vmalloc_dump_obj(void *object)
>  {
>         struct vm_struct *vm;
>         void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
>
> -       vm =3D find_vm_area(objp);
> +       vm =3D find_vmap_area_trylock((unsigned long)objp);
>         if (!vm)
>                 return false;
>         pr_cont(" %u-page vmalloc region starting at %#lx allocated at %p=
S\n",
>
>
> If double call_rcu() appears in different threads at the same time,
> It is possible to dump only one of the vmalloc information.

Great to hear and thanks for checking! So what I'll do is create 2
patches -- one for the vmalloc change, and one for the patch you
submitted to use the vmalloc change. For the second patch, I'll keep
your authorship for attribution.  I'll also queue it on my staging
trees for further testing. Let me know if that does not sound okay.

Today is a lighter work day for me, but allow me 1-2 days for sending
this out for review. Thanks,

 - Joel
