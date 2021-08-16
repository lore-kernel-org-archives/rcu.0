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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326BBC4338F
	for <rcu@archiver.kernel.org>; Mon, 16 Aug 2021 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DB460F4B
	for <rcu@archiver.kernel.org>; Mon, 16 Aug 2021 16:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhHPQES (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhHPQES (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Aug 2021 12:04:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909B8C061764;
        Mon, 16 Aug 2021 09:03:46 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v16so8307729ilo.10;
        Mon, 16 Aug 2021 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MtbxSjBnllc9I3A9efdStus8BBZ5PoMeQpu9vIkyVbg=;
        b=ADq8oZfQWD5SUhNAPAR3uwOfgTWKdTC94L0rkGT3J8z7WzNaNvmgvUWwJITfb3Abap
         kEZs0aDYOMslbhN89bEPnhxZuG0mkNZ69AWes9hXuGXEj4xO1o7ANq40MH3zh3CGadLj
         qOOLDi8+344B50Wll2xYvoqVYCEuOACI/FB0Kl1zPldkY8AHmNbwO7WXj8rpgEQNNacJ
         /TG5CGJRFnfrODArluzT7g2lDqrOVaQHsp3tvzJFibC8au1jGaHl/EP+2QR/kUO3167Y
         taZdeHk1JFcFRldZ0WsKZwTRn0Gpw2XBfVJohFtOYgpaAaFNk7xkwoEPDJM+wtrsYij0
         Ha5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MtbxSjBnllc9I3A9efdStus8BBZ5PoMeQpu9vIkyVbg=;
        b=g1z/iGitW6a7915jPQ6RZg0yq/yiykHSJK4TWZVW+zoalPdIiD4eFDHLE0O1fiJ/oL
         8e/OZiul2bpOgmcnmP372GHXRoMFJzZiltJsBWC+FR6Fm/Vbla3Wfdc8iG3vvL5lW+3p
         uKfw9RJ+NP1YEgzxJYGZ2Pf/plAY2/Wo/a7YhUskx2tXqrWg7muv/Ro6BvQ5+33CiMVK
         LoaODJ4DoA9k6y6KgPyGpQhWyEhMQzPGluq3iYdd8Za71U8+A+AhCdfwFawglJvfsTCC
         TXOqr3djP05qAJO07bQMYftd8xNaG331zpjdZ6f3AH31q4GVhCiXW+5SFaeogJamA/Bu
         6bBg==
X-Gm-Message-State: AOAM5312s+douriMQ3n+xTQBJ5+xlzHFeAU5vFX+nkguRLvZbotMEo89
        Cjnl7VZD0N594U0UICJbmgk=
X-Google-Smtp-Source: ABdhPJzAfg+WhEqzXoJZpOKN6ThzoyqVQ/7/qiZXfyLYbJ0149wDFU4I2nPZKU1eQvQDVcYSOEpe1w==
X-Received: by 2002:a92:c702:: with SMTP id a2mr10891642ilp.210.1629129826058;
        Mon, 16 Aug 2021 09:03:46 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j6sm5879002iom.5.2021.08.16.09.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:03:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id B266E27C0054;
        Mon, 16 Aug 2021 12:03:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 16 Aug 2021 12:03:44 -0400
X-ME-Sender: <xms:XowaYaV3KIUALJEvq-yzySMq0x50oGdRkGBCmJEX7Qh9AQyKkek4AQ>
    <xme:XowaYWlLy7dqdpZxOJZiP_63xqvabDG5Z74BQUWog7TkzhMcrMmyY8UcnvjtPoiV_
    BbW8akqE5dsxHKB4Q>
X-ME-Received: <xmr:XowaYebJe3FAVTwB_Mu5CbUwx2JmufhSxKmTuBHSk2_qzgFCuKwJ1oeFvJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:XowaYRUHBWLFVvMu5-hfoKKD8SRb-HTbyhifxZ9--hsEob7FZUmIqg>
    <xmx:XowaYUmmIDrv8KIo0AGZ3Ncsg8HPmqIgxX1cOMM96B28d6PgBazxFQ>
    <xmx:XowaYWf_fi-J46t27UlqMahRAomdsSzIFIKeI1JP3IjJT_eygUWd4A>
    <xmx:YIwaYddcEU1xNgyqChfvueNNkrOUK2vBQaRtmkKsz7b5xLyHtAdmqYximkY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Aug 2021 12:03:41 -0400 (EDT)
Date:   Tue, 17 Aug 2021 00:03:16 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] preempt: add in_serving_irq() and apply to rcutiny and
 vsprintf
Message-ID: <YRqMRFPDL0U9Orec@boqun-archlinux>
References: <20210814014234.51395-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814014234.51395-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 14, 2021 at 09:42:34AM +0800, Changbin Du wrote:
> At some places we need to determine whether we're in nmi, hardirq or
> softirq context. This adds a macro in_serving_irq() as a shortcut for
> that.
> 
> Meanwhile, apply this new macro to existing code in rcutiny and vsprintf.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  include/linux/preempt.h | 4 +++-
>  include/linux/rcutiny.h | 3 +--
>  lib/vsprintf.c          | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 9881eac0698f..9a1c924e2c6c 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -92,12 +92,14 @@
>   * in_nmi()		- We're in NMI context
>   * in_hardirq()		- We're in hard IRQ context
>   * in_serving_softirq()	- We're in softirq context
> + * in_serving_irq()	- We're in nmi, hardirq or softirq context
>   * in_task()		- We're in task context
>   */
>  #define in_nmi()		(nmi_count())
>  #define in_hardirq()		(hardirq_count())
>  #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
> -#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> +#define in_serving_irq()	(in_nmi() | in_hardirq() | in_serving_softirq())
> +#define in_task()		(!in_serving_irq())
>  

So in_serving_irq() is !in_task(), right? If so, why not...

>  /*
>   * The following macros are deprecated and should not be used in new code:
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 7fedbd33d5d2..812d42f22e9c 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -87,8 +87,7 @@ static inline void rcu_irq_exit_irqson(void) { }
>  static inline void rcu_irq_enter_irqson(void) { }
>  static inline void rcu_irq_exit(void) { }
>  static inline void rcu_irq_exit_check_preempt(void) { }
> -#define rcu_is_idle_cpu(cpu) \
> -	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
> +#define rcu_is_idle_cpu(cpu) (is_idle_task(current) && !in_serving_irq())

... use in_task() here, and ...

>  static inline void exit_rcu(void) { }
>  static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 2c5b4351330c..9324439c8543 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -865,7 +865,7 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
>  		 * kptr_restrict==1 cannot be used in IRQ context
>  		 * because its test for CAP_SYSLOG would be meaningless.
>  		 */
> -		if (in_hardirq() || in_serving_softirq() || in_nmi()) {
> +		if (in_serving_irq()) {

... use !in_task() here?

And don't introduce the in_serving_irq() at all.

Regards,
Boqun

>  			if (spec.field_width == -1)
>  				spec.field_width = 2 * sizeof(ptr);
>  			return error_string(buf, end, "pK-error", spec);
> -- 
> 2.30.2
> 
