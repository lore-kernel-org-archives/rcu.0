Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAECC4332F
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 02:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiKQCeT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 21:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiKQCeS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 21:34:18 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20E12A8F
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 18:34:16 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l8so885340ljh.13
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 18:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dII0QeignRL4u4sLkO4R1zMJ93UrKg3JRgBrGTMrAYo=;
        b=mYd2Rfi10wdDrtBrGhNb/5QeFskflJfXBY645vUrCAwCYte8shjMSxqdPZPeoQ1tKZ
         aKa6GSYsg6UiyHDJrlQt40WDqGl+zfoXJMkCHHRvfDgzYQTkgTrmeap+O5EXpgbqJ9x4
         eWCHINqta0365CLFezr6SjtXs1icGhPU5Lo9Q/P4FFjPBToe66/KPicyVuMSPgphUmpm
         VG3pdkkZRjJISCRnVbhfh+Tnb6Bc6cdhrzsKo80z294XyqrbMw36CgNG+0uvMLJ08g3m
         j+FmUvmMItyad6a4pLqQoe8jxurVOgTcgFE+XR/Sb8Jn7OGAY6ZuLuJi7LciGZxkxN0X
         6Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dII0QeignRL4u4sLkO4R1zMJ93UrKg3JRgBrGTMrAYo=;
        b=XYDclTcpmYdAuIxpImPGbBW5kvhdg9xC38l1GmmNuxr1jXTrAuU4/5PSdc+x/hUAhH
         8QQeVsvVU94pP0sjhdraFpeyooFCptqKpv5Vy5ywXNV2yR/xo/aW9+pT2pAlsvD6KiVf
         zs7D0jVGjxpKKixV4BQNXW6VZHqdQYR5VVMk7p0V1EdtuYO1wABP3H6MgLdrWhH3yV5u
         +4P9YYYANDVaLWqGrEfnL1+gTXQx0WTVCtkdJ7URhoXmqdrXTDfPNP0gNwSEmpEejT0K
         LK5d9IsajxKx2Eu+9rnGv3OuK4siP6yVcY0QE7wd3DvPscOAAAroqunfD8Efv+CQhYIK
         NLAA==
X-Gm-Message-State: ANoB5pmJpQ0yeFiauLl95ULqAuZPeR0nlt76/GzfRyy7tyl8R9Jfk8e3
        E1ym59w/gd/+gu00g6bUVbfbFNvr2AVcUhEQlFmMSWE=
X-Google-Smtp-Source: AA0mqf7JwTVZU+AkVfdkDYmeYvvAEjRdj2Ih26DMqMQ/Tp+EBZjmuWcx4EX4JxO/ZW6SFuNC0Uev+NQs1B7I+vvdiRE=
X-Received: by 2002:a2e:a80a:0:b0:277:2600:9cc0 with SMTP id
 l10-20020a2ea80a000000b0027726009cc0mr310977ljq.437.1668652454947; Wed, 16
 Nov 2022 18:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20221116015244.10539-1-kernelfans@gmail.com> <20221116015244.10539-2-kernelfans@gmail.com>
 <20221116133437.GA816333@lothringen> <20221116172643.GA1432130@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221116172643.GA1432130@paulmck-ThinkPad-P17-Gen-1>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 17 Nov 2022 10:34:03 +0800
Message-ID: <CAFgQCTvybjfgpZCDQkSDOojNP5HVmfRJGEnGf1NwxphUL5igcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] srcu: Fix the comparision in srcu_invl_snp_seq()
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 17, 2022 at 1:26 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Nov 16, 2022 at 02:34:37PM +0100, Frederic Weisbecker wrote:
> > On Wed, Nov 16, 2022 at 09:52:44AM +0800, Pingfan Liu wrote:
> > > A seq contains two fields: counter and state.
> > >
> > > SRCU_SNP_INIT_SEQ is used as invalid initial value for srcu_node GP
> > > sequence numbers. Hence srcu_invl_snp_seq() should compare both fields
> > > of a seq.
> > >
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > To: rcu@vger.kernel.org
> > > ---
> > >  kernel/rcu/srcutree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 1c304fec89c0..725c82bb0a6a 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -154,7 +154,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
> > >   */
> > >  static inline bool srcu_invl_snp_seq(unsigned long s)
> > >  {
> > > -   return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
> > > +   return s == SRCU_SNP_INIT_SEQ;
> >
> > Doesn't hurt and makes it less confusing as it doesn't suggest anymore
> > there _might_ be a gp number behind.
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Good catch, thank you both!
>
> My first reaction was that this patch was wrong, so I recorded the
> results of my investigation in the commit log.  Please check below in
> case I messed something up.
>

It looks more clear now. Thanks for improving the log.

Thanks,

    Pingfan


>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 08d9c4f609afaf5c3032320d50f2bae4acdca314
> Author: Pingfan Liu <kernelfans@gmail.com>
> Date:   Wed Nov 16 09:52:44 2022 +0800
>
>     srcu: Fix the comparision in srcu_invl_snp_seq()
>
>     A grace-period sequence number contains two fields: counter and
>     state.  SRCU_SNP_INIT_SEQ provides a guaranteed invalid value for
>     grace-period sequence numbers in newly allocated srcu_node structures'
>     ->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp fields.  The point of the
>     comparison in srcu_invl_snp_seq() is not to detect invalid grace-period
>     sequence numbers in general, but rather to detect a newly allocated
>     srcu_node structure whose ->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp
>     fields need to be brought into line with the srcu_struct structure's
>     ->srcu_gp_seq field.
>
>     This commit therefore causes srcu_invl_snp_seq() to compare both fields
>     of the specified grace-period sequence number.
>
>     Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>     Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>     Cc: "Paul E. McKenney" <paulmck@kernel.org>
>     Cc: Josh Triplett <josh@joshtriplett.org>
>     Cc: Steven Rostedt <rostedt@goodmis.org>
>     Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>     Cc: <rcu@vger.kernel.org>
>     Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 16953784a0bdf..6af0312005801 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -154,7 +154,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
>   */
>  static inline bool srcu_invl_snp_seq(unsigned long s)
>  {
> -       return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
> +       return s == SRCU_SNP_INIT_SEQ;
>  }
>
>  /*
