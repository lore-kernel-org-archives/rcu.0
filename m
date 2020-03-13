Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77967C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E78206B7
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 16:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMQ5R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:57:17 -0400
Received: from mx.sdf.org ([205.166.94.20]:52512 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgCMQ5Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 12:57:16 -0400
Received: from sdf.org (IDENT:lkml@otaku.sdf.org [205.166.94.8])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02DGqK5N014403
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Fri, 13 Mar 2020 16:52:20 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02DGqJJX002553;
        Fri, 13 Mar 2020 16:52:19 GMT
Date:   Fri, 13 Mar 2020 16:52:19 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, lkml@sdf.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313165219.GA1384@SDF.ORG>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313050659.GA22938@SDF.ORG>
 <20200313135400.GQ3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313135400.GQ3199@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 06:54:00AM -0700, Paul E. McKenney wrote:
> I would guess that sorting them before the grace period might improve
> cache locality and thus performance.  So it does seem like an excellent
> thing to try, at the very least as an experiment.

That doesn't seem at all obvious.  Processing them in separate batches
would improve I-cache locality, but you could sort them after the
grace period just as well as before.  Especially if you have arrays of 
500 pointers to work with.

Indeed, one thing that seems worth trying is sorting by address, which 
would improve D-cache locality, since you have a significant chance for 
consecutive frees to be in the same slab or otherwise reference the same 
overhead data structures.

Sorting by (address - VMALLOC_START) automatically groups the vallocated 
poiners together at the front, too.  Since there's no vfree_bulk, you can 
iterate over them until you run out, then kfree_bulk the rest.

(This idea came from a memory that bulk file operations can be 
made faster by sorting by inode number.)

P.S. if you want to fit one extra pointer in the array, an array index
identifying the first unused slot is distinguishable from a pointer,
so if the last slot is a pointer, the page is full.  If it's an index,
the page is not full.
