Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED4EC433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiDHKXS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 06:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDHKXS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 06:23:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4996140DC6
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 03:21:14 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z7so10089821iom.1
        for <rcu@vger.kernel.org>; Fri, 08 Apr 2022 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiDN7k6aC8ZwYDiFSJSV9wrBF+tzi9VGwTXl8N4IGsA=;
        b=xe6Sx6YnpT8qRY77m0yznqYAK7saEHhq+hJLli+HkXPONxuO4flT1bUYpsx0oSPEVg
         XWWoaTTaK7OmZUyXdVqg6bVaddQpNTFyYu+wYlfYEml4uytnsN5qXispMHUC/vqynwKa
         bW6YQcY8XUnsrva+TGmfOW9o/Gm1IYjw9ZdqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiDN7k6aC8ZwYDiFSJSV9wrBF+tzi9VGwTXl8N4IGsA=;
        b=h4zPE1jLquKxTE5acrrPCG2gcjOjB8XC3uhaH8jnNoUt+2UAeTrbkZIqLaHj0VqIjm
         LLmI+tmo/t2HsJybfNLuQ0llUcV2Rcjrlx0N0Lx1HPGOF8oBKxSKMpZ9vcZiv/M8XGtU
         4q1Uzm7B5MgtICbTxJw5iHojj71EqSovDSbTLZofkvVNWn7eUiuDxtRyjF3HHvJDvl4n
         mcgK2vS8hA+Wi1WgQtEz9ar0oBfECftYzj5PsbPowI/piCsVaGPodmeHvZl0fsD9kcwB
         0dJsaD5Qsny2/g8fou6ILzEM0oR/exCEqSdUMnAiJY0kmLxTQRboWrfZxankmYm2OdsL
         hdEA==
X-Gm-Message-State: AOAM5305nKmBayDhpdEXfmnp1rpkYdG6vemwOGQSc0SVF25WUlrtqED7
        q9jXkw/jee9Xto8WCYxNemPncwtAdhD+UEtPjn3qIA==
X-Google-Smtp-Source: ABdhPJzCKUtlciLHhXB49c82badUbJaguTQiw22dcg/5qKqwQVnRmiOYZEtGtZ0v0BQCKXuRFjjhOxRw4N9RZ0lonGQ=
X-Received: by 2002:a05:6638:130d:b0:323:8fba:8a15 with SMTP id
 r13-20020a056638130d00b003238fba8a15mr9476118jad.270.1649413274312; Fri, 08
 Apr 2022 03:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
In-Reply-To: <20220408045734.1158817-1-kaleshsingh@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 06:21:03 -0400
Message-ID: <CAEXW_YSqY2nFZrn4AjpUzJ+dwZc7jaVMG9RG5gvTyb3zFYWtQA@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
[..]
> +config RCU_EXP_KTHREAD
> +       bool "Perform RCU expedited work in a real-time kthread"
> +       depends on RCU_BOOST && RCU_EXPERT

Doesn't this disable the fix if a system is not RCU_EXPERT ?  Please
see the definition of RCU_EXPERT:
"This option needs to be enabled if you wish to make expert-level
adjustments to RCU configuration."

I don't think a bug fix counts as an expert-level adjustment.

> +       default !PREEMPT_RT && NR_CPUS <= 32

What is the benefit of turning it off on PREEMPT_RT, even if
PREEMPT_RT does not use expedited GPs much post-boot? I would think in
the future if PREEMPT_RT ever uses expedited GPs, they would want this
feature even more. I'd rather be future-proof now as I don't see any
advantages of disabling it on !PREEMPT_RT (And a drawback that the fix
won't apply to those systems). Also will keep the config simple.

> +       help
> +         Use this option to further reduce the latencies of expedited
> +         grace periods at the expense of being more disruptive.
> +
> +         Accept the default if unsure.
> +
>  config RCU_NOCB_CPU
>         bool "Offload RCU callback processing from boot-selected CPUs"
>         depends on TREE_RCU
[...]

Thanks,

 - Joel
