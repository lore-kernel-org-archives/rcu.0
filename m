Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19985C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 05:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B632073E
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 05:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgCMFLp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 01:11:45 -0400
Received: from mx.sdf.org ([205.166.94.20]:59902 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgCMFLp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 01:11:45 -0400
Received: from sdf.org (IDENT:lkml@rie.sdf.org [205.166.94.4])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02D570nn024801
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Fri, 13 Mar 2020 05:07:00 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02D56xpZ024644;
        Fri, 13 Mar 2020 05:06:59 GMT
Date:   Fri, 13 Mar 2020 05:06:59 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313050659.GA22938@SDF.ORG>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312191009.GA27429@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

I'd just like to mention that the is_vmalloc_addr() test depends only on 
the virtual address, so can be done when the memory is queued, before the 
grace period.  That is, you could have kfree_rcu(), vfree_rcu(), and a 
kvfree_rcu() function which decides between them.

One advantage of that would be that you could put the vfree() sanity
checks into vfree_rcu(), so errors would have a useful backtrace,
and just do the __vunmap when the grace period expires.

Or you could build a mixed queue and do the is_vmalloc_addr() test at
the end of the grace period.  That was my original idea, because it
avoids the need for a separate queue.  (In the _rcu_bulk_data structure,
you can do a quicksort-style partitioning on is_vmalloc_addr(), so
the kfree_bulk() pointers are all contiguous.)

Just an implementation option.
