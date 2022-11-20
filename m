Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1CBC4332F
	for <rcu@archiver.kernel.org>; Sun, 20 Nov 2022 15:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKTP0w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Nov 2022 10:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKTP0v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Nov 2022 10:26:51 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3161F9E6
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 07:26:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id b62so9122210pgc.0
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gg0Qe02iQR+MsJxXflZh2Q2N14Gv5ajW92sE9c9YFIo=;
        b=lG5cgC+b4QQlzjyVJwxeSlVvJFh4xaCuYnYLiOoqg6QnlubD5tro36JNdNSc4jocoA
         O4FJLUo0Cb13XeM75mYgEcNir9zeiu1TwRInYvxSiEm+Ln66GbVP++e5R+RBVeh3UBiB
         lOn/0FsdVEVhi6R1Qw8r4wZvnB9VHf2J9LkIahaupvJ4zsMOH3aqw7z9Gx5HyXtiLP7d
         gYNGiviWe+OT2ga1ZkVEKkzhVCLeF5J85c/9i1TFzzjFcjhg4gdKDgUZZssA023UHzJy
         T/cNUgCKschu5ex0ooSDFleMPsmURqATuYcxyka3Ll5Kp58wJKkYbvGpiB5ChjG4YxWo
         foNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg0Qe02iQR+MsJxXflZh2Q2N14Gv5ajW92sE9c9YFIo=;
        b=Wa8P+FT/Ked0+INI3XOTEL01/jlIJ6kipVHMByiZYKp58NuVA3Y0Geh80A7JLjhMO9
         6ofbs2l00MV8B/EWAzuJXBpj0nU2vV+8WzvxkXs35qsV0+xA1ycPtHOA/L2AM1SqYE8x
         Pf6wNi8LlePBpgA6yNzjRaXJh0I+Z6Ing8uMEo4J1NLblZmg3t2+mEbKAQTv4r6aGGUX
         BNWeMPQM59K0ySsffBVvhv4u/PBVtq4rq0UjtiyXmUWPNxZovLBmaL8cyGUX8hL5xkE2
         5Z2HLgNOy6TOIZz62vK8YGbbZbpmTz8KpvH1fvi9mh+7Fk0kXuyNX75oi23rQjg0R54i
         TN0w==
X-Gm-Message-State: ANoB5plLj10AyUtY7xpf3ohSjymkD8XfdsY7f0szJ1gr6doXv0n51FuV
        Jh+PPcKwssjbXrjKAD0H8w==
X-Google-Smtp-Source: AA0mqf71+WVfSrt8CeAVdJ+B4OazO1/+fxgW0wRzPSWe7eT5eQGkGEAZJm2CX/yE/IM+lGp2fgyXtg==
X-Received: by 2002:a63:5359:0:b0:46f:7e1c:e6e6 with SMTP id t25-20020a635359000000b0046f7e1ce6e6mr14516000pgl.138.1668958009954;
        Sun, 20 Nov 2022 07:26:49 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c4-20020a17090a558400b00210c84b8ae5sm5954883pji.35.2022.11.20.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:26:49 -0800 (PST)
Date:   Sun, 20 Nov 2022 23:26:44 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] srcu: Remove needless rcu_seq_done() check while
 holding read lock
Message-ID: <Y3pHNIXe/hOBIosB@piliu.users.ipa.redhat.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-2-kernelfans@gmail.com>
 <PH0PR11MB58801BEEBD2DED79AB1ADBDBDA0B9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58801BEEBD2DED79AB1ADBDBDA0B9@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 20, 2022 at 05:00:43AM +0000, Zhang, Qiang1 wrote:
> >
> >As the code changes, now, srcu_gp_start_if_needed() holds the srcu read
> >lock, gets the gp_seq snap and call srcu_funnel_gp_start() passing that
> >snap value.
> >
> >As the rcu_seq_snap() promises "a full grace period has elapsed since
> >the current time".  In srcu_funnel_gp_start(), the statement
> >  rcu_seq_done(&ssp->srcu_gp_seq, s)
> >always return false.
> 
> Hi Pingfan
> 
> Please correct me if I understand your commit message incorrectly. because the srcu_gp_start_if_needed() is
> protected  by srcu read lock,  and the  rcu_seq_snap()  seq is a  at the end of the current or next srcu grace period, 
> so as long as we are still in the srcu_gp_start_if_needed(), it also means that we are in SRCU critical section.
> the current or next srcu grace period will not end, it also means that we can not invoke rcu_seq_end() to update 
> 'ssp->secu_gp_seq' , so the rcu_seq_done(&ssp->srcu_gp_seq, s) is always return false.
> 

Yes, you totally got it.

Thanks

	Pingfan

> Thanks
> Zqiang
> 
> >
> >The same condition stands for srcu_funnel_exp_start(). Hence removing
> >all the checks of rcu_seq_done().
> >
> >Test info:
> >  Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
> >without any failure.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/srcutree.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..7df59fc8073e 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -851,8 +851,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
>  	if (snp)
>  		for (; snp != NULL; snp = snp->srcu_parent) {
>  			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
> -			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
> -			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
> +			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s))
>  				return;
>  			spin_lock_irqsave_rcu_node(snp, flags);
>  			sgsne = snp->srcu_gp_seq_needed_exp;
> @@ -878,6 +877,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
>   *
>   * Note that this function also does the work of srcu_funnel_exp_start(),
>   * in some cases by directly invoking it.
> + *
> + * The srcu read lock should be hold around this function. And s is a seq snap
> + * after holding that lock.
>   */
>  static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  				 unsigned long s, bool do_norm)
> @@ -898,8 +900,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  	if (snp_leaf)
>  		/* Each pass through the loop does one level of the srcu_node tree. */
>  		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> -			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
> -				return; /* GP already done and CBs recorded. */
>  			spin_lock_irqsave_rcu_node(snp, flags);
>  			snp_seq = snp->srcu_have_cbs[idx];
>  			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> @@ -935,9 +935,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
>  		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
>  
> -	/* If grace period not already done and none in progress, start it. */
> -	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
> -	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
> +	/* If grace period not already in progress, start it. */
> +	if (rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
>  		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
>  		srcu_gp_start(ssp);
>  
> -- 
> 2.31.1
> 
