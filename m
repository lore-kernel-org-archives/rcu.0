Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26318C433F5
	for <rcu@archiver.kernel.org>; Sun, 26 Sep 2021 03:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56786108E
	for <rcu@archiver.kernel.org>; Sun, 26 Sep 2021 03:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhIZDwj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 25 Sep 2021 23:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhIZDwj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 25 Sep 2021 23:52:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5D0C60F0F;
        Sun, 26 Sep 2021 03:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632628263;
        bh=FZmJbiSSk10D/Dr/bil50/U/7DWmhUTxndLWBbt1Lrw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=gFq12P1rpX8G5ZoK6h3sp0zcdkK1kJNgN+Kos6lYnaIIk5cXRmFZbhm9Tq770hi6+
         hI55sH1ZB9byYh+kE7oTTBOtdcaVCst4A1o3bGLljJR5881X1ZHHCXaca14Qc2e9mS
         TngmcRmVGCP+5h9slyIn7m0bi/4ctcBS2TNJzN1/+bfDW01dX0wKn9sKRZItJoa9un
         zcisnePFtuWVY5ckCPB1AYw/AAjNOvnMHHVuRFZlQcVpSJoaLE0efv6cYW/OBf27Ex
         ZgzZQ2oqxo/05doCYDNx9YTRyH0TV2KcuH1g6GAeInRkXflVeIC2bgMt5s0H61PYSW
         ODsJzhFsJ3vJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7580E5C04EE; Sat, 25 Sep 2021 20:51:03 -0700 (PDT)
Date:   Sat, 25 Sep 2021 20:51:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     w@1wt.eu
Cc:     rcu@vger.kernel.org
Subject: Making races happen more often
Message-ID: <20210926035103.GA1953486@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Willy!

Continuing from linkedin:

> Maybe this doesn't work as well as expected because of the common L3 cache
> that runs at a single frequency and that imposes discrete timings. Also,
> I noticed that on modern CPUs, cache lines tend to "stick" at least a few
> cycles once they're in a cache, which helps the corresponding CPU chain
> a few atomic ops undisturbed. For example on a 8-core Ryzen I'm seeing a
> minimum of 8ns between two threads of the same core (L1 probably split in
> two halves), 25ns between two L2 and 60ns between the two halves (CCX)
> of the L3. This certainly makes it much harder to trigger concurrency
> issues. Well let's continue by e-mail, it's a real pain to type in this
> awful interface.

Indeed, I get best (worst?) results from memory latency on multi-socket
systems.  And these results were not subtle:

	https://paulmck.livejournal.com/62071.html

All that aside, any advice on portably and usefully getting 2-3x clock
frequency differences into testing would be quite welcome.

							Thanx, Paul
