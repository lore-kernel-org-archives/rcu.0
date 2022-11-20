Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D14C433FE
	for <rcu@archiver.kernel.org>; Sun, 20 Nov 2022 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKTPYC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Nov 2022 10:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTPYC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Nov 2022 10:24:02 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16B41F9E6
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 07:23:59 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id d20so12016506ljc.12
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 07:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+oInBhIZV9nWNWPJmO5ivshz2z/OsQMUnwoFUIGakQ=;
        b=Ko0iQKc4DG0c8Rhj+Fn/ZjoKaUPKzvoWJswCaBj4TElAkLT2CFRMjlYMEDxPVADFtl
         XtyFrfgpipwMHSO/dng7nzMFkTD9mLDybX/bIfMxJMin3HUMf5bqbEyBzOMbcmz/4l0H
         2HkvGTMXw9uVvHrquTTFxgyaRAQ/4vUnZGvAQtdwTih8jvNPeIp1BWUUdspWjbdGsnBL
         R2cYQJeu0wy0rNbd3Cr6cFm/0w/0kooHtacsCRZz1SJ0SHUcXPiQksP5HGtQsyLdteJG
         qvAg7Gfb/6+Ywo3uaezWq7uaMRxFCuRaeEqEtvP40oPl0XWbeLWy9lSOd8wR3QQsQsNp
         I6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+oInBhIZV9nWNWPJmO5ivshz2z/OsQMUnwoFUIGakQ=;
        b=JJcHM8kuZ11DN4uxDEhko+bgqtt8YZHVQlVT/dxVwv16VXontsO31JLXxAbg4ge3GC
         ofbARu8Aib8DnpSOkWD5axHbP932vPr0/js2JiH+8j0SHp2Rr+LuUkdZZEVjll3+qzIY
         7xsM9ZmeSQFWV8BzEjiLW55v0f52a8uTKQidLdiRYIdN1X6Av2/gsjQgcd23cGxp8FOT
         3OKK+xx6lBUgQ8e8xRQEuN6rJLQ1kNnSyncVnBoKod2l8EaJrdSWm51Ui1mOI2MHsSlz
         667a9dnGlpRu4JRIIuVpohZeawm4LeyWh6YLXV0O2mjVylydTTqiiwDBGE3Dp4wGx09Q
         JzNQ==
X-Gm-Message-State: ANoB5pmrks5uuADoG00ieGg/uMt7wBqV1ot2vJci9k1GLVSBHiFI9I+f
        +v4KJWaN8uDSoIuw9WpLLyuGFotYmi4Y/53jrkUPmR4=
X-Google-Smtp-Source: AA0mqf41yIWZUYNFGoPiam+tMY5iPbXbfUFGW7NAUeABX4xVYLvwU0McE2A4ZLUnqINMM1l97VfjO0QMUqzsOAF4/wY=
X-Received: by 2002:a2e:a804:0:b0:277:81ff:c2c7 with SMTP id
 l4-20020a2ea804000000b0027781ffc2c7mr4328769ljq.23.1668957837495; Sun, 20 Nov
 2022 07:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20221120034014.7390-1-kernelfans@gmail.com> <20221120152040.7460-1-kernelfans@gmail.com>
In-Reply-To: <20221120152040.7460-1-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sun, 20 Nov 2022 23:23:46 +0800
Message-ID: <CAFgQCTtPgke6PnG1H4wTXiqh3=73cnVoXxmxbuW72BM5VxdevQ@mail.gmail.com>
Subject: Re: [PATCH] srcu: Eliminate the case that snp_seq bigger than snap in srcu_funnel_gp_start()
To:     rcu@vger.kernel.org
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sorry for the fragment, but I am just aware of this and think it is
better to fold into the same series.

Thanks,

    Pingfan

On Sun, Nov 20, 2022 at 11:20 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Since the srcu read lock is still held during srcu_funnel_gp_start(),
> the seq snap should be the largest number for the slot
> srcu_have_cbs[idx].
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  include/linux/rcupdate.h |  1 +
>  kernel/rcu/srcutree.c    | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 08605ce7379d..a09007236660 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -32,6 +32,7 @@
>  #include <linux/context_tracking_irq.h>
>
>  #define ULONG_CMP_GE(a, b)     (ULONG_MAX / 2 >= (a) - (b))
> +#define ULONG_CMP_GT(a, b)     (ULONG_MAX / 2 > (a) - (b))
>  #define ULONG_CMP_LT(a, b)     (ULONG_MAX / 2 < (a) - (b))
>  #define ulong2long(a)          (*(long *)(&(a)))
>  #define USHORT_CMP_GE(a, b)    (USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c54d6c04751f..057752db1125 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -900,14 +900,14 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>                 for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
>                         spin_lock_irqsave_rcu_node(snp, flags);
>                         snp_seq = snp->srcu_have_cbs[idx];
> -                       if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> +                       /* s should be the biggest in the current slot. Hence only LE is
> +                        * valid
> +                        */
> +                       BUG_ON(ULONG_CMP_GT(snp_seq, s));
> +                       if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
>                                 if (snp == snp_leaf && snp_seq == s)
>                                         snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
>                                 spin_unlock_irqrestore_rcu_node(snp, flags);
> -                               if (snp == snp_leaf && snp_seq != s) {
> -                                       srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> -                                       return;
> -                               }
>                                 if (!do_norm)
>                                         srcu_funnel_exp_start(ssp, snp, s);
>                                 return;
> --
> 2.31.1
>
