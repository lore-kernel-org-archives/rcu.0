Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1954CC4332F
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 13:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiKPNgb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 08:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiKPNga (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 08:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056846314
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 05:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9662261DEA
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 13:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B168C433C1;
        Wed, 16 Nov 2022 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668605789;
        bh=NoHq4g45NI/isVNA6ezawFs7UllNIU6g5Md1z8Od4gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBfhJw210DDxKsTR7kgRiPfwmBvW1IuzMUmuu/hQOsFsjnk9ItDx7al6PjDIqWqu/
         v/kdDu8mGNWdVlYNzOLjSmYLku0yAeI1pQUwqIMl+jCm6dgl2StNOegtv1Fp+ZMatL
         EnyShdCVKuGYOTBQJERAkrA6bUzq1E3KYlWgBKRDHy37mLmbfp1rv2k2jzoH6DMZD0
         OOk7uUs9ZPhgo4gkXOsQnejKVxypaa5JrPQbGWhgG5n6hyZWQVk+9eoePIsqeuCXPc
         2ubb7HBBOBC+e7L77uedQEXnsOqoFEfQ2gfcMtzeBXYfNblnfdys8WQ9oQBr7dp19R
         +BpK8pIlnjCEQ==
Date:   Wed, 16 Nov 2022 14:36:25 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] srcu: Fix a misspelling in note
Message-ID: <20221116133625.GB816333@lothringen>
References: <20221116015244.10539-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116015244.10539-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 16, 2022 at 09:52:43AM +0800, Pingfan Liu wrote:
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  include/linux/srcutree.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index e3014319d1ad..f52820e88018 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -48,7 +48,7 @@ struct srcu_data {
>  struct srcu_node {
>  	spinlock_t __private lock;
>  	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
> -						/*  if greater than ->srcu_gq_seq. */
> +						/*  if greater than ->srcu_gp_seq. */

Sharp eye ;-)

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
>  	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
>  	struct srcu_node *srcu_parent;		/* Next up in tree. */
> -- 
> 2.31.1
> 
