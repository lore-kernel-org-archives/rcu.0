Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CFC3A5A0
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6ED9206B9
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="h8629JKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgDTPXy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgDTPXy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 11:23:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E960BC061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:23:53 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so8750520qtr.7
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B1Ybdj5S+5bBaVUus93Lcp7neysgzC2VVMkGAaftM1U=;
        b=h8629JKp3SOZDjQ0RV1nxivACrmmV4PGqag0pxZhqUkwMz7e3wgurKDUDtvysMkDIz
         VVAP1I4O4Dq7FIxRnXS+d2Pyy5wk+uc4HvlMIyAG2cOE/dt9e9ywSIdnadF5wrpMeXVB
         7Ye3Ow38ZEGe4qikBMLkiiiRsV67vElh46RP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B1Ybdj5S+5bBaVUus93Lcp7neysgzC2VVMkGAaftM1U=;
        b=VADydMPyvsI3ORxQ+E60tTWq54JEorbTwG9GuvKxjGrZtfVGj2q5oeb6o/sx1Alp3d
         PTpecPDxh3x/6MpHvmrhlpljiCXz0plELnF/nPp8HncKwGTm66qqSDMzchv6dH6CUDRx
         6uLG1tkT6rj7gUzYigv+biKLr7K/sPPZFnjtO5UNOYHzhfzxFyFI+m9mSMU8zCzpk+wE
         /xnTygNlb6ame8jp///cetEldNvs9op6Mt+mk58pb81bVcxCuwyRGUjW1hm7AitDYs4c
         y93rNAImjmtqFw0sF8rDraYfEwSaf8cNKYtNaUnYwtb7vGj5ck4KfKvq5QRmq0NxhJx8
         EXVQ==
X-Gm-Message-State: AGi0PubtTlVdPB3hzNvfDWrQV12HT48Z1Ofjs+Mg5XaSCN/a2PLZykMG
        I4W888pe9/CQqcEbr2Dx3iyYLhjBUEA=
X-Google-Smtp-Source: APiQypI8HUMbGYoDdUFefwBVzxFJ+mh4C/Cq84HoGEFFj6k3/orXXdEK4YFgjERwWY1Osk5sKLWiNg==
X-Received: by 2002:ac8:27a2:: with SMTP id w31mr14036872qtw.318.1587396233034;
        Mon, 20 Apr 2020 08:23:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z90sm691411qtd.75.2020.04.20.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:23:52 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:23:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] rcu: Avoid using xchg() in
 kfree_call_rcu_add_ptr_to_bulk()
Message-ID: <20200420152351.GG176663@google.com>
References: <20200415160034.662274-1-bigeasy@linutronix.de>
 <20200415160034.662274-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415160034.662274-4-bigeasy@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 15, 2020 at 06:00:34PM +0200, Sebastian Andrzej Siewior wrote:
> There is no need to use xchg(), the access is serialized by krcp->lock.
> The xchg() function adds some atomic barriers which remain hidden in
> x86's disassembly but are visible on ARM for instance.
> 
> Replace xchg() with a load + store.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/rcu/tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b31b61721a9ff..04d11c49ff3b9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3079,7 +3079,8 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>  	/* Check if a new block is required. */
>  	if (!krcp->bhead ||
>  			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
> -		bnode = xchg(&krcp->bcached, NULL);
> +		bnode = krcp->bcached;

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I'll resend this with a rewrite of your 1/3 based on the lates tdiscussions.

For your 2/3, let us hold off on that for now as my rewrite of 1/3 will
require rewriting your 2/3.

thanks,

 - Joel


> +		krcp->bcached = NULL;
>  		if (!bnode) {
>  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
>  
> -- 
> 2.26.0
> 
