Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3332EB64D9
	for <rcu@archiver.kernel.org>; Wed, 28 Jun 2023 01:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF1Bvc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjF1Bvb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jun 2023 21:51:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E03296D;
        Tue, 27 Jun 2023 18:51:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f957a45b10so7198899e87.0;
        Tue, 27 Jun 2023 18:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687917088; x=1690509088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHLOEIRGE441RHSFnM0PxdyTL+6M7irUA/ilHSCcc3g=;
        b=hThk4s7LSQaxfVZpIrPs6jSsl+nQXRPViG1nZn82t6S4hewUATCyBqAIxy9UqmesR4
         R660h5KJiDLZxVndG5MzzeB2yHZ2OYhOj4pqJgJd2UoilHFvBHgZVHGTtJ1esghZV+uQ
         rqKALugAy6ulr0wLbrUDtOJemr0Qodyrpx4nqp7jNHr2qTZ8b/bpyOHJHCKJWuEqo0Ei
         SU/L37Oq3K6zP3fj/c/cNBJirAcIhmvNJKsuHm+YHlXzQw7h7+JMU2SruGgHpe2TTB51
         bnslFOBs1vdEoEBm0JqGdzIcTgXWXMwAY61pW8HYH0Tut4/7vXIMhe16lGAParu/JhrE
         H5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687917088; x=1690509088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHLOEIRGE441RHSFnM0PxdyTL+6M7irUA/ilHSCcc3g=;
        b=GaZRDT51ETzbWYsLYtUS+PA+v49vh3fG2Y40guUmBUNxJicxiLpJ+1OEPnZDuS2TDv
         gNuKFbwGwWXcGFLwrlSXwNqF4DkHr0BPWxl7GT6Plu5mnmhCpJS+jXnpSEKqvCDd9MPx
         C2fqffu3ZTlQJmWvM0nMOLVuHbWaKc4rEYEaHpo3O9ulzZTUwmCKj7NzYSbQ2dn6Ctem
         4wUTBM1CmVCLSVOZZ7gAR/6fplVPq+xNJ1UAgLdu5hF/GLE1zd5Bdfcwy6YtJYBCkho0
         9n18vomqOCl8/VB0kRlsMazrFcAugLNwGdJbk1zcVJcSZBxqCWmmtTn/MkDIsS6hXCVr
         Abxg==
X-Gm-Message-State: AC+VfDzrepw3N/keIW93QtwPDFeOsvlfVM8efqDyVFwWUz80k5ti8eE+
        IBJuSHMGTfpZl6Or0Zw87Aylvtxnx/obYRDk2t8=
X-Google-Smtp-Source: ACHHUZ6fjna0OjwTYTxMFoq7Vtzkonu3rQQs/8OQha8UoLfNM6ePDcsJVhNb+nPCREKaSOvn5GjtQUY9dbEtwzMXXdE=
X-Received: by 2002:a05:6512:1295:b0:4fb:8771:e898 with SMTP id
 u21-20020a056512129500b004fb8771e898mr2964785lfs.15.1687917088259; Tue, 27
 Jun 2023 18:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-13-alexei.starovoitov@gmail.com> <bfb3cbff-2837-156c-c240-5cf0a046ed38@huaweicloud.com>
 <3410a621-afc7-ba7b-47b8-b64e35f5a8fa@meta.com> <9e714217-e054-635d-a580-b677992385e5@huaweicloud.com>
In-Reply-To: <9e714217-e054-635d-a580-b677992385e5@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Jun 2023 18:51:16 -0700
Message-ID: <CAADnVQJEzv-9ovAOJzaoN0+52iPTbce8QWHcpGmmMm3_93kw-w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@meta.com>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 27, 2023 at 6:43=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 6/28/2023 8:56 AM, Alexei Starovoitov wrote:
> > On 6/25/23 4:15 AM, Hou Tao wrote:
> >> Hi,
> >>
> >> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
> >>> From: Alexei Starovoitov <ast@kernel.org>
> >>>
> >>> Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> >>> Unlike bpf_mem_[cache_]free() that links objects for immediate reuse
> >>> into
> >>> per-cpu free list the _rcu() flavor waits for RCU grace period and
> >>> then moves
> >>> objects into free_by_rcu_ttrace list where they are waiting for RCU
> >>> task trace grace period to be freed into slab.
> >> SNIP
> >>>     static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
> >>> @@ -498,8 +566,8 @@ static void free_mem_alloc_no_barrier(struct
> >>> bpf_mem_alloc *ma)
> >>>     static void free_mem_alloc(struct bpf_mem_alloc *ma)
> >>>   {
> >>> -    /* waiting_for_gp_ttrace lists was drained, but __free_rcu might
> >>> -     * still execute. Wait for it now before we freeing percpu cache=
s.
> >>> +    /* waiting_for_gp[_ttrace] lists were drained, but RCU callbacks
> >>> +     * might still execute. Wait for them.
> >>>        *
> >>>        * rcu_barrier_tasks_trace() doesn't imply
> >>> synchronize_rcu_tasks_trace(),
> >>>        * but rcu_barrier_tasks_trace() and rcu_barrier() below are
> >>> only used
> >> I think an extra rcu_barrier() before rcu_barrier_tasks_trace() is sti=
ll
> >> needed here, otherwise free_mem_alloc will not wait for inflight
> >> __free_by_rcu() and there will oops in rcu_do_batch().
> >
> > Agree. I got confused by rcu_trace_implies_rcu_gp().
> > rcu_barrier() is necessary.
> >
> > re: draining.
> > I'll switch to do if (draing) free_all; else call_rcu; scheme
> > to address potential memory leak though I wasn't able to repro it.
> For v2, it was also hard for me to reproduce the leak problem. But after
> I injected some delay by using udelay() in __free_by_rcu/__free_rcu()
> after reading c->draining, it was relatively easy to reproduce the proble=
ms.

1. Please respin htab bench.
We're still discussing patching without having the same base line.

2. 'adding udelay()' is too vague. Pls post a diff hunk of what exactly
you mean.

3. I'll send v3 shortly. Let's move discussion there.
