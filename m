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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40862C4320A
	for <rcu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E0360EE7
	for <rcu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhHKCo6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 22:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhHKCo5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Aug 2021 22:44:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B6C061765;
        Tue, 10 Aug 2021 19:44:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id i7so1786008iow.1;
        Tue, 10 Aug 2021 19:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=npppBCw238Jykoq8sCHWu265O+L6snfn7q8D3/DyYoY=;
        b=U5BPniX8y7jkAJIqA7DsVIYV9NAFKMMBLgv127sLSTtN+6JesoNt1ehtzk3QMPzTG5
         65goYuJRWlO6+F8SCRLbl9lZE7uskUNdR5zc2XJC1oQu4fLxVI9b+EYIL4X6ivydu5zd
         S1OG3aGgqhsVwkWeAcZS20oGiEPGhpyxpb9yrHaPXbrEsw8TRnSuMF90uy4kVKcQ7mef
         PiGdSQWhBoG7jT4l1J7kcP545wZpV4URAazd+tfTcPzZ+c9xI4xgsjebzdjnV4LTnfnD
         UAflIizbpDnM2w7sxmiux/f3SnZfgTlTvSBd9WglVdwTch2BdL5u8VI4v8Czkgg/9D9L
         ZIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=npppBCw238Jykoq8sCHWu265O+L6snfn7q8D3/DyYoY=;
        b=mzRcQOvAlGr/wD075Qe0BER0RXswg1lqwxR6JCxcyeRmGnNpFZ5hAZB3h+qukOSX23
         J0Cno1HdOk4c+hTNW8QLq5HfWlaoDWNxR9SDuFGbh558oqYzqWKKJtdMcOTfO3IfbfjR
         Qqbv48RifVTU3GIUyaAnQpG0d+gLaa225gnXBavFor+KE3C+GVmtsDVV5N5vxJqaHW3p
         zA4QcMm/MAXY+NBb6qYgG9JDDJqhOTAAcLsPJH8ayNnKp/1V0R9tdPa6fxtTDJmYMA3l
         iD02MlYVJv6lNZvC29WjGJLz4L5tkm5yWTCcbA3FPkeNqjYRUsL4AApNHI3pc65njqIe
         Qr9w==
X-Gm-Message-State: AOAM530p50v2mi35Ih4VPnATyFtlSzN5e/Vx3Wgui7lAD56VplKVGwYk
        zOpwjauy7yNOkYYhJ4bRJp2g8vkoGME=
X-Google-Smtp-Source: ABdhPJzJuArtMBw/i4a1Rw0YQI/gRZpijEJKiaCs9VlKNBLTG5eRemBbs5KSo3MqWf2tvAzRHjmdFQ==
X-Received: by 2002:a5d:914b:: with SMTP id y11mr121433ioq.6.1628649874359;
        Tue, 10 Aug 2021 19:44:34 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h13sm11340232ila.44.2021.08.10.19.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 19:44:33 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id BDDD227C0054;
        Tue, 10 Aug 2021 22:44:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 10 Aug 2021 22:44:32 -0400
X-ME-Sender: <xms:jjkTYYqIEA0n8Zr-XLCNHgTkfOOphyEJQvwXmGulWAX02mefUCIFPA>
    <xme:jjkTYeo65D30ClO0uMp_Dim_mPCetmt8qLmzTJb4oPqNENNN8yibL02pHxTDAJCQe
    ERDSX_o57Qe7JdxUQ>
X-ME-Received: <xmr:jjkTYdOpM5rdM9W9y0JZ8FO7iew9AZ_ZM0yv5bzB1-PZroxBEXrlQKkKpOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedtgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:jjkTYf5M-t93x8rU3v3poMut_bAzgC9LiXPLyZmYCxdTc3U01NrOoQ>
    <xmx:jjkTYX7AKrkGy4880AfiMBOGTTr-BU_ChGRHiKk09uxynRLd8dIs6w>
    <xmx:jjkTYfjFM3nLos2I60sn-MhJyaAIuWuIZPukN3EsUtZvimCMymEW4w>
    <xmx:kDkTYfzvLNu2NuaDNEdQ3HI2hZysCYhivT8xZpYpKWzG-bU4fub9NuAs_D8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Aug 2021 22:44:30 -0400 (EDT)
Date:   Wed, 11 Aug 2021 10:44:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH][RFC] lockdep: improve comments in wait-type checks
Message-ID: <YRM5heBfgNtEGvoC@boqun-archlinux>
References: <20210810210319.6564-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810210319.6564-1-zhouzhouyi@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On Wed, Aug 11, 2021 at 05:03:19AM +0800, Zhouyi Zhou wrote:
> Hi Peter,
>   I think comments in wait-type checks may benifit from some comments
> improvement.

Thanks for looking into this!

Even for an RFC patch, it's better that you write a proper commit log,
and note that you can put all this background information right after
the "---" line, if you think that will help people review it.

>   I recklessly add Paul to signed-off-by, because I asked his opinion
> about comment in rcu_read_lock_bh part.
> 

Probably a Suggested-by will suffice, but I leave that to Paul ;-)

> Thanks a lot
> Zhouyi
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Please make you the last one in the "Signed-off-by" list, see
Documentation/process/submitting-patches.rst:

"Notably, the last Signed-off-by: must always be that of the developer
submitting the patch."

Regards,
Boqun

> ---
>  include/linux/lockdep_types.h | 2 +-
>  kernel/locking/lockdep.c      | 2 +-
>  kernel/rcu/update.c           | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index 3e726ace5c62..d22430840b53 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -21,7 +21,7 @@ enum lockdep_wait_type {
>  	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
>  
>  #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
> -	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
> +	LD_WAIT_CONFIG,		/* preemptible in PREEMPT_RT, spinlock_t etc.. */
>  #else
>  	LD_WAIT_CONFIG = LD_WAIT_SPIN,
>  #endif
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index bf1c00c881e4..952d0ccf8776 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -4671,7 +4671,7 @@ print_lock_invalid_wait_context(struct task_struct *curr,
>  /*
>   * Verify the wait_type context.
>   *
> - * This check validates we takes locks in the right wait-type order; that is it
> + * This check validates we take locks in the right wait-type order; that is it
>   * ensures that we do not take mutexes inside spinlocks and do not attempt to
>   * acquire spinlocks inside raw_spinlocks and the sort.
>   *
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index c21b38cc25e9..690b0cec7459 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -247,7 +247,7 @@ struct lockdep_map rcu_lock_map = {
>  	.name = "rcu_read_lock",
>  	.key = &rcu_lock_key,
>  	.wait_type_outer = LD_WAIT_FREE,
> -	.wait_type_inner = LD_WAIT_CONFIG, /* XXX PREEMPT_RCU ? */
> +	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT implies PREEMPT_RCU */
>  };
>  EXPORT_SYMBOL_GPL(rcu_lock_map);
>  
> @@ -256,7 +256,7 @@ struct lockdep_map rcu_bh_lock_map = {
>  	.name = "rcu_read_lock_bh",
>  	.key = &rcu_bh_lock_key,
>  	.wait_type_outer = LD_WAIT_FREE,
> -	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_LOCK also makes BH preemptible */
> +	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>  };
>  EXPORT_SYMBOL_GPL(rcu_bh_lock_map);
>  
> -- 
> 2.25.1
> 
