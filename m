Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A109EB64DA
	for <rcu@archiver.kernel.org>; Mon, 26 Jun 2023 16:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjFZQJl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjFZQJf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Jun 2023 12:09:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D6DC6;
        Mon, 26 Jun 2023 09:09:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69a48368fso26299171fa.0;
        Mon, 26 Jun 2023 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687795772; x=1690387772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/NDHED1ujs/UngC21AHkpHgu///ga1PH3JBVVsZqBI=;
        b=ULHpwXalkFaN6co9yTin1SgSWeK9zwgxJ5P0xLvcLzqfjuGvLXsLoTHPQdWexGAem3
         9rTUlca6k+rXRU+XIYh5wrFcwX6ApCKP6U4+eFx/tLJOCzdsmObx9/DqItY0r0G0uU/B
         wjpEr7Obib/slLrfdLxX30UiFoNqreS3qFOX4JCECNXK2a42bQXzWq/x4POzJkw0bmu6
         /wESuB+Cy8rbx/7kQjFVzwuaiB+In4qU3SYAocy4QYthwZtRPZvq9Nf9fYQOR8UPZSmK
         VIjJIai/8ujWprhd9ckTd2nTZw+55BOo2std2IgQ3NgzhCcctyiLjCB8nfubp/YrJZOC
         CAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795772; x=1690387772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/NDHED1ujs/UngC21AHkpHgu///ga1PH3JBVVsZqBI=;
        b=UHM5WDxR67gqputDAs7BcRSSIsuHSMIpNalzFP8dJ1LIz/Jr1ld4RkzWfVFhOEyEaT
         9An1VnbHu2GGqrGqvezIAOz2hRwjoFUhK8nLLKJfAz0P1pZ0zy46RtaY1o7f0tOIfqeK
         VFoJleTe2v1jhUM5dj9fYFaXUGADTcCb96vcxtPdDXKxpiAnEsF1YI75FOvU3tGnUagA
         VwtOx30TACPgIazuwwWrm3QwakrMNrmce/pzjZXBE0eO5lnd2JQgSFfIbiDkboz5Pw2L
         18cgxE2uH8khcwUs5bKFYeVfCDOsJ3VNvCpeEBLE+6SY3+VRlyqyE2OI1itxdxvxQ+uD
         vttg==
X-Gm-Message-State: AC+VfDwWY9kqu7QQIvCTvSaZQpjrJ7Uh6Of+SFSHGrmWnZfC8A9RXJzH
        6aJ9gol/O34wi0JXoiJtIQfnhjoEVba4ej/JTjk=
X-Google-Smtp-Source: ACHHUZ70+cJtyMN34gDSOW/vgF01LinpLLaWrJ2nrQmr/F0NOwUD1zLw62Oxofz49FVdGFTrETheAKcLJuqH8L8RISw=
X-Received: by 2002:a2e:b049:0:b0:2b6:a2dc:7681 with SMTP id
 d9-20020a2eb049000000b002b6a2dc7681mr1894285ljl.6.1687795772144; Mon, 26 Jun
 2023 09:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-14-alexei.starovoitov@gmail.com> <20230626154228.GA6798@maniforge>
In-Reply-To: <20230626154228.GA6798@maniforge>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 26 Jun 2023 09:09:20 -0700
Message-ID: <CAADnVQK7rgcSevdyrG8t-rPqg-n8=Eic8K63q-q3SPtOR0VP2Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 13/13] bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
To:     David Vernet <void@manifault.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hou Tao <houtao@huaweicloud.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 26, 2023 at 8:42=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
>
> On Fri, Jun 23, 2023 at 08:13:33PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Convert bpf_cpumask to bpf_mem_cache_free_rcu.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: David Vernet <void@manifault.com>
>
> LGTM, thanks for cleaning this up. I left one drive-by comment /
> observation below, but it's not a blocker for this patch / series.
>
> > ---
> >  kernel/bpf/cpumask.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > index 938a60ff4295..6983af8e093c 100644
> > --- a/kernel/bpf/cpumask.c
> > +++ b/kernel/bpf/cpumask.c
> > @@ -9,7 +9,6 @@
> >  /**
> >   * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
> >   * @cpumask: The actual cpumask embedded in the struct.
> > - * @rcu:     The RCU head used to free the cpumask with RCU safety.
> >   * @usage:   Object reference counter. When the refcount goes to 0, th=
e
> >   *           memory is released back to the BPF allocator, which provi=
des
> >   *           RCU safety.
> > @@ -25,7 +24,6 @@
> >   */
> >  struct bpf_cpumask {
> >       cpumask_t cpumask;
> > -     struct rcu_head rcu;
> >       refcount_t usage;
> >  };
> >
> > @@ -82,16 +80,6 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(=
struct bpf_cpumask *cpumask)
> >       return cpumask;
> >  }
> >
> > -static void cpumask_free_cb(struct rcu_head *head)
> > -{
> > -     struct bpf_cpumask *cpumask;
> > -
> > -     cpumask =3D container_of(head, struct bpf_cpumask, rcu);
> > -     migrate_disable();
> > -     bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
> > -     migrate_enable();
> > -}
> > -
> >  /**
> >   * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
> >   * @cpumask: The cpumask being released.
> > @@ -102,8 +90,12 @@ static void cpumask_free_cb(struct rcu_head *head)
> >   */
> >  __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
> >  {
> > -     if (refcount_dec_and_test(&cpumask->usage))
> > -             call_rcu(&cpumask->rcu, cpumask_free_cb);
> > +     if (!refcount_dec_and_test(&cpumask->usage))
> > +             return;
> > +
> > +     migrate_disable();
> > +     bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
> > +     migrate_enable();
>
> The fact that callers have to disable migration like this in order to
> safely free the memory feels a bit leaky. Is there any reason we can't
> move this into bpf_mem_{cache_}free_rcu()?

migrate_disable/enable() are actually not necessary here.
We can call bpf_mem_cache_free_rcu() directly from any kfunc.
Explicit migrate_disable() is only necessary from syscall.
I believe rcu callbacks also cannot migrate, so the existing
code probably doesn't need them either.
