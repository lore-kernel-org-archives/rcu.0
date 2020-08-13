Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5018CC433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 14:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3712078D
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 14:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/4/G4vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMOcc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMOcc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 10:32:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20189C061757;
        Thu, 13 Aug 2020 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZ4M8tKLPliGwtcQpOjdflP90B5wX1qQuYOyiE0uFF0=; b=X/4/G4vZU1JqV4cr8bq0T7Bilf
        TrPRzkxZp1umwgwIqquTlLpJhKBkeGG2Uo9NZDvLNXS4b/EJ8JJ1vqqylnqZf1FFzHs31mRtFdc2I
        mEFvyOYpohnq3rsTgzqnLY3I3jwslB/ECCQi+biR/VXAQ+wdUcxED7vhxkhUkeFeobLt9H5p+PZys
        NiZk6EMIRTK2auuUv+lkIXC56G1axCflYSP+fdCVvB3XucJUkpaDRCcsLHKA/23QXlEcs8yeM9Xet
        kFCCBkwD/ZTJbhK0q7jY5vA2NNEfotNo2u7h3tF5+n/Vf1ky7ktAjcy/ZFT7vYX8ecrjg9uJls6zd
        8zSlI3lg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6EHF-0004HL-5Y; Thu, 13 Aug 2020 14:32:21 +0000
Date:   Thu, 13 Aug 2020 15:32:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200813143221.GI17456@casper.infradead.org>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <20200813111505.GG9477@dhcp22.suse.cz>
 <871rkallqk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rkallqk.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 03:27:15PM +0200, Thomas Gleixner wrote:
> And guarding it with RT is not working either because then you are back
> to square one with the problem which triggered the discussion in the
> first place:
> 
> raw_spin_lock()
>   alloc()
>     if (RT && !preemptible())  <- False because RT == false
>     	goto bail;
> 
>     spin_lock(&zone->lock)  --> LOCKDEP complains
> 
> So either you convince Paul not to do that or you need to do something
> like I suggested in my other reply.

I'd like to throw in the possibility that we do something like:

  raw_spin_lock()
    alloc()
      if (!spin_trylock(&zone->lock))
        if (RT && !preemptible())
          goto bail;
        spin_lock(&zone->lock);

would that make us feel more comfortable about converting zone->lock to
a raw spinlock?
