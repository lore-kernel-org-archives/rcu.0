Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E6C7EE2F
	for <rcu@archiver.kernel.org>; Tue, 13 Jun 2023 03:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjFMDSG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 23:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbjFMDRe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 23:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D0184;
        Mon, 12 Jun 2023 20:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93B062A2D;
        Tue, 13 Jun 2023 03:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDA4C433D2;
        Tue, 13 Jun 2023 03:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686626214;
        bh=574MtmQBYF5Z2cqxJjhyhpDH313XmH785GV0HQJvXlM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dH7ZfpG6qhgomBac3YRIZDI5oK3J03ePzbhyac2LeBW5czAZ3JJ8uH32srqPyoL4N
         qdEdlhGUEcrFa2pEjt2Jjk+DDPTV0cbv0bE5gHszB9OuuXjP4Tv5gcOVdYGW5oajN6
         9Se8UB90brrmIdKD3SYCBlxar4+CU+ttSKkUbSobSs5NLU/wZnSG3F9iXWtJMQkjvA
         IerpMxCbugjAa+J5AhyaHMN0puJdTrbfk/HOw6NUjB9eRsPFf100sRwJMIW+6Srixi
         pnwFDXGLnDnOPkodJ4eAkX2EM2LHAaoGS1wphirCOt+6u6Wf+eriOQwwneGgtoiGOU
         vLdYJyXq1JYZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5F79CE09E7; Mon, 12 Jun 2023 20:16:53 -0700 (PDT)
Date:   Mon, 12 Jun 2023 20:16:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/RCU: Add the missing rcu_read_unlock()
Message-ID: <b384fa57-a760-40c5-a07b-faf166817772@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230613005701.8728-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613005701.8728-1-mmpgouride@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 13, 2023 at 12:57:01AM +0000, Alan Huang wrote:
> We should exit the RCU read-side critical section before re-entering.
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/rculist_nulls.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> index 9a734bf54..0612a6387 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -29,8 +29,10 @@ algorithms:
>    rcu_read_lock()
>    obj = lockless_lookup(key);
>    if (obj) {
> -    if (!try_get_ref(obj)) // might fail for free objects
> +    if (!try_get_ref(obj)) { // might fail for free objects
> +      rcu_read_unlock();
>        goto begin;
> +    }
>      /*
>      * Because a writer could delete object, and a writer could
>      * reuse these object before the RCU grace period, we
> -- 
> 2.34.1
> 
