Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDC1ECAAD3
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 06:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIOGL2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Sep 2022 02:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOGL0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Sep 2022 02:11:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14792F66
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 23:11:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f14so27750913lfg.5
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O7U2hq68sMkSIeccrcZogejC7EJ1YA720g5ClwAs7tQ=;
        b=JQXvliYjR00Z2PGwDvHk5j8F0CnpyPWymGZWwOzhCFTPsaDoTwrNKSox3j/EFIgXKG
         BfyNLlv/Kx4vpdxhg6nw9GypgmtuJjD4+tcQedQrYHKWzIBl3E7dtoX634BE08FfKYRy
         D1AcfZbj70SQbAldZyEsk6actl+ngEzNqdQ1ifR8eQivIHFlFqHtlMdEs3Sop0ynGAks
         4eg6yCSewnlgjpDEvLUpvVcpp1MzLyeXdVFsTa7QsHUsBxFxRw4/pWlUWa/r+e2xparE
         3wgLWVo5JKtikzAOAndLuehRbCsjokcUdDEdwYLSG81WY5ged2URMkLPSFMSg0dv3gfY
         lIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O7U2hq68sMkSIeccrcZogejC7EJ1YA720g5ClwAs7tQ=;
        b=VvJYHmQXVYen11+ZGnhRa9bb4jPoHCvEeno93nd0wlzWVch4Rw+RMj/7dMDuUi46W0
         swe7702zUDXJ0N1wxOut3BnawRsUWGYXWQPiO3S92BFUOy8fyWJ9WT2Qxhh1WlFk5bcc
         +xoSCUXnoN1raclzPJapXkYTibZuUzy4I+V0G6Y1+vUSu+u6hpmhUQiqFSGdV3zzVAtv
         3pZze+iEl1c5pc8Jn1WEEDVMC1eNsjp0id4W1ZMd1WyQZ9X3vLSxHGoELdL9mG5DI0No
         HCR5/UyTm1mNjVNiotq5bPzn4JjdQgX8wd5lsuEo7XMuuDT9RvZjJXJrLJpywI2oKLMo
         gh1w==
X-Gm-Message-State: ACgBeo27ivRkvxtPImLPF/cqcrCnUVXFrjSka8sqngdt2RoHPtb3aFko
        rsTR7xvhSqwtv435ggxZ+CZHMB8NKeF+k0Yh8uuzNxc=
X-Google-Smtp-Source: AA6agR4AmZUEIn3fEnw4qFY/q0VQP2CVpT84fLcEXbkvDpelcgi/53qpFsI47ibEPhFvGdLoW4X+QAu3eTs7yA0nKcU=
X-Received: by 2002:a05:6512:3e4:b0:497:a649:6627 with SMTP id
 n4-20020a05651203e400b00497a6496627mr14286510lfq.326.1663222282990; Wed, 14
 Sep 2022 23:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-2-kernelfans@gmail.com>
In-Reply-To: <20220915055825.21525-2-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 15 Sep 2022 14:11:11 +0800
Message-ID: <CAFgQCTtwOhPh9SxGwV3eNBDanHNzo8O1teYFKE7i4xc4bgMegQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when rcutree_online_cpu()
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

If you pick up this one from my V1, could you drop it? Since I have
rephrased the commit log and comment in the code.  Sorry for the
inconvenience.

On Thu, Sep 15, 2022 at 1:58 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> rcutree_online_cpu() is concurrent, so there is the following race
> scene:
>
>         CPU 1                               CPU2
> mask_old = rcu_rnp_online_cpus(rnp);
> ...
>
>                                    mask_new = rcu_rnp_online_cpus(rnp);
>                                    ...
>                                    set_cpus_allowed_ptr(t, cm);
>
> set_cpus_allowed_ptr(t, cm);
>
> Consequently, the old mask will overwrite the new mask in the task's cpus_ptr.
>
> Since there is a mutex ->boost_kthread_mutex, using it to build an
> order, then the latest ->qsmaskinitnext will be fetched for updating cpus_ptr.
>
> But for concurrent offlining, ->qsmaskinitnext is not reilable when
> rcutree_offline_cpu(). That is another story and comes in the following
> patch.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/tree_plugin.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 438ecae6bd7e..ef6d3ae239b9 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  {
>         struct task_struct *t = rnp->boost_kthread_task;
> -       unsigned long mask = rcu_rnp_online_cpus(rnp);
> +       unsigned long mask;
>         cpumask_var_t cm;
>         int cpu;
>
> @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>         if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
>                 return;
>         mutex_lock(&rnp->boost_kthread_mutex);
> +       /*
> +        * Relying on the lock to serialize, so when onlining, the latest
> +        * qsmaskinitnext is for cpus_ptr.
> +        */

In the comment, I put accent on 'onlining' which is different from V1

Thanks,

Pingfan

> +       mask = rcu_rnp_online_cpus(rnp);
>         for_each_leaf_node_possible_cpu(rnp, cpu)
>                 if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
>                     cpu != outgoingcpu)
> --
> 2.31.1
>
