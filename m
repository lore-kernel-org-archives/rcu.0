Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47368C41537
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 17:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244116104F
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 17:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbhHCRGY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:06:24 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:48572 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237576AbhHCRGW (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 3 Aug 2021 13:06:22 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 8349F1807F1F9
        for <rcu@vger.kernel.org>; Tue,  3 Aug 2021 16:48:29 +0000 (UTC)
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5BB41837F24C;
        Tue,  3 Aug 2021 16:48:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 8C25327DD31;
        Tue,  3 Aug 2021 16:48:24 +0000 (UTC)
Message-ID: <5a494dd8d0e04030204f61067cb1010ef0c78f27.camel@perches.com>
Subject: Re: [PATCH rcu 15/18] rcu: Remove useless "ret" update in
 rcu_gp_fqs_loop()
From:   Joe Perches <joe@perches.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Liu Song <liu.song11@zte.com.cn>
Date:   Tue, 03 Aug 2021 09:48:23 -0700
In-Reply-To: <20210721202127.2129660-15-paulmck@kernel.org>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
         <20210721202127.2129660-15-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: kp19h6n7f9kgx7uxnh7wia3abcfefwce
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8C25327DD31
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1857Ov4ju+xuMB8Jet2sOrcvo+xjK4vwSs=
X-HE-Tag: 1628009304-571790
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 2021-07-21 at 13:21 -0700, Paul E. McKenney wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Within rcu_gp_fqs_loop(), the "ret" local variable is set to the
> return value from swait_event_idle_timeout_exclusive(), but "ret" is
> unconditionally overwritten later in the code.  This commit therefore
> removes this useless assignment.
[]
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
[]
> @@ -1960,8 +1960,8 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
>  		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>  				       TPS("fqswait"));
>  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
> -		ret = swait_event_idle_timeout_exclusive(
> -				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
> +		(void)swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
> +				 rcu_gp_fqs_check_wake(&gf), j);

It doesn't seem this is a __must_check routine so why
bother to cast to void ?

>  		rcu_gp_torture_wait();
>  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
>  		/* Locking provides needed memory barriers. */


