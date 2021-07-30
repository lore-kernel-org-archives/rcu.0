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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120F5C4338F
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 02:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0AA60F46
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 02:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhG3C3d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Jul 2021 22:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhG3C3c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Jul 2021 22:29:32 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C27C061765;
        Thu, 29 Jul 2021 19:29:27 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a14so7918005ila.1;
        Thu, 29 Jul 2021 19:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QeHotJjJc3ECxkXaUSL9CsnihU3YDOrBs2SQnUF73R4=;
        b=F1NVJbag9cOonSXYlxMIWsdTp1za0D+hChGTKIMF0ZPE9UHMOab7hWjaqkm//WH82x
         s117SygQkZlF68srGFhpqOgKQ7n/20Gl9g/6u5e+tKPvW58wjl1DdClGFvdWUmw0g5M+
         EHs96zwVbMEtV8/qON1tQrstpQdzPlsw1uGjbB2AQ3YjulyZO9qb6jg01cLSpthlzVz+
         eeuoBcqrP7EDG54EuESGU08ar5WPte+7ZegDxAE7k/tDgqKePIoJVzQgYEv9LwD/Bnbo
         devit/0n1UGNLzWeh2KJLZYgyjNACf3hjfjix+x/5HaLa1ChlYwfCOf+wke1ixGzEflZ
         B8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QeHotJjJc3ECxkXaUSL9CsnihU3YDOrBs2SQnUF73R4=;
        b=VMf+LiUMUIOn8ZdVwzeAftdvOvRtz+lF5rR/RReM/ogM7oWDEDAcA4Qb6tVjugXSjl
         mq0VwfxwKHIq0ZVov6agEMdNuJ8lcBVv6b/z6ZSwbv9Wj7RrM/BhveHQXcJJnRZb5XCN
         +PQ3bSiCqul2neJus72+kyyJAfBJDoNl78mDRlgPDw84FyPrbB68IQIqcaAqaACr5Y5Q
         R6NeiJ+63r2UQI+UL4+sxvwzwAVjr75JLLtM2refx54oZeR8W+GYkwTgFG7+78LE1mat
         kNt+NDpAcKst15kLNRAVUwbhjorl9DFI0Q/nI1gmE3MVioH5KjXOzzDn04XIYXIMQXKw
         n0VQ==
X-Gm-Message-State: AOAM532yhZDXiJ1Exkaa2wtau9KeDqhCQ1g9JtwszXiPk4x1oLdms6xq
        xIy0CNjS42WKw8Uu2Yp9fM0=
X-Google-Smtp-Source: ABdhPJwUdbrwjaG+48nemknI5rQPG5KCH7rLSP/tMRXY6xez3t4sgVSCIqiv81EoNGjLihcJCcQF/Q==
X-Received: by 2002:a92:d10c:: with SMTP id a12mr217675ilb.100.1627612167192;
        Thu, 29 Jul 2021 19:29:27 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t11sm73693ilp.66.2021.07.29.19.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 19:29:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7174427C0054;
        Thu, 29 Jul 2021 22:29:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Jul 2021 22:29:25 -0400
X-ME-Sender: <xms:A2QDYVOLowlpEvRrV9hfo1HR897GHZGYYowzpUfJy2Nf_m6s9vADEg>
    <xme:A2QDYX8ASby-OVReSGusaZExFSUqOe7mEB9-PjJ-VK8WsBFaQ08560VKCDAyE7P9u
    D04PhxmkrYPISaUrQ>
X-ME-Received: <xmr:A2QDYUSo-09UGMR4658vtKMNFhY_srdLNjd2kzG-xYSBNuhWpQs66KI3xNUhAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:A2QDYRsp54LXuBVOtWs1cWT3Ycf2QdfvEI4yBXk6rGj88xGv4HzBUQ>
    <xmx:A2QDYdeGgvYKNvbCpwIv79iMaKSCRG3wecKLF-CcOk6cUYzTgn-kFA>
    <xmx:A2QDYd0v03t65b6SqVcNklhMCJsAOvmkyP3IGlmbg_Yt7HTvdO-brg>
    <xmx:BWQDYYuBcnjzo_-HBGfzwBgJJDiorvyj-_0R2MgMoqt6eSjnSqBNzIlsrUk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jul 2021 22:29:23 -0400 (EDT)
Date:   Fri, 30 Jul 2021 10:28:58 +0800
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
Message-ID: <YQNj6v2o5hG/MoXZ@boqun-archlinux>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-11-paulmck@kernel.org>
 <YQJsxtypw7M/3XBD@boqun-archlinux>
 <20210729140317.GU4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729140317.GU4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 29, 2021 at 07:03:17AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 29, 2021 at 04:54:30PM +0800, Boqun Feng wrote:
> > On Wed, Jul 21, 2021 at 01:21:19PM -0700, Paul E. McKenney wrote:
> > > Accesses to ->qsmask are normally protected by ->lock, but there is an
> > > exception in the diagnostic code in rcu_check_boost_fail().  This commit
> > > therefore applies data_race() to this access to avoid KCSAN complaining
> > > about the C-language writes protected by ->lock.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/tree_stall.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index 42847caa3909b..6dd6c9aa3f757 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -766,7 +766,7 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
> > >  
> > >  	rcu_for_each_leaf_node(rnp) {
> > >  		if (!cpup) {
> > > -			if (READ_ONCE(rnp->qsmask)) {
> > > +			if (data_race(READ_ONCE(rnp->qsmask))) {
> > 
> > If the write sides allow normal writes, i.e. allowing store tearing, the
> > READ_ONCE() here could read incomplete writes, which could be anything
> > basically? And we get the same result if we remove the READ_ONCE(),
> > don't we? Yes, I know, without the READ_ONCE(), compilers can do
> > anything to optimize on rnp->qsmask, but the end result is same or
> > similar to reading incomplete writes (which is also a result by compiler
> > optimization). So if we mark something as data_race(), **in theory**, it
> > makes no difference with or without the READ_ONCE(), so I think maybe we
> > can remove the READ_ONCE() here?
> 
> In this particular case, perhaps.  But there is also the possibility
> of ASSERT_EXCLUSIVE_WRITER() in conjunction with WRITE_ONCE(), and
> data_race(READ_ONCE(()) handles all such cases properly.
> 
> Again, the point here is to prevent the compiler from messing with
> the load in strange and unpredictable ways while also telling KCSAN
> that this particular read should not be considered to be part of the
> concurrent algorithm.
> 

Thanks for explaining this ;-)

I guess I'm just a little concerned that things may end up with using
data_race(READ_ONCE()) everywhere instead of data_race(), because who
doesn't want his/her racy code to be 1) not reported by KCSan (using
data_race()), and 2) less racy (using READ_ONCE())? ;-)

Regards,
Boqun

> 							Thanx, Paul
> 
> > Regards,
> > Boqun
> > 
> > >  				return false;
> > >  			} else {
> > >  				if (READ_ONCE(rnp->gp_tasks))
> > > -- 
> > > 2.31.1.189.g2e36527f23
> > > 
