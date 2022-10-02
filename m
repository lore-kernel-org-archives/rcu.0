Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F1C433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 22:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJBWG0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJBWGX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 18:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684F38466;
        Sun,  2 Oct 2022 15:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CAAC60F47;
        Sun,  2 Oct 2022 22:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B7C433C1;
        Sun,  2 Oct 2022 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664748382;
        bh=wXUd7oD2wwFF5Nc5DPKRioov7rX3zFcL+zm8+XvghPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rgd9THDeQ1HTpRbGSYDCRsKbciX5+wG4NjQtNvJDZ5RVbzjpuK1s4C9YcB0OwF559
         S3JPzGGC7O+QTa8pzjEQDzDZt27MUMaf6j3+tFCeQBUBPoRXC/f9OU6qJSuEociYRM
         mwMUEFT1UFtsmTjGUFCPirn5U5G+FBGmspLgDtK8dn8NvA38Vm4xMytgaBlumawRDE
         59N5QM1tqClZycK2CnfuzfB5twwqLmFximqmwHX7C8OpTCP3djPhO34qaPMDSupsJt
         kUt+aHhzJW6GVytKiKeGsC75/nl8ZOH1QPXBPVPPdC3JnXu6oL2a91JvApEx1fuin+
         gtIdcwAQ2V3xA==
Date:   Mon, 3 Oct 2022 00:06:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 3/8] srcu: Check for consistent per-CPU
 per-srcu_struct NMI safety
Message-ID: <20221002220619.GA298433@lothringen>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929180731.2875722-3-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 29, 2022 at 11:07:26AM -0700, Paul E. McKenney wrote:
> This commit adds runtime checks to verify that a given srcu_struct uses
> consistent NMI-safe (or not) read-side primitives on a per-CPU basis.
> 
> Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/srcu.h     |  4 ++--
>  include/linux/srcutiny.h |  4 ++--
>  include/linux/srcutree.h |  9 +++++++--
>  kernel/rcu/srcutree.c    | 38 ++++++++++++++++++++++++++++++++------
>  4 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 2cc8321c0c86..565f60d57484 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -180,7 +180,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
>  	int retval;
>  
>  	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> -		retval = __srcu_read_lock_nmisafe(ssp);
> +		retval = __srcu_read_lock_nmisafe(ssp, true);
>  	else
>  		retval = __srcu_read_lock(ssp);

Shouldn't it be checked also when CONFIG_NEED_SRCU_NMI_SAFE=n ?

Thanks.
