Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064BFC433F5
	for <rcu@archiver.kernel.org>; Sun, 13 Feb 2022 04:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiBMEKO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 12 Feb 2022 23:10:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiBMEKN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 12 Feb 2022 23:10:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018705F27D;
        Sat, 12 Feb 2022 20:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9lgENlLH+E/IJinaeOP1R7M6s/XOyGy5yYBeg0uvqY=; b=uPISaPZ7NAppRwSbiaADv/BNro
        v+g5aXjZoUIzbeS68b6zBoMjLRFFI9GYaUH290Pscue04bqDB8K9ppiB2pIqclLYq/IIX2LZNaCYT
        6718HT1Cv0ujzzrEhL2Jz4/YV/wdaER713UmY4KGY7KzG7ecUnK0qOXa4NA5ycSiiYtbyW4F/KKsD
        3fcu3zxxxvmqUBrx9MMqt1q3Mb2NS0w4+3aXK9C3l8eZr9Fpw4wE9zA4w694SkUFvenPGag3z6jis
        jHYpVc2Eo54+xnMlgVzCtVaZCqJiJnNxE2eynAN1VY2hgWRHkBi6dpEhlIphmLIkAughbtTIQhMZC
        bbzEka5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJ6CW-00Blhs-Gg; Sun, 13 Feb 2022 04:09:28 +0000
Date:   Sun, 13 Feb 2022 04:09:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 include/linux/sched/mm.h:256
Message-ID: <YgiEeHzz4JZFszJD@casper.infradead.org>
References: <244218af-df6a-236e-0a52-268247dd8271@molgen.mpg.de>
 <CAABZP2ycCjiZ0CySc2Lgr_DnUfuDf1iagEKnWwNEkVkR9-gADA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2ycCjiZ0CySc2Lgr_DnUfuDf1iagEKnWwNEkVkR9-gADA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Feb 13, 2022 at 11:19:09AM +0800, Zhouyi Zhou wrote:
> I think the key to the problem lies in your attached console.log
> (pasted below), at times 0.014987 and 0.015995, I see there are two
> locks (cpu_hotplug_lock and jump_label_mutex)  holded while
> kmem_cache_alloc calls __might_resched (0.023356).

Those are both sleeping locks (a percpu_rwsem and mutex, respectively).
There is no problem with sleeping while holding a mutex or rwsem.
