Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C4BC433FE
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiK3Qy7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiK3Qyv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 11:54:51 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577148BD34
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 08:54:50 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id cg5so11524735qtb.12
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtBrYMbvceI7rXs2D7ejVX0RaLQp43U5is6DDosCn9k=;
        b=D15YtL1o47gCo+DwVPghHmvrPoLNq0nQtoExuDyHKS6iFUVnFHB1VPLJCLGCFyLvTA
         RJE0PDCyY9D35ut6cTsJxfspTwq9rCTC+N/zYtfk+SokT77ORoyAjFFNfP+otkWuo+DI
         RiPlqu0KIwa64jRVjEa/R/vRIzN5COwdIprkFR97x3RgM03ZcctNEzA+eZK9q1+ukgrw
         vfIsnimInsIKcs7+Ou7/W4IfjG3Q0rJnq6uyBbLvBMEWZDnpDjY2o+Wl3WVFW4xI1431
         etJNTIrNbSgj+3xJLag/4UsgGh0cQcVjzHq5+FNCUVcrrbU93o2pf+hQT+vkn9Ig/jZw
         Jzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtBrYMbvceI7rXs2D7ejVX0RaLQp43U5is6DDosCn9k=;
        b=qY701/w06x4Ulpw1lyU2KCNV5qhfzbGKn0SHXjBQhatIq9/dZu3AuCLJSs6DPBzobo
         RsM42uY+ocNg6JitqrfEJGVarD0MI/63fNMhDujoeypolRr/EJlXQ/kiYTyJjSd4lWPr
         d8eQhqaJP6jBRXSE/wx8ikxUfuxFE4lwqxrt3uA8SybMhRHwRM7SzSQy1egkcYNOgwSQ
         sSuPMQrDmh8aSiRmmk3YbmDfd+SDtOsjQrFp/D8v/Y+8lDCmkYofNCcgfAGckQjmchX8
         117Ov5qeeVG3vXlPGWxVGXu9TqNVQkx/2HFfqs/CdkZV/W2RZ6OFopNvCURwX0iequvN
         +kpw==
X-Gm-Message-State: ANoB5pkmrwDLr38pOxHAFLHI2TGx8YsogE7p/di/W5HUkcH1qZu1GRKx
        uOt8tI74igADOdsg+kPepSI=
X-Google-Smtp-Source: AA0mqf4JYerScz0N8Gg8mbTpWYk8vGR623ZV13uYMPFMyb+M1dV5gjpHLKT46x9wVIiHbiwp+k+F8w==
X-Received: by 2002:ac8:71c7:0:b0:3a6:7f4e:764c with SMTP id i7-20020ac871c7000000b003a67f4e764cmr9273551qtp.114.1669827289419;
        Wed, 30 Nov 2022 08:54:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dt43-20020a05620a47ab00b006fbf88667bcsm1473343qkb.77.2022.11.30.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:54:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 42DAB27C0054;
        Wed, 30 Nov 2022 11:54:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 30 Nov 2022 11:54:48 -0500
X-ME-Sender: <xms:14qHY_IFhi3rmcYhhBwvJN8PLMNyX4A5cuZ_zm4L8lpMEBlW7C5iuA>
    <xme:14qHYzIQdmrGaV48onf8ie56v4hRXUkQNuP0pUeNK9xRvAeE5JMjJRhmJfkL4ykfI
    KoL1PD6FO0VTZ-UNw>
X-ME-Received: <xmr:14qHY3spSqgQstvMeDuTU3-ndAPolZZR8LmEXY8RySERgumGRmUoOKfeDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:14qHY4aXH3UsAOkJMiDp2bctvvsaU7nKtyuw9Gy9v-E5N4Fo1PxLHg>
    <xmx:14qHY2asYWDd2MuENg1QpHtZqLwllOuLkv6e4JQAcnjMhY61vXFsdg>
    <xmx:14qHY8CnaK1Jh4baJ4Ce1bW0yLPncX8nFKFun-KcZAiFbvc4A7QQDA>
    <xmx:2IqHY8NmknLLmTmVNCXjye1IQGnBcxyuYx9sB2lB9OTDhTjl7rtW-0Wzqq0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 11:54:47 -0500 (EST)
Date:   Wed, 30 Nov 2022 08:53:43 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCH] srcu: switch work func to allow concurrent gp
Message-ID: <Y4eKl2fCNDX2ka1g@boqun-archlinux>
References: <20221130083902.31577-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130083902.31577-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 30, 2022 at 04:39:02PM +0800, Pingfan Liu wrote:
> ssp->srcu_cb_mutex is introduced to allow the other srcu state machine
> to advance as soon as possible. But according to the implement of
> workqueue, the same work_struct is serialized and can not run
> concurrently in fact.
> 
> Quoting from Documentation/core-api/workqueue.rst
> "
> Non-reentrance Conditions
> =========================
> 
> Workqueue guarantees that a work item cannot be re-entrant if the following
> conditions hold after a work item gets queued:
> 
>         1. The work function hasn't been changed.
>         2. No one queues the work item to another workqueue.
>         3. The work item hasn't been reinitiated.
> "
> 
> To allow the concurrence to some extent, it can be achieved by changing
> the work function to break the conditions. As a result, when
> srcu_gp_end() releases srcu_gp_mutex, a new state machine can begin.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/srcutree.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..56dd9bb2c8b8 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -75,6 +75,7 @@ static bool __read_mostly srcu_init_done;
>  static void srcu_invoke_callbacks(struct work_struct *work);
>  static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay);
>  static void process_srcu(struct work_struct *work);
> +static void process_srcu_wrap(struct work_struct *work);
>  static void srcu_delay_timer(struct timer_list *t);
>  
>  /* Wrappers for lock acquisition and release, see raw_spin_lock_rcu_node(). */
> @@ -763,6 +764,11 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>  		cbdelay = 0;
>  
>  	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> +	/* Change work func so work can be concurrent */
> +	if (ssp->work.work.func == process_srcu_wrap)
> +		ssp->work.work.func = process_srcu;
> +	else
> +		ssp->work.work.func = process_srcu_wrap;

This looks really hacky ;-) It would be good that workqueue has an API
to allow "resetting" a work.

Do you have any number of the potential performance improvement?

Regards,
Boqun

>  	rcu_seq_end(&ssp->srcu_gp_seq);
>  	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
>  	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
> @@ -1637,6 +1643,19 @@ static void process_srcu(struct work_struct *work)
>  	srcu_reschedule(ssp, curdelay);
>  }
>  
> +/*
> + * The ssp->work is expected to be concurrent to some extent, but the current
> + * workqueue does not support the concurrence on the same work. (Refer to the
> + * section "Non-reentrance Conditions" in the file workqueue.rst)
> + * Resolving it by changing the work func.
> + *
> + * Prevent compilering from optimizing out it.
> + */
> +static __used void process_srcu_wrap(struct work_struct *work)
> +{
> +	process_srcu(work);
> +}
> +
>  void srcutorture_get_gp_data(enum rcutorture_type test_type,
>  			     struct srcu_struct *ssp, int *flags,
>  			     unsigned long *gp_seq)
> -- 
> 2.31.1
> 
