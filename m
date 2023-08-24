Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BDBC3DA66
	for <rcu@archiver.kernel.org>; Thu, 24 Aug 2023 02:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbjHXCJt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Aug 2023 22:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbjHXCJc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Aug 2023 22:09:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7294E75
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 19:09:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-56c2e882416so2359510a12.3
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692842969; x=1693447769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoy7tYut3BqiTJPLKX+4DMnZb7OZZv04ZDYzXDTnRLE=;
        b=RPx6lqs+aQ7IEt6v1Z6M6mmJiF7UIJelurrYbxHtNKP5jIGp6ncvVRhocgTpFreVK4
         87IXgE7BOfWMpmev3hBUOgQI59okm1P/CtqsQgz4WapATE7sgho2dpGGn704xKz7Pjje
         sx/IQufHjDGpZu6UgeJbSCGrnepXYSqKXgPl71x4BL8tY5ZakmqSEePOYMzWxZl6bHuW
         g/uyX/bPvtUUdQr9tme/hYJCVdVmX9z9ZqEuPnoJkxvTp+/MKIzZlnEpNbdfVt1ZmQIf
         rCRWYI9y2eAvbitueLadK9i+uxIydZg2L+7VJLPqUjH6aZMlhfrUljVqFID3gVAwI+rE
         7MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692842969; x=1693447769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoy7tYut3BqiTJPLKX+4DMnZb7OZZv04ZDYzXDTnRLE=;
        b=cdkNDpSdbQ+4JusLwxUNu7zhGakAI53VghEbQaYTPXaXYtG6di5M4Vq2NBkJd4ub8U
         ZI5yBDALQM2id6EkrhnQB4LUQM07Zo+EjUSFfOtyFlnJ7qrmEF9Z/LHUGBtJLoeMAIaY
         1PnVvH4mkT8Wj+j0dn0fBZaMlubpF06+y/MHE1+YgcF3dJ38b1njFh3zXTBtyvpEjCrb
         UCuOoJJYrDKs6nJQo69BiHqbvdJgEQX1C7oTc24PXWzKTHWyXUbgnA/DCadw534eeih0
         NvSpxpEPL2pJZVdQ5jSKOnFRpfU/m8e6W5jDqintlu8aL5U04TF7pcPFzMtyQ5X74wPJ
         6ZVA==
X-Gm-Message-State: AOJu0YzTB53/9mA6++KVdLUPdYuMVLI5GGFwOMotvvMhoEQDZiNEuuyN
        NRQiXiDRWtbReNge3E1wipf+cNkHwmhFiRtNAIY=
X-Google-Smtp-Source: AGHT+IF2syExKVwHjIMZhGWNK2V+myvAzq6We9q9h0CgMZ8NZfequ7CJZNuEMaot2MkRB76SHZgJ6F+TfCW3iPS08fw=
X-Received: by 2002:a17:90b:e84:b0:269:1abd:3ba6 with SMTP id
 fv4-20020a17090b0e8400b002691abd3ba6mr11462086pjb.28.1692842969166; Wed, 23
 Aug 2023 19:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230817063429.31454-1-qiang.zhang1211@gmail.com>
 <CAEXW_YRizVup2Q5FQfV0N_N57mpQCcj2qnJ4nX=MsqXO=YvegA@mail.gmail.com>
 <CALm+0cXVGwXNgeGasVguqk0NCNAbRn6C8FHUFvs2a-SKwsSb=w@mail.gmail.com> <CAEXW_YREgW5T-yWSCqNnawqsrM32HGksOFWm9iGGR2XS1RLAWQ@mail.gmail.com>
In-Reply-To: <CAEXW_YREgW5T-yWSCqNnawqsrM32HGksOFWm9iGGR2XS1RLAWQ@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Thu, 24 Aug 2023 10:09:17 +0800
Message-ID: <CALm+0cVRc1Jk4UbVTY1gC1Cb6DQPrGcK2s900vT8DiFtmkbXZg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Drop vmalloc memory info dump when double call_rcu()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

>
> On Tue, Aug 22, 2023 at 10:27=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.c=
om> wrote:
> >
> > >
> > > On Thu, Aug 17, 2023 at 2:34=E2=80=AFAM Zqiang <qiang.zhang1211@gmail=
.com> wrote:
> > > >
> > > > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > > > memory info, if the objects is not allocated from the slab allocato=
r,
> > > > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlo=
ck
> > > > need to be held, since the call_rcu() can be invoked in interrupt c=
ontext,
> > > > therefore, there is a possibility of spinlock deadlock scenarios.
> [..]
> > > > -
> > > > -       if (virt_addr_valid(object))
> > > > +       if (is_vmalloc_addr(object))
> > > > +               type =3D "vmalloc memory";
> > > > +       else if (virt_addr_valid(object))
> > > >                 type =3D "non-slab/vmalloc memory";
> > > >         else if (object =3D=3D NULL)
> > > >                 type =3D "NULL pointer";
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 93cf99aba335..224af955bcb5 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -4271,20 +4271,6 @@ void pcpu_free_vm_areas(struct vm_struct **v=
ms, int nr_vms)
> > > >  }
> > > >  #endif /* CONFIG_SMP */
> > > >
> > > > -#ifdef CONFIG_PRINTK
> > > > -bool vmalloc_dump_obj(void *object)
> > > > -{
> > > > -       struct vm_struct *vm;
> > > > -       void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
> > > > -
> > > > -       vm =3D find_vm_area(objp);
> > >
> > > What about adding something like the following to vmalloc.c. Would it=
 work?
> > >
> > > +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> > > +{
> > > +       struct vmap_area *va;
> > > +
> > > +       if (!spin_trylock(&vmap_area_lock))
> > > +               return NULL;
> > > +       va =3D __find_vmap_area(addr);
> > > +       spin_unlock(&vmap_area_lock);
> > > +
> > > +       return va;
> > > +}
> > >
> > > and call it from vmalloc_dump_obj():
> > >
> > > vm =3D find_vm_area_trylock(objp);
> > >
> > > And then keep the rest of your patch as it is but add back the call t=
o
> > > vmalloc_dump_obj() in mem_dump_obj():
> > >
> > >        if (vmalloc_dump_obj(object))
> > >                return;
> > >
> > >  -       if (virt_addr_valid(object))
> > >  +       if (is_vmalloc_addr(object))
> > >  +               type =3D "vmalloc memory";
> > >  +       else if (virt_addr_valid(object))
> > >                  type =3D "non-slab/vmalloc memory";
> > >
> > >
> > > If that still throws "sleeping function called" type warnings, then
> > > that is a preempt RT issue because spin_trylock() on conversion to a
> > > sleeping lock should not be sleeping as it is uncontended.
> > >
> >
> > Hello, Joel
> >
> > I did a test in the RT kernel with the following modifications, and
> > didn't trigger
> > sleeping function called warning.
> >
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 93cf99aba335..e07b0e34249b 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4272,12 +4272,24 @@ void pcpu_free_vm_areas(struct vm_struct
> > **vms, int nr_vms)
> >  #endif /* CONFIG_SMP */
> >
> >  #ifdef CONFIG_PRINTK
> > +static struct vm_struct *find_vmap_area_trylock(unsigned long addr)
> > +{
> > +       struct vmap_area *va;
> > +
> > +       if (!spin_trylock(&vmap_area_lock))
> > +               return NULL;
> > +       va =3D __find_vmap_area(addr, &vmap_area_root);
> > +       spin_unlock(&vmap_area_lock);
> > +
> > +       return va ? va->vm : NULL;
> > +}
> > +
> >  bool vmalloc_dump_obj(void *object)
> >  {
> >         struct vm_struct *vm;
> >         void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
> >
> > -       vm =3D find_vm_area(objp);
> > +       vm =3D find_vmap_area_trylock((unsigned long)objp);
> >         if (!vm)
> >                 return false;
> >         pr_cont(" %u-page vmalloc region starting at %#lx allocated at =
%pS\n",
> >
> >
> > If double call_rcu() appears in different threads at the same time,
> > It is possible to dump only one of the vmalloc information.
>
> Great to hear and thanks for checking! So what I'll do is create 2
> patches -- one for the vmalloc change, and one for the patch you
> submitted to use the vmalloc change. For the second patch, I'll keep
> your authorship for attribution.  I'll also queue it on my staging
> trees for further testing. Let me know if that does not sound okay.
>


Thanks, Joel. It's okay :)


> Today is a lighter work day for me, but allow me 1-2 days for sending
> this out for review. Thanks,
>
>  - Joel
