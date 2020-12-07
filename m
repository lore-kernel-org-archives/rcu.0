Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6919EC4361B
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E6E2333F
	for <rcu@archiver.kernel.org>; Mon,  7 Dec 2020 11:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLGLwP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgLGLwP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Dec 2020 06:52:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DC4C0613D2;
        Mon,  7 Dec 2020 03:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tg95pwKVfQPUA8PWvLFZbteHSebozu5OxDajnVjWT7Q=; b=u1zSahYWjFBIP5IjABN49An1Lw
        Ih6LRN0GYM8r8c4EgAJe5wiBDgjqi8sbVf179ZZCyjOKoSmfmbx5AexCoBLGSC0acL/ZrdoG+KhWg
        5NC11Ug4yLcTlqyAcAGKZOmNEEphtUMSxLpIuPUdtAHLnqlZhe0/s2wE4AOD8oSERNWikv1IVrSKp
        ArrkBcC9fY0cDmnNtx3f15fswRylgYxDVeR6tVybb+buu+yvDdW6OTI9JqGpya83wgA0mHakERdSJ
        T/EhHLeVsQn7w5Nk6IvrPt0sZaDxJuYxcyOXLwHXhzH+yrwlnhxItdXWed9Odgv3fcFAL2KN+facw
        p4btqyRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmF2z-0000Ii-Rc; Mon, 07 Dec 2020 11:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F7AB303DA0;
        Mon,  7 Dec 2020 12:51:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9D9E2081295B; Mon,  7 Dec 2020 12:51:15 +0100 (CET)
Date:   Mon, 7 Dec 2020 12:51:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, lkft-triage@lists.linaro.org,
        rcu@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        mathias.nyman@linux.intel.com, Qian Cai <cai@lca.pw>
Subject: Re: BUG: KCSAN: data-race in mutex_spin_on_owner+0xef/0x1b0
Message-ID: <20201207115115.GL3040@hirez.programming.kicks-ass.net>
References: <CA+G9fYuJF-L+qHJ3ufqD+M2w20LgeqMC0rhqv7oZagOA7iJMDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuJF-L+qHJ3ufqD+M2w20LgeqMC0rhqv7oZagOA7iJMDg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 04, 2020 at 11:51:39PM +0530, Naresh Kamboju wrote:
> LKFT started testing KCSAN enabled kernel from the linux next tree.
> Here we have found BUG: KCSAN: data-race in mutex_spin_on_owner
> and several more KCSAN BUGs.
> 
> This report is from an x86_64 machine clang-11 linux next 20201201.
> Since we are running for the first time we do not call this regression.
> 
> [    4.745161] usbcore: registered new interface driver cdc_ether
> [    4.751281] ==================================================================
> [    4.756653] usbcore: registered new interface driver net1080
> [    4.752139] BUG: KCSAN: data-race in mutex_spin_on_owner+0xef/0x1b0

At the very least run your splat through ./scripts/decode_stacktrace.sh

It's impossible to know what the thing is complaining about. I suspect
this is one of those known KCSAN 'bugs' where it can't tell a load+cmp0
is perfectly fine.
