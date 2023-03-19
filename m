Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F1C7618A
	for <rcu@archiver.kernel.org>; Sun, 19 Mar 2023 01:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCSBbX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Mar 2023 21:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCSBbW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Mar 2023 21:31:22 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0125E21
        for <rcu@vger.kernel.org>; Sat, 18 Mar 2023 18:31:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-53d277c1834so164558667b3.10
        for <rcu@vger.kernel.org>; Sat, 18 Mar 2023 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679189479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWYTMFokx+FNmYyt2BQcwEvITYQbjiIZnBOvRZhHf74=;
        b=ReZB9+hDzODkVMI7vtYYve2y5YGP1qn/3M3mT6hA2xbi0ynkKReA0xV6GHGEDUZROA
         8yPYCyE9tf4BUBw6tEY5Bo10l5aW9Yrffz9ADkGlzDQqt1n7tUVr1THula6uawR2S9Pm
         edMbocAX6NRYzXhpo0Idf+GcqVYdPxvL//H5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679189479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWYTMFokx+FNmYyt2BQcwEvITYQbjiIZnBOvRZhHf74=;
        b=P77Ac+cWYv7DtDqyTHNvNqmVncaVwox+MuMLSdz+/5siRhG9AC6nM3vgWe6I6NwjqC
         pZiBab756SXNLQ2pJ5WrQhp7YNrKbPPZTy7GcjOliIPkSFXi34EHSN+uKiOInHIV2h2b
         Q32+CsCLwEYKw2vYWps9ueJqkmYbmU4UHaJBSb6xHw8i8eFQZm5ORVfYGCCqXphSVAlY
         uwH92iI3pvkqJgDhFaiL37bMbcBENyCf0na/47yeiV017ZmF1bYhk6g79S72slPzxUAB
         0N2PbebLX4eV/XZG94D3igrkVfnZ/1cCqeUtvGt/e6l/vkivDZ6Sxc8Fq9SCJfgLkgwN
         TRMw==
X-Gm-Message-State: AO0yUKW/PT23dur6Cejq9kvih2SEoRi5OYN7VybaQsc81Ln+T5IEHRJI
        QqHmnJ9bc2wtzmuA15RQhqzsMOm5Y5eNZvSQligrc49Hi/Ajo1w5cnA=
X-Google-Smtp-Source: AK7set+BXp2lPY3xn6HeGoNMyVz+m9NQ3WAzBAuBfmTqwW7nwI+D5XxOtjby5ZYeKbFcoiw+p7JP9VJvcsNV7T2Zbx4=
X-Received: by 2002:a81:ac10:0:b0:544:b8c2:3cf4 with SMTP id
 k16-20020a81ac10000000b00544b8c23cf4mr4892294ywh.1.1679189479679; Sat, 18 Mar
 2023 18:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230318132435.3671003-1-qiang1.zhang@intel.com>
In-Reply-To: <20230318132435.3671003-1-qiang1.zhang@intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 18 Mar 2023 21:31:08 -0400
Message-ID: <CAEXW_YQ2xGuy4ebPjyVAp4SJQUo=Wr8uAw9BnUsjgvozzhuUeg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Fix incorrect trace string in rcu_boost_kthread()
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Mar 18, 2023 at 9:20=E2=80=AFAM Zqiang <qiang1.zhang@intel.com> wro=
te:
>
> Currently, the trace string information before and after rcu_wait()
> and schedule_timeout_idle() are reversed, this commit therefore
> switches these strings in order to correctly trace.

I suggest provide more details of how this affects your tracing. One
commit to draw inspiration from could be:

f7f7bac9cb1c ("rcu: Have the RCU tracepoints use the tracepoint_string
infrastructure")

Which also modifies the same code.

>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_plugin.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7b0fe741a088..7b622b5196a8 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1114,10 +1114,10 @@ static int rcu_boost_kthread(void *arg)
>         trace_rcu_utilization(TPS("Start boost kthread@init"));
>         for (;;) {
>                 WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING=
);
> -               trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
> +               trace_rcu_utilization(TPS("Start boost kthread@rcu_wait")=
);

Doesn't that look weird because now you will have 2 "Start boost
kthread@" messages in succession (one of them coming before the for
loop) ?

>                 rcu_wait(READ_ONCE(rnp->boost_tasks) ||
>                          READ_ONCE(rnp->exp_tasks));
> -               trace_rcu_utilization(TPS("Start boost kthread@rcu_wait")=
);
> +               trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
>                 WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING=
);
>                 more2boost =3D rcu_boost(rnp);

Also, it is weird here that you are calling rcu_boost() right after
printing "End boost kthread".

thanks,

 - Joel



>                 if (more2boost)
> @@ -1126,9 +1126,9 @@ static int rcu_boost_kthread(void *arg)
>                         spincnt =3D 0;
>                 if (spincnt > 10) {
>                         WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD=
_YIELDING);
> -                       trace_rcu_utilization(TPS("End boost kthread@rcu_=
yield"));
> -                       schedule_timeout_idle(2);
>                         trace_rcu_utilization(TPS("Start boost kthread@rc=
u_yield"));
> +                       schedule_timeout_idle(2);
> +                       trace_rcu_utilization(TPS("End boost kthread@rcu_=
yield"));
>                         spincnt =3D 0;
>                 }
>         }
> --
> 2.25.1
>
