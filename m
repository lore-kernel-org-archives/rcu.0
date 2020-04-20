Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB6C54FD0
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 21:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA01C20672
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 21:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLl7hGj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDTV2k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgDTV2k (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 20 Apr 2020 17:28:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9CC061A0C;
        Mon, 20 Apr 2020 14:28:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so1283774wmh.0;
        Mon, 20 Apr 2020 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nch3oPa8U1oHJxNa/tt8ccjtrHSf13GKGszol75zytE=;
        b=SLl7hGj8FVFVlvCC/+faP8qh4tSAuGz4wygWSMbPQBe1je/dYQwHtuKDQjVXKQMnCW
         hWZYF7CmDZX1fUrAQf66rJUxcB0NgxTHKRbzmlDsQHGVzi+vDiFUzuYdKBqoK49RsXOJ
         YnuBIZP040Vd37UCpHujRyuK09D6XLak4UEX22ovNZ2CUpkMeOripV7h/OuHe2Dxs1Ok
         aHNjdzp9nlCCTRIbrr93BEbxSLdVRbHAOPktGpjb5SIIsTqQFhGXqc5kEl/ihFQgLIAe
         gMUahq/ZKv6YClOgoJwoJmOSY2Jb9+sVqfSLIqij0Z2mpiRBZKBZJgIx+VsIfraumH06
         7uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nch3oPa8U1oHJxNa/tt8ccjtrHSf13GKGszol75zytE=;
        b=fqlarqVRf/gH9dNW0HgPiOg+/s9YHtefiyPHczh6MOQIhJseZ3yoGm+OcYmuEgtuw7
         aFqPURP9RBn2Qe6T9WgkrNq7jJWu2M+5BynHcYysdnIp+KDc/TSW/I4OdC9+5YYkz1Nl
         1RpjAmdrPmIGCMpgnQuUsryHgm8+5vi7DymxOZUcoDt77mYuy3HmDb6quAwDjstSgmG5
         CPw3bYoy0QfgGW7ue1bSA4Ls0D5BdE4v5QlFH2acO8ZnvwWm1lI6YKDx9VBdjdoL0eAd
         eMlYbHrFQ/isfe+czLxKI9TZba8OScrsUVVd0mdQM2I9ckyelPpEBh8ivSm4iOsalPHx
         gd/A==
X-Gm-Message-State: AGi0PubhlO4vRl6XzpERtAmCTt7qxw2O8RlMClG3GwPIMdkjDcd7pnh4
        w0I0uT4wFFZdYeaaSdH4MnNGT5Jz
X-Google-Smtp-Source: APiQypJIbOVg0ybiqpoZeJ0zrOE3pBS/2d5IDIraLbFzh2GnmHIa5vDeE2u0Yo/KUQPC06l8yNkiLg==
X-Received: by 2002:a05:600c:218e:: with SMTP id e14mr1479258wme.140.1587418118856;
        Mon, 20 Apr 2020 14:28:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u17sm1157607wra.63.2020.04.20.14.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Apr 2020 14:28:38 -0700 (PDT)
Date:   Mon, 20 Apr 2020 21:28:37 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] rcu: simplify the calculation of rcu_state.ncpus
Message-ID: <20200420212837.j6vnzrhm6oqvbxqa@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200419215715.21071-1-richard.weiyang@gmail.com>
 <20200420014137.GW17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420014137.GW17661@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Apr 19, 2020 at 06:41:37PM -0700, Paul E. McKenney wrote:
>On Sun, Apr 19, 2020 at 09:57:15PM +0000, Wei Yang wrote:
>> There is only 1 bit set in mask, which means the difference between
>> oldmask and the new one would be at the position where the bit is set in
>> mask.
>> 
>> Based on this knowledge, rcu_state.ncpus could be calculated by checking
>> whether mask is already set in rnp->expmaskinitnext.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>Queued, thank you!
>
>I updated the commit log as shown below, so please let me know if I
>messed something up.
>

Looks pretty good.

>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>commit 2ff1b8268456b1a476f8b79672c87d32d4f59024
>Author: Wei Yang <richard.weiyang@gmail.com>
>Date:   Sun Apr 19 21:57:15 2020 +0000
>
>    rcu: Simplify the calculation of rcu_state.ncpus
>    
>    There is only 1 bit set in mask, which means that the only difference
>    between oldmask and the new one will be at the position where the bit is
>    set in mask.  This commit therefore updates rcu_state.ncpus by checking
>    whether the bit in mask is already set in rnp->expmaskinitnext.
>    
>    Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>index f288477..6d39485 100644
>--- a/kernel/rcu/tree.c
>+++ b/kernel/rcu/tree.c
>@@ -3732,10 +3732,9 @@ void rcu_cpu_starting(unsigned int cpu)
> {
> 	unsigned long flags;
> 	unsigned long mask;
>-	int nbits;
>-	unsigned long oldmask;
> 	struct rcu_data *rdp;
> 	struct rcu_node *rnp;
>+	bool newcpu;
> 
> 	if (per_cpu(rcu_cpu_started, cpu))
> 		return;
>@@ -3747,12 +3746,10 @@ void rcu_cpu_starting(unsigned int cpu)
> 	mask = rdp->grpmask;
> 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
>-	oldmask = rnp->expmaskinitnext;
>+	newcpu = !(rnp->expmaskinitnext & mask);
> 	rnp->expmaskinitnext |= mask;
>-	oldmask ^= rnp->expmaskinitnext;
>-	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
> 	/* Allow lockless access for expedited grace periods. */
>-	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
>+	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
> 	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
> 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
> 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);

-- 
Wei Yang
Help you, Help me
