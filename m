Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9CC433EF
	for <rcu@archiver.kernel.org>; Tue, 22 Mar 2022 12:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiCVMcF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiCVMcE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Mar 2022 08:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB4874DE1;
        Tue, 22 Mar 2022 05:30:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B95E0614BA;
        Tue, 22 Mar 2022 12:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98175C340EC;
        Tue, 22 Mar 2022 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647952233;
        bh=8UgqJKeD83b+41XF6fMFtLi8TcWYbvRRK9SI91LW1cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDt4sQWbciCLej+F53LbxtOwznRDJXiHwX8xDrGNpy2FeqBhzp8RltICjsB7lpMK0
         A6OutEYTGQW/yjcxckDM2YlHZYdazmmJ3rqy983SP6XeE2waaFYRxa8UXg+TCcey2/
         xSBtMXlaoMT9O9jLcS3xkeO047HMcQkKfsnG4UGUqpgv+zkLII5mgzmZIoviFHCetJ
         qcX9Er/uH19nc36w9RrkmNwvyARkrBhsqUxhR+TPV2Aj9IYF7GS4fWo/T8dNiHqunh
         iyUPG3YGN3sR5MWZSZQEWBHWvCEE67cD1uBVrfIwYr1bQHVLBwpN3kGQnRfVQSWnMY
         JkHjcM1YR9kFg==
Date:   Tue, 22 Mar 2022 13:30:29 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rcu: Call rcu_nocb_rdp_deoffload() directly after
 rcuog/op kthreads spawn failed
Message-ID: <20220322123029.GC701946@lothringen>
References: <20220318080719.1501471-1-qiang1.zhang@intel.com>
 <20220318080719.1501471-2-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318080719.1501471-2-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 18, 2022 at 04:07:18PM +0800, Zqiang wrote:
> @@ -1009,10 +1015,33 @@ static long rcu_nocb_rdp_deoffload(void *arg)
>  	 */
>  	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
>  	invoke_rcu_core();
> -	ret = rdp_offload_toggle(rdp, false, flags);
> -	swait_event_exclusive(rdp->nocb_state_wq,
> -			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
> -							SEGCBLIST_KTHREAD_GP));
> +	wake_gp = rdp_offload_toggle(rdp, false, flags);
> +
> +	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> +	if (rdp_gp->nocb_gp_kthread) {
> +		if (wake_gp)
> +			wake_up_process(rdp_gp->nocb_gp_kthread);
> +
> +		if (rdp->nocb_cb_kthread) {
> +			condition = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP;
> +		} else {
> +			/*
> +			 *If rcuop kthread spawn failed, direct remove SEGCBLIST_KTHREAD_CB
> +			 *just wait SEGCBLIST_KTHREAD_GP to be cleared.
> +			 */
> +			condition = SEGCBLIST_KTHREAD_GP;
> +			rcu_segcblist_clear_flags(&rdp->cblist,
> SEGCBLIST_KTHREAD_CB);

You may be running concurrently againt nocb_gp_wait() ->
nocb_gp_update_state_deoffloading() -> rcu_segcblist_clear_flags(cblist,
SEGCBLIST_KTHREAD_GP)

So you need to protect the flags clear with rcu_nocb lock.




> +		}
> +		swait_event_exclusive(rdp->nocb_state_wq,
> +					!rcu_segcblist_test_flags(cblist, condition));
> +	} else {
> +		rcu_nocb_lock_irqsave(rdp, flags);
> +		rcu_segcblist_clear_flags(&rdp->cblist,
> +				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> +		rcu_nocb_unlock_irqrestore(rdp, flags);

Like you're doing here.

Thanks!
