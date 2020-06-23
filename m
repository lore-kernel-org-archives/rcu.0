Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4FC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 17:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9380F20706
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DUzNSncd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgFWRFO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732648AbgFWRFO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Jun 2020 13:05:14 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01FC061573;
        Tue, 23 Jun 2020 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cANkEFDgWeZV3xkDJpcEyymewXhJ/RQ1hcXqcEC5nUg=; b=DUzNSncd8Ok2qhHGh2xkJI/QHo
        /mb0u9czOh17xKJqD2F/IUQ/FDpl3b07u/lgKQOHi3CVZcwcqT66o49+zguOyWGcI3hmELvokfMN4
        H3l0x7wt4Q3nWemVKFREY/tI9VcdtZ5VGLxj3lov2XXjQnkXo/046VC029UrzfO42V/yuj3RCBXqP
        QZGESOuvHrudwuiuqMf10dZtrwBGc52bPp+tfrXlvL0GiscOdluaRpMC+5fkgQfYSp793r4UsZQFD
        yScsZoeiFzE5ihkjEf4r/1ql7mFNeOVFm+IdWmBwjL/b4P3AU/BGFWIOevFJF26CHWO4GY/ROCJKM
        PiUQCGGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnmLS-0003wp-LU; Tue, 23 Jun 2020 17:04:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A156730477A;
        Tue, 23 Jun 2020 19:04:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CB1E234EBA55; Tue, 23 Jun 2020 19:04:25 +0200 (CEST)
Date:   Tue, 23 Jun 2020 19:04:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 16/26] rcu: Mark rcu_nmi_enter() call to
 rcu_cleanup_after_idle() noinstr
Message-ID: <20200623170425.GR4817@hirez.programming.kicks-ass.net>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
 <20200623002147.25750-16-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623002147.25750-16-paulmck@kernel.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 05:21:37PM -0700, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The objtool complains about the call to rcu_cleanup_after_idle() from
> rcu_nmi_enter(), so this commit adds instrumentation_begin() before that
> call and instrumentation_end() after it.

Hmm, I've not seen this one. Still,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 08e3648..67912ad 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -980,8 +980,11 @@ noinstr void rcu_nmi_enter(void)
>  		rcu_dynticks_eqs_exit();
>  		// ... but is watching here.
>  
> -		if (!in_nmi())
> +		if (!in_nmi()) {
> +			instrumentation_begin();
>  			rcu_cleanup_after_idle();
> +			instrumentation_end();
> +		}
>  
>  		incby = 1;
>  	} else if (!in_nmi()) {
> -- 
> 2.9.5
> 
