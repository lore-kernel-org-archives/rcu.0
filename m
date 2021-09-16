Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C66C433F5
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184D661214
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 14:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhIPO3Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbhIPO3O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 10:29:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A123C061574;
        Thu, 16 Sep 2021 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e0kfV41WHc7RPbsfEn/+AVY29neHekRcD2dCKV7QMcM=; b=BiF8x1PthcevAOjk6Qz7pofGsD
        w407n0EDr4M1O2zwSRUvxdJPtOL8loYME+Sk/Gfi+cibd8CgcdfOSMQyY5t7FNz/4+cqtK2DQofV9
        45+AoJT5XCZXqp772e225znV1A8ZymeOQ7D3lBfhWzBMfP7z5z0RjC448dnX+u4DNLLDEZZGprfuj
        u696plFmD3TMEqpuhc1VJ+L+zF/tgCecZ/zCupul6NR1hWe/tzC06pnVITv1pgFafzm4nL7zquQTf
        GEjAraOApAHlNd0DiJ5SmTcEtb8xowPaoXPulb3/eL5MQtdTyYRPAHw44SKuXpTIidLBhQn1l3MHn
        oloD1Eiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQsMB-003fkK-5I; Thu, 16 Sep 2021 14:27:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E41C530003A;
        Thu, 16 Sep 2021 16:27:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B46E62CEC0F72; Thu, 16 Sep 2021 16:27:15 +0200 (CEST)
Date:   Thu, 16 Sep 2021 16:27:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH rcu 11/14] rcu: Make rcu_normal_after_boot writable again
Message-ID: <YUNUQ564PKq9wtTF@hirez.programming.kicks-ass.net>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
 <20210915233343.3906738-11-paulmck@kernel.org>
 <YULyiT+RbAgHxO7u@hirez.programming.kicks-ass.net>
 <20210916135712.GB4156@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916135712.GB4156@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 16, 2021 at 06:57:12AM -0700, Paul E. McKenney wrote:
> RT systems they avoid expedited grace periods by booting with either
> the rcupdate.rcu_normal or the rcupdate.rcu_normal_after_boot kernel
> boot parameters.  And here is the definition for the latter:
> 
> static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT);
> 
> In other words, RT systems shut off expedited grace periods by default,
> and are thus free to use nohz_full CPU or not, as they choose.  When using
> nohz_full, they can also enable expedited grace periods by booting with
> rcupdate.rcu_normal_after_boot=0.  Or not, sysadm's choice.
> 
> So I am not seeing a problem here.  What am I missing?

That wasn't at all clear to me from the Changelog. I thought it was
enabling expedited crud for RT.
