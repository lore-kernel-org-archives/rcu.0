Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD7AEE14B9
	for <rcu@archiver.kernel.org>; Wed,  6 Sep 2023 17:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjIFRV5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjIFRV5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Sep 2023 13:21:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B99199F
        for <rcu@vger.kernel.org>; Wed,  6 Sep 2023 10:21:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D0C433C7;
        Wed,  6 Sep 2023 17:21:52 +0000 (UTC)
Date:   Wed, 6 Sep 2023 18:21:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christoph Paasch <cpaasch@apple.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <ZPi1LvrcGcSKBLqR@arm.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EDE8FE3D-043D-4A14-ACF6-71FF786C0D32@apple.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 05, 2023 at 02:22:13PM -0700, Christoph Paasch wrote:
> On Sep 4, 2023, at 2:22 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Not sure which RCU variant you are using but most likely the false
> > positives are caused by the original reference to the object being lost
> > and the pointer added to a new location that kmemleak does not track
> > (e.g. bnode->records[] in the tree-based variant).
> > 
> > A quick attempt (untested, not even compiled):
> 
> I tried out your patch. It does resolve the false positive !
> 
> However, I am occasionally getting a report of a single object being
> leaked. When I try to visualize it with `cat
> /sys/kernel/debug/kmemleak`, the object does not show up anymore…

How often do you trigger the scanning? Since kmemleak does not stop the
world (as some garbage collectors do), there's potential for false
positives (e.g. a reference to it is in a register on some CPU while
being moved from one list to another). The heuristics employed for this
is to checksum the object and only report if the checksum has not
changed in successive scans. But this is still problematic if scanning
is done quickly in succession. The default 10min scanning (even 1min)
shouldn't be an issue.

I had a plan to do a "stop_scan" option (using stop_machine) but never
got the time to do this.

> If you have an updated patch, let me know. I can test it.

I sent it in reply to Joel.

Thanks.

-- 
Catalin
