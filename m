Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C07BC433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 22:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394E220663
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 22:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaMaB1I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLWKa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFLWK3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 18:10:29 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6EBC03E96F;
        Fri, 12 Jun 2020 15:10:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p18so7466522eds.7;
        Fri, 12 Jun 2020 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FPX3MJoxZeWoHivAlogW1ZZLv6+3QhfavqSqMXGB42k=;
        b=KaMaB1I02jxR8GEyelYNQ8tbvVbcEqRIfTc1jVV9mxOsD9vepo0zE6a+derurmWrkA
         ZIHlFpZcqmRRmoJCK2zm3VWiV1ySgprmmb17/S8746+48AT6SxYK5hQQofvKD087wQ/o
         NIZ9Phn0vKJbHNug+B+e2KQ+7Y5BxD/w/X9t3mSGMOdPL/dgMf0j3T4x+3ANl11i58UD
         wS5jEr0HMQ9jdJ9lRZ0wZ0d9tVv46ynfmw4qyW/d4gskErig0p5xRp77W2CerMLGmTmY
         xCGaLBd28lPFYMC+59gw3Kef/GupelKBIrkxBBDr2DFKid/nxQZMmtgRqmccM9Mlkr9/
         rsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FPX3MJoxZeWoHivAlogW1ZZLv6+3QhfavqSqMXGB42k=;
        b=Z7viAD6tRmz4lJqnLa7+FUVf5qv1WJXyIX4/mrbbqZQO6culv7bw+c7r5Y1zsPJ1hm
         /zcBKBypYlurA1IiVBBMSdM+KUHMryM9F6SeCadHvCqyw5kKb9sdPCW80JCjBPmTFkMv
         Q0dCJ427o7j6w+NimY5xKhEzaQxwG0UlGXnp+F6VTVcrlu3tz20wJkd+cVFJ5sdaL2PT
         BjeHw9/TW1mEYL2ZOaFzPvTa9zB/poOHWAuIO1K3wPpk1VHgmnMGESj/6R527IB6XkvT
         n0jCt+PE65gV1A9txltLLiLEKLtQDTZLur8SbI6+EDmX2sLA3x+tbQhQ6sOZHs7g4GQ0
         O9HA==
X-Gm-Message-State: AOAM530lD1uYioGfSKSX1rOAXT0cM4sRf/KxbapUIycVVSKuU1HNP4BU
        BX72n0Z0d+RFGyagf0cbCJo=
X-Google-Smtp-Source: ABdhPJyXgdhM/A39ansx1r0t9NpObObesgG8G3PZM+KANTY8l06WC0KRqk+xc2bATG9gxLackSk6Zg==
X-Received: by 2002:a50:c181:: with SMTP id m1mr13245945edf.27.1591999826954;
        Fri, 12 Jun 2020 15:10:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g13sm3718600edy.27.2020.06.12.15.10.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 15:10:26 -0700 (PDT)
Date:   Fri, 12 Jun 2020 22:10:25 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] rcu: use gp_seq instead of rcu_gp_seq for consistency
Message-ID: <20200612221025.7ry7wffycoa7pned@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
 <20200612020755.50526-5-richard.weiyang@linux.alibaba.com>
 <20200612141248.GK4455@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612141248.GK4455@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 12, 2020 at 07:12:48AM -0700, Paul E. McKenney wrote:
>On Fri, Jun 12, 2020 at 10:07:55AM +0800, Wei Yang wrote:
>> Commit de30ad512a66 ("rcu: Introduce grace-period sequence numbers")
>> introduce gp_seq in rcu_state/rcu_node/rcu_data. And this field in last
>> two structure track the one in first.
>> 
>> While the comment use rcu_gp_seq which is a little misleading for
>> audience. Let's use the exact name gp_seq for consistency.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>
>I applied and pushed the others -- good eyes, and thank you!
>
>This one does not apply.  Could you please forward-port it to
>the "dev" branch of -rcu?
>

The reason is someone has already fixed this :-)

>git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>
>							Thanx, Paul
>
>> ---
>>  kernel/rcu/tree.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index 512829eed545..3356842bc185 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -41,7 +41,7 @@ struct rcu_node {
>>  	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
>>  					/*  some rcu_state fields as well as */
>>  					/*  following. */
>> -	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
>> +	unsigned long gp_seq;	/* Track rsp->gp_seq. */
>>  	unsigned long gp_seq_needed; /* Track furthest future GP request. */
>>  	unsigned long completedqs; /* All QSes done for this node. */
>>  	unsigned long qsmask;	/* CPUs or groups that need to switch in */
>> @@ -149,7 +149,7 @@ union rcu_noqs {
>>  /* Per-CPU data for read-copy update. */
>>  struct rcu_data {
>>  	/* 1) quiescent-state and grace-period handling : */
>> -	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
>> +	unsigned long	gp_seq;		/* Track rsp->gp_seq. */
>>  	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
>>  	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
>>  	bool		core_needs_qs;	/* Core waits for quiesc state. */
>> -- 
>> 2.20.1 (Apple Git-117)
>> 

-- 
Wei Yang
Help you, Help me
