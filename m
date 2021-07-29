Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A13C4338F
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 08:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D5660EBB
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 08:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhG2IXj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhG2IXi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Jul 2021 04:23:38 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABEEC061757;
        Thu, 29 Jul 2021 01:23:35 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h18so4952705ilc.5;
        Thu, 29 Jul 2021 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ccd2xbEHhvpSbSnWmxqtE65ekiJ0PdRSIlSwq5h7mTU=;
        b=W3scWnJIDk7gWJdFsSDLxRbbUkLCn9X5yeTbVgE/FSC8KBSyJ/C1LJgN6U02si68vi
         iGxUue6tcb1Jhvj5Fte5J5P+AbR81H2DRSDQcV4d6nn2Op8a+6vPSYvPk13zuUCrJa0F
         Nn53rnfH9plH8RCMiLvh5BrQNkgQqjnceObBKrxAjA8xGwxwp97cyI8K8cbrhKIGxOqJ
         Uz2QTbvDznc2aVVRVkd5ACvyCQtGBEbzdTrDYMrBVeseYIA+h3LlTQki5JNeFM+L06JF
         ZwWkXBQFhBnrcpk4MQvfVr7OsP7bhQvgleVyY1R3fw6CiMPSqar0lWNm0j/yPXF6yeEg
         fyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccd2xbEHhvpSbSnWmxqtE65ekiJ0PdRSIlSwq5h7mTU=;
        b=lSpq+lvBNguhMTKqdESuSGdQQ1peKmGxG6EwStfu7tocV+4Y0redMWROSnLErDxUzK
         HSLuFyL73KveqqhCDPcBhCGp7MmipNBWk7BX02HaC91mrA3adRG1YP1jY/UIH4p+dLt3
         LdM4UlyiuCB/cUqEzGHJtrswx9rbQCtA7xqtc11tIn4XFrP/2YTLw45S6jxj8g2YKR2N
         rWdFJTi0Rr+P60oD5BvKRGvtl3hp0ZJYU66p/IiIzBdb+GduXZfkEktb6ht929RkJzSU
         mDKWe3Z70zg7DI2NRvLZuNOchG6S1xJFEdlLMj+8ixkBIR5OA17aq0tvCMpkXRjJhdKM
         Shrg==
X-Gm-Message-State: AOAM530wOXoQbXLaIkufzIGyLy4pEphvbeMkkQNtjMyfnTVgTvPwI1l/
        MATpoLHxwAf2sb+cVyMOxi0=
X-Google-Smtp-Source: ABdhPJwZx4r28KmHe7qxgmiYOb6hVWI+hvshL0F+J159N0Tz5+2eIjlREChP0HVJgHejggKbkElC2g==
X-Received: by 2002:a92:db4c:: with SMTP id w12mr3027206ilq.306.1627547014700;
        Thu, 29 Jul 2021 01:23:34 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v16sm1474949ilh.70.2021.07.29.01.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:23:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 15DD927C0054;
        Thu, 29 Jul 2021 04:23:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 29 Jul 2021 04:23:33 -0400
X-ME-Sender: <xms:g2UCYaOMHtPBFzbNuTXv7qfmFECTDcT1KItt2E3MpSV-AhnZ0Ezb3Q>
    <xme:g2UCYY9vlp6RE6ET7HHHgwp-UtqvNsN4NX12FqAD74f_D1qZO2KluMFgFxe97NMq9
    Qbe_8-lvSYajJ7x4g>
X-ME-Received: <xmr:g2UCYRRSfH-gZJt6v8ALoYQ37W0kvIF0CWkAFliB3ZzWWIuqkehUKTfphf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheduucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedvgeejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeej
    keehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnh
    grmhgv
X-ME-Proxy: <xmx:g2UCYatWAEH5ZYYFwv0RsQIeeP5B4ki8peLKXTWdUzC5vT4LxgsD4Q>
    <xmx:g2UCYSdN6mY9RTcXfPb9VK4QWKnbQXWHZlXUHMdXU-fDoS1dgJdhog>
    <xmx:g2UCYe1_7sWuuaXDXjqrk0kD51NA169RA4TZeSZ-I6PvxYcQdBDSUg>
    <xmx:hWUCYVspfXrByHZ6tGaja9PAa5ZVbvDXz9UxbZLurdO9HkSTvOAqASpZjbs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jul 2021 04:23:30 -0400 (EDT)
Date:   Thu, 29 Jul 2021 16:23:08 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH rcu 10/18] srcutiny: Mark read-side data races
Message-ID: <YQJlbEgaAGJvx3iN@boqun-archlinux>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-10-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721202127.2129660-10-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 21, 2021 at 01:21:18PM -0700, Paul E. McKenney wrote:
> This commit marks some interrupt-induced read-side data races in
> __srcu_read_lock(), __srcu_read_unlock(), and srcu_torture_stats_print().
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/srcutiny.h | 8 ++++----
>  kernel/rcu/srcutiny.c    | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index 0e0cf4d6a72a0..6cfaa0a9a9b96 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -61,7 +61,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
>  	int idx;
>  
>  	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
> -	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> +	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
>  	return idx;
>  }
>  
> @@ -81,11 +81,11 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
>  {
>  	int idx;
>  
> -	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
> +	idx = ((data_race(READ_ONCE(ssp->srcu_idx)) + 1) & 0x2) >> 1;

This looks very weird, any explanation why we want to put data_race() on
a READ_ONCE()?

Regards,
Boqun

>  	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd)\n",
>  		 tt, tf, idx,
> -		 READ_ONCE(ssp->srcu_lock_nesting[!idx]),
> -		 READ_ONCE(ssp->srcu_lock_nesting[idx]));
> +		 data_race(READ_ONCE(ssp->srcu_lock_nesting[!idx])),
> +		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])));
>  }
>  
>  #endif
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 26344dc6483b0..a0ba2ed49bc61 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -96,7 +96,7 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
>   */
>  void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
>  {
> -	int newval = ssp->srcu_lock_nesting[idx] - 1;
> +	int newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
>  
>  	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
>  	if (!newval && READ_ONCE(ssp->srcu_gp_waiting))
> -- 
> 2.31.1.189.g2e36527f23
> 
