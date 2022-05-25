Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF9C433EF
	for <rcu@archiver.kernel.org>; Wed, 25 May 2022 22:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbiEYWTY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 May 2022 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbiEYWTV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 May 2022 18:19:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119D674F2;
        Wed, 25 May 2022 15:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB1D60B2E;
        Wed, 25 May 2022 22:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C5FC385B8;
        Wed, 25 May 2022 22:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653517160;
        bh=dDu5LbOPsRS0RP77g6kjOPiBSKhhet1MBKntZN88yzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XsdD6BF6uI4o1xvv7lA0zOO7yvS08dWbqSTLCJzhbrw84rLtJp5VFTPfzPT5weGXj
         83d8YB1AqzugdroVvSOgYVr8pA2eZu5QBrcWIuro9Q24MPmvwOAZjEOhi5rMd6XLDZ
         MHMFkNqxCFGRYfhIIH+ept62P647AQPbvCkpEsJo58f8hj1dHNQba39swZ8NNEg4Fx
         H0D5IOSUsoUF6lZ3kBg7dii0pcZVFV80LNk81j5Ck8q4bjFfB8lxVA78M3U5o1xGWv
         Xr97cIV1PwxDCiwYOS2WxexBi4DGxtA4wsEQkBH6T8mYvYfzINowO8tLjuMEHMKpiY
         h0+mInifhzO0Q==
Date:   Thu, 26 May 2022 00:19:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 1/4] rcu/nocb: Pass a cpumask instead of a single CPU to
 offload/deoffload
Message-ID: <20220525221917.GA1151462@lothringen>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525221055.1152307-2-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 26, 2022 at 12:10:52AM +0200, Frederic Weisbecker wrote:
> @@ -1117,12 +1111,6 @@ static long rcu_nocb_rdp_offload(void *arg)
>  	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>  
>  	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> -	/*
> -	 * For now we only support re-offload, ie: the rdp must have been
> -	 * offloaded on boot first.
> -	 */
> -	if (!rdp->nocb_gp_rdp)
> -		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
>  		return -EINVAL;

And why did I remove this critical check? I have no answer...
