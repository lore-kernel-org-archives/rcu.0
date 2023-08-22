Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2186DEE4993
	for <rcu@archiver.kernel.org>; Tue, 22 Aug 2023 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHVTJQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHVTJP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 15:09:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EDFCD1
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 12:09:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so34004221fa.0
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692731352; x=1693336152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ugo31HJfQ2MCk8T6vDJzVQwVL3LxRwm0hR3F8jGDKU=;
        b=VJ3BOvFAr8g5Rhbg+cmcXD2vMXo896hS+UNR18eugEWpHwbw2yUvL29dqv/EDZZEov
         AwjXrrme1nqYVnKqwVSr72HXY1KLBUHsLHtrZGykkOkImKDIpqUzQaQgnbKTtR0/1KDX
         eZr7l5wxnXADZAcYbkzIs6h6EN62PRfDwN6Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731352; x=1693336152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ugo31HJfQ2MCk8T6vDJzVQwVL3LxRwm0hR3F8jGDKU=;
        b=XvCnSEOqpnkrlgu/+pXEWOsOiWRorvX4dzxxVQxNy4lX62n58TuhmlJDgBMHGsrXlm
         eXifdpDSgeEoOPkpE1k4fm4SIIyv6gL3lP8r70IL4JAcGYpHKo9TDfHfQRH4KRzs3PkE
         svQTEDKHb3yLzPw8AZ4PRUV7SZTukH0NdW54+R8DySQjhPX4eHqtf9qE/pDCMynQaV3B
         dvrvAkijKT9XajURTZL+PvEpcJXSse/EyPCIpghQQkvp+Gy3AwlouunFO9LYzM+lZvHA
         GLm/jkS52U8tKJsrevbEtDG1BhQDhTu/FjKcocT8hlwHEjISdxVq1+4XQCSBSfETLZGe
         E0KA==
X-Gm-Message-State: AOJu0YzvAvslnkVawMrox07tj6epPxHPxoXqHS789IlxZ3IFK/1bVDDD
        Qas/iEjHIMpNuwu1VLB/BCojz1SlvSdU7Ovkm/35jH4Lv9oU318U5QI=
X-Google-Smtp-Source: AGHT+IGF7EEz0TIGhWZ320R509QPVjINnbbkeCpD08ohMjxHBHWGxMdy/vcUNHMHsObrLKAgUC2/pdJei6qqKej0kRM=
X-Received: by 2002:a2e:7e06:0:b0:2b9:b27c:f727 with SMTP id
 z6-20020a2e7e06000000b002b9b27cf727mr7674500ljc.8.1692731351648; Tue, 22 Aug
 2023 12:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230817063429.31454-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230817063429.31454-1-qiang.zhang1211@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 22 Aug 2023 15:09:00 -0400
Message-ID: <CAEXW_YRizVup2Q5FQfV0N_N57mpQCcj2qnJ4nX=MsqXO=YvegA@mail.gmail.com>
Subject: Re: [PATCH] rcu: Drop vmalloc memory info dump when double call_rcu()
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 17, 2023 at 2:34=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.com> =
wrote:
>
> Currently, for double invoke call_rcu(), will dump rcu_head objects
> memory info, if the objects is not allocated from the slab allocator,
> the vmalloc_dump_obj() will be invoke and the vmap_area_lock spinlock
> need to be held, since the call_rcu() can be invoked in interrupt context=
,
> therefore, there is a possibility of spinlock deadlock scenarios.
>
> And in Preempt-RT kernel, the rcutorture test also trigger the following
> lockdep warning:
>
> BUG: sleeping function called from invalid context at kernel/locking/spin=
lock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
[...]
>
> The statistics about the source of 'rhp', the kmem_valid_obj() accounts
> for more than 97.5%, and vmalloc accounts for less than 1%, this statisti=
c
> comes from leizhen. this commit therefore drop vmalloc_dump_obj() from
> mem_dump_obj() and only check whether is vmalloc address.
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  include/linux/vmalloc.h |  5 -----
>  mm/util.c               |  7 +++----
>  mm/vmalloc.c            | 14 --------------
>  3 files changed, 3 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index c720be70c8dd..d7c4e112a4ad 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -289,10 +289,5 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vm=
s)
>  int register_vmap_purge_notifier(struct notifier_block *nb);
>  int unregister_vmap_purge_notifier(struct notifier_block *nb);
>
> -#if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
> -bool vmalloc_dump_obj(void *object);
> -#else
> -static inline bool vmalloc_dump_obj(void *object) { return false; }
> -#endif
>
>  #endif /* _LINUX_VMALLOC_H */
> diff --git a/mm/util.c b/mm/util.c
> index ddfbb22dc187..fbc007adc108 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1066,10 +1066,9 @@ void mem_dump_obj(void *object)
>         if (kmem_dump_obj(object))
>                 return;
>
> -       if (vmalloc_dump_obj(object))
> -               return;
> -
> -       if (virt_addr_valid(object))
> +       if (is_vmalloc_addr(object))
> +               type =3D "vmalloc memory";
> +       else if (virt_addr_valid(object))
>                 type =3D "non-slab/vmalloc memory";
>         else if (object =3D=3D NULL)
>                 type =3D "NULL pointer";
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..224af955bcb5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4271,20 +4271,6 @@ void pcpu_free_vm_areas(struct vm_struct **vms, in=
t nr_vms)
>  }
>  #endif /* CONFIG_SMP */
>
> -#ifdef CONFIG_PRINTK
> -bool vmalloc_dump_obj(void *object)
> -{
> -       struct vm_struct *vm;
> -       void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
> -
> -       vm =3D find_vm_area(objp);

What about adding something like the following to vmalloc.c. Would it work?

+static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
+{
+       struct vmap_area *va;
+
+       if (!spin_trylock(&vmap_area_lock))
+               return NULL;
+       va =3D __find_vmap_area(addr);
+       spin_unlock(&vmap_area_lock);
+
+       return va;
+}

and call it from vmalloc_dump_obj():

vm =3D find_vm_area_trylock(objp);

And then keep the rest of your patch as it is but add back the call to
vmalloc_dump_obj() in mem_dump_obj():

       if (vmalloc_dump_obj(object))
               return;

 -       if (virt_addr_valid(object))
 +       if (is_vmalloc_addr(object))
 +               type =3D "vmalloc memory";
 +       else if (virt_addr_valid(object))
                 type =3D "non-slab/vmalloc memory";


If that still throws "sleeping function called" type warnings, then
that is a preempt RT issue because spin_trylock() on conversion to a
sleeping lock should not be sleeping as it is uncontended.

But I could be missing something and I'll look more later. But for now
off to pick up a rental car here...

thanks,

  - Joel
