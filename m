Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E2EE49A3
	for <rcu@archiver.kernel.org>; Wed, 23 Aug 2023 02:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHWC1l (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 22:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjHWC1k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 22:27:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD2FB
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 19:27:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26b3f4d3372so2848737a91.3
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692757657; x=1693362457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkVNEqSfBDUwXt3WOcaA7XBJ9eTOVIiwYeI/cHVAXtc=;
        b=KYVqmNb2e251z7SK7zqA5HwuaUXE/MX/PdnjdpURJxdHRgj9TW1D/3P1mK8xzffbwG
         US67Nbz+Gl1o6G7DOxhWYaLFYzldz3yeyRlLdtq3O1+umBOY08MYWOm9dLVwTny7Whbl
         jhH2VibH883v4G0CFZAi0/6IT1gHDLg3GXi50DgGKgasUVnHyl5RlUhtWHJRPG4Doqhc
         KW8kGiw1UiYJGpCDwWxR8A/HIPhNAnk/B9r6O1J5dHMTqowO1fYw/zWsFtPraTJT6bz0
         1aadmzbW2UI2Ki953T6vhK6BmhIOpbLDrZv8h1t/yUdtcDL7HCpuu6q7OvR3dXeIbCQZ
         z5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692757657; x=1693362457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkVNEqSfBDUwXt3WOcaA7XBJ9eTOVIiwYeI/cHVAXtc=;
        b=CLMIwuy2dADbGSRefK0EJMKIPeUFowJi7cX9OBPCxYlXjXP+E7B8B3GQUNtKfBJmHB
         V0HdcWVlQVyHDx06YHRcO/+hl44FKQVU+w8yrenuxtxhrbmy0qLTYgqjebU1I8bFa2sq
         yTo/wOcDtyd+IKDJufw0VQtR9PAyM0Pl8JcOpNx4e/mzVvzFUb5z3OZGcoCvg6Wv2kqi
         r8fu71jgh2EhZ6bWfi30eNZFqcaoSdvy6z5xmm08Il6xtKh3wricqTnMOTMTBlgLmaDy
         kqQLVTPsvu0gTcuYmS7WV6M+6NM+P/AALdOl0RNHcGxE0DJSlQW2M4c4pu7d1FJLgJAJ
         6TeA==
X-Gm-Message-State: AOJu0YwqCFux+gJ4oXKXtJKaI+1pjNsm5yVNvjQI7kc5gfJxW4nwNkDv
        b100sW4bUbu0NabH6ed50bBexCFzZAop3Ns9HRQ=
X-Google-Smtp-Source: AGHT+IGVVTl67l02YsuQvNTjgIZDWv8RUvsnwKgwa84vjZFrmf+r4fLjB2gJ4yl3Izw3qcB7WqFjq67oE2tjduibQBU=
X-Received: by 2002:a17:90a:674d:b0:26b:1364:e784 with SMTP id
 c13-20020a17090a674d00b0026b1364e784mr8119007pjm.0.1692757657515; Tue, 22 Aug
 2023 19:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230817063429.31454-1-qiang.zhang1211@gmail.com> <CAEXW_YRizVup2Q5FQfV0N_N57mpQCcj2qnJ4nX=MsqXO=YvegA@mail.gmail.com>
In-Reply-To: <CAEXW_YRizVup2Q5FQfV0N_N57mpQCcj2qnJ4nX=MsqXO=YvegA@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Wed, 23 Aug 2023 10:27:25 +0800
Message-ID: <CALm+0cXVGwXNgeGasVguqk0NCNAbRn6C8FHUFvs2a-SKwsSb=w@mail.gmail.com>
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
> On Thu, Aug 17, 2023 at 2:34=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.com=
> wrote:
> >
> > Currently, for double invoke call_rcu(), will dump rcu_head objects
> > memory info, if the objects is not allocated from the slab allocator,
> > the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> > need to be held, since the call_rcu() can be invoked in interrupt conte=
xt,
> > therefore, there is a possibility of spinlock deadlock scenarios.
> >
> > And in Preempt-RT kernel, the rcutorture test also trigger the followin=
g
> > lockdep warning:
> >
> > BUG: sleeping function called from invalid context at kernel/locking/sp=
inlock_rt.c:48
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper=
/0
> [...]
> >
> > The statistics about the source of 'rhp', the kmem_valid_obj() accounts
> > for more than 97.5%, and vmalloc accounts for less than 1%, this statis=
tic
> > comes from leizhen. this commit therefore drop vmalloc_dump_obj() from
> > mem_dump_obj() and only check whether is vmalloc address.
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > ---
> >  include/linux/vmalloc.h |  5 -----
> >  mm/util.c               |  7 +++----
> >  mm/vmalloc.c            | 14 --------------
> >  3 files changed, 3 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index c720be70c8dd..d7c4e112a4ad 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -289,10 +289,5 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_=
vms)
> >  int register_vmap_purge_notifier(struct notifier_block *nb);
> >  int unregister_vmap_purge_notifier(struct notifier_block *nb);
> >
> > -#if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
> > -bool vmalloc_dump_obj(void *object);
> > -#else
> > -static inline bool vmalloc_dump_obj(void *object) { return false; }
> > -#endif
> >
> >  #endif /* _LINUX_VMALLOC_H */
> > diff --git a/mm/util.c b/mm/util.c
> > index ddfbb22dc187..fbc007adc108 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1066,10 +1066,9 @@ void mem_dump_obj(void *object)
> >         if (kmem_dump_obj(object))
> >                 return;
> >
> > -       if (vmalloc_dump_obj(object))
> > -               return;
> > -
> > -       if (virt_addr_valid(object))
> > +       if (is_vmalloc_addr(object))
> > +               type =3D "vmalloc memory";
> > +       else if (virt_addr_valid(object))
> >                 type =3D "non-slab/vmalloc memory";
> >         else if (object =3D=3D NULL)
> >                 type =3D "NULL pointer";
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 93cf99aba335..224af955bcb5 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4271,20 +4271,6 @@ void pcpu_free_vm_areas(struct vm_struct **vms, =
int nr_vms)
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > -#ifdef CONFIG_PRINTK
> > -bool vmalloc_dump_obj(void *object)
> > -{
> > -       struct vm_struct *vm;
> > -       void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
> > -
> > -       vm =3D find_vm_area(objp);
>
> What about adding something like the following to vmalloc.c. Would it wor=
k?
>
> +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> +{
> +       struct vmap_area *va;
> +
> +       if (!spin_trylock(&vmap_area_lock))
> +               return NULL;
> +       va =3D __find_vmap_area(addr);
> +       spin_unlock(&vmap_area_lock);
> +
> +       return va;
> +}
>
> and call it from vmalloc_dump_obj():
>
> vm =3D find_vm_area_trylock(objp);
>
> And then keep the rest of your patch as it is but add back the call to
> vmalloc_dump_obj() in mem_dump_obj():
>
>        if (vmalloc_dump_obj(object))
>                return;
>
>  -       if (virt_addr_valid(object))
>  +       if (is_vmalloc_addr(object))
>  +               type =3D "vmalloc memory";
>  +       else if (virt_addr_valid(object))
>                  type =3D "non-slab/vmalloc memory";
>
>
> If that still throws "sleeping function called" type warnings, then
> that is a preempt RT issue because spin_trylock() on conversion to a
> sleeping lock should not be sleeping as it is uncontended.
>

Hello, Joel

I did a test in the RT kernel with the following modifications, and
didn't trigger
sleeping function called warning.


diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 93cf99aba335..e07b0e34249b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4272,12 +4272,24 @@ void pcpu_free_vm_areas(struct vm_struct
**vms, int nr_vms)
 #endif /* CONFIG_SMP */

 #ifdef CONFIG_PRINTK
+static struct vm_struct *find_vmap_area_trylock(unsigned long addr)
+{
+       struct vmap_area *va;
+
+       if (!spin_trylock(&vmap_area_lock))
+               return NULL;
+       va =3D __find_vmap_area(addr, &vmap_area_root);
+       spin_unlock(&vmap_area_lock);
+
+       return va ? va->vm : NULL;
+}
+
 bool vmalloc_dump_obj(void *object)
 {
        struct vm_struct *vm;
        void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);

-       vm =3D find_vm_area(objp);
+       vm =3D find_vmap_area_trylock((unsigned long)objp);
        if (!vm)
                return false;
        pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\=
n",


If double call_rcu() appears in different threads at the same time,
It is possible to dump only one of the vmalloc information.


Thanks
Zqiang


>
> But I could be missing something and I'll look more later. But for now
> off to pick up a rental car here...
>
> thanks,
>
>   - Joel
