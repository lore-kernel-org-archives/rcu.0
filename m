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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10DC4338F
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 08:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7EA61059
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhG2IzC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhG2IzA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Jul 2021 04:55:00 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D2EC061757;
        Thu, 29 Jul 2021 01:54:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h1so6071098iol.9;
        Thu, 29 Jul 2021 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N6vdYNDn6gd/T46MoBvG9s7ZIUiNhoAqMIBR6eS+uK4=;
        b=SB763H4tZcqpohMFCcNoF3GvCHnSZH8J+1quC9EHsN9XT3wwkZ4bm5jiWcIIqC8OXc
         zOo0iCGGbZLvmBDVVzc6K2yOgfBhyqoMPfcrpvzh9gbrpQXskubfZmnSNA7oVbP4uebY
         VvadoyZY32RbBf8/+pZQBC3na7qgndXVf09uYRflCvM9thfeWnrwvQKA3tsrtYNLfREN
         FviecqjwcNMwexaytGgGICvlEGk3KEAFdUlHU9l9yLU7DpcyogctoSN/DY2g8LKLX4FD
         8ICByIYfueJPPbt8ZVunfHF11wb+MrjEFkFZYtNvD6aeS8yLtcRs97JFPx/cSlkPJ7sk
         /XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N6vdYNDn6gd/T46MoBvG9s7ZIUiNhoAqMIBR6eS+uK4=;
        b=d/Q/FqtZrDg+QS9FPKseMPUr7q7qwdw9oJTpTgJ/jK28w2nCRIw7ZHs+OUB/M6snkX
         L3nqZxkaiG17mSaGADyMtZ2jc53DKLUEG0IlsUYbzpRTiTH8xm9U1dl0SF9yWstq/vsj
         nNUodwVKqzK7SonAQlv/iYqVpUpZenevcxEErNQLzrXF3s9QBSl4xBQHPmn6WR0cMVFc
         Fq4y8gUhLaBg5xo02dCEwL4ULHuciN7bmv55cn2h86hn+72dsSB8MzdV4LNYcOz+JgKS
         NpC07Wcvx2khnUyFEZAvQ++K2me3q6H3CMnc6nzWNRnCYrdCIqOe7QWLTWAXvqd4jIYF
         LFaw==
X-Gm-Message-State: AOAM533eMnZ3qE8XtCFrWx/9OFgq3cmsPDwgGy5dlkmcpH9mnvKbGAL/
        +CXO0qlee3V0LK7Sd7QQPsA=
X-Google-Smtp-Source: ABdhPJzJ3MNH0e799C4EyfIYGXPlv8MpqsHj1W82o7UK2kg8B+6d5wiC55W3gRJlcJojpC+oSGHieA==
X-Received: by 2002:a6b:f813:: with SMTP id o19mr3161518ioh.49.1627548896275;
        Thu, 29 Jul 2021 01:54:56 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k4sm1826601ior.55.2021.07.29.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:54:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 66B7027C0054;
        Thu, 29 Jul 2021 04:54:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Jul 2021 04:54:54 -0400
X-ME-Sender: <xms:3WwCYZ49cvqtm3VjLUU01p-Ub0ZNmJSRlkk12PW13tHh0TPSOashtA>
    <xme:3WwCYW5Mnl9Q3Q2852XZqwG9_5jmGT-fP60YHCS6hb6KnOie4-J0laohbAjSpx78x
    GWA_w3o1OMrCAJ6uw>
X-ME-Received: <xmr:3WwCYQe32b8DjrCHaHo8Jb4Q7MC2tnXS6uzVSn7fROp74-lgChCxaezXy6tR6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrhedugddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:3WwCYSKkelvMCoZLdwkfbavYFU1xqBZlUopzMSmfcLJYosb5mid3rg>
    <xmx:3WwCYdIySipw23VXuEqYF2aVHTTPBDbtogz-36Vhva4d3ifw6xHMng>
    <xmx:3WwCYbzrviHNnx7RsDb-25Hb7rM7Y6S6hQ92p_7Q2A2ridCuFqHFyg>
    <xmx:3mwCYW7U0YDv4uYplGb9Swet0TmPvdkdGfMpM4Yn5AXHtMLFSp8Zz1hj6wY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jul 2021 04:54:52 -0400 (EDT)
Date:   Thu, 29 Jul 2021 16:54:30 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH rcu 11/18] rcu: Mark lockless ->qsmask read in
 rcu_check_boost_fail()
Message-ID: <YQJsxtypw7M/3XBD@boqun-archlinux>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-11-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721202127.2129660-11-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 21, 2021 at 01:21:19PM -0700, Paul E. McKenney wrote:
> Accesses to ->qsmask are normally protected by ->lock, but there is an
> exception in the diagnostic code in rcu_check_boost_fail().  This commit
> therefore applies data_race() to this access to avoid KCSAN complaining
> about the C-language writes protected by ->lock.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_stall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 42847caa3909b..6dd6c9aa3f757 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -766,7 +766,7 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
>  
>  	rcu_for_each_leaf_node(rnp) {
>  		if (!cpup) {
> -			if (READ_ONCE(rnp->qsmask)) {
> +			if (data_race(READ_ONCE(rnp->qsmask))) {

If the write sides allow normal writes, i.e. allowing store tearing, the
READ_ONCE() here could read incomplete writes, which could be anything
basically? And we get the same result if we remove the READ_ONCE(),
don't we? Yes, I know, without the READ_ONCE(), compilers can do
anything to optimize on rnp->qsmask, but the end result is same or
similar to reading incomplete writes (which is also a result by compiler
optimization). So if we mark something as data_race(), **in theory**, it
makes no difference with or without the READ_ONCE(), so I think maybe we
can remove the READ_ONCE() here?

Regards,
Boqun

>  				return false;
>  			} else {
>  				if (READ_ONCE(rnp->gp_tasks))
> -- 
> 2.31.1.189.g2e36527f23
> 
