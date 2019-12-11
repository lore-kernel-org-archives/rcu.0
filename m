Return-Path: <SRS0=CxAO=2B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF67C43603
	for <rcu@archiver.kernel.org>; Wed, 11 Dec 2019 03:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22C520838
	for <rcu@archiver.kernel.org>; Wed, 11 Dec 2019 03:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576036283;
	bh=eFzj21qYloauMwUtdCGqTFTX4luWwusPmqSOsOyh+MA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2mZEbpLpQ2eRdhXUR80qqxB8I9M3tBpGX/4pa9jO13PxzcaR0VkShAMRJzBYX8cIj
	 Sj1Xx5FzoRdp36iRro2aMKaPEuwQt2nZFtDJ0nVghsUdSFmGkwaXXVA6i6Pll2IW1v
	 lH/6/ImAS0Q+yJLltBCxprfA5eoCH5h9GHQJ3+YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLKDvX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfLKDvX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Dec 2019 22:51:23 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03C620836;
        Wed, 11 Dec 2019 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576036282;
        bh=eFzj21qYloauMwUtdCGqTFTX4luWwusPmqSOsOyh+MA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kj8YTiynoPvqVPGtD11yWfGHT3qlut5vNEgfozkqAZo1l9ZP/AfhmRA1YzcHtPd9u
         0WNKCcmHhY+hnJ4op/45/iKK1O7rgERiuAwa1joHTeJT4K6FDUbfoSStHSdg+cgG4d
         H2VytX4+E+ivZoHg3e43NuzMKPUsgFmo9irJQCrQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 58986352276C; Tue, 10 Dec 2019 19:51:22 -0800 (PST)
Date:   Tue, 10 Dec 2019 19:51:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>
Subject: Re: [PATCH tip/core/rcu 01/12] rcu: Remove rcu_swap_protected()
Message-ID: <20191211035122.GC2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
 <20191210040741.2943-1-paulmck@kernel.org>
 <yq1a77zmt4a.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a77zmt4a.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 10, 2019 at 10:35:49PM -0500, Martin K. Petersen wrote:
> 
> Paul,
> 
> > Now that the calls to rcu_swap_protected() have been replaced by
> > rcu_replace_pointer(), this commit removes rcu_swap_protected().
> 
> It appears there are two callers remaining in Linus' master. Otherwise
> looks good to me.

I did queue a fix for one of them, and thank you for calling my
attention to the new one.  This commit should hit -next soon, so
hopefully this will discourage further additions.  ;-)

> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Thank you!

							Thanx, Paul
