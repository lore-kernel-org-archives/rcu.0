Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A3C433E0
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B91265086
	for <rcu@archiver.kernel.org>; Tue, 16 Mar 2021 14:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhCPOsB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236975AbhCPOrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Mar 2021 10:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5048565081;
        Tue, 16 Mar 2021 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615906044;
        bh=g9UVcTvuFGkk276bH2SawBy4olk3XdkrzRG3cge2yJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKBUHkIT3nBE1LTPQtI8b3CafNZjYO4AvCQX0gSYi+71+07ccpql45MoT9NIOHHHN
         W6Qi+PImb/OHsd13S6878V1LO20wAh1tkh1rar/pZ/LGuQicq4iSu2MhjIzNXcnYKw
         +IIUXrXTsHvwAXaQaZJZtoS9WNLUHtkXh2Mjp8u1pqq8Fs6ykWhzNSCaWu7bTMBRTR
         BFF8ULiIj8Dr4vNY1oI+GBhG7OILAfmZBGsi+/FEq9uFYumD7pWyVjg2godFjZ1yey
         264t8bBsg2DN5elaBNkzNbsck7LTPEMc+123cVX+0gbnxf0olBuIxvE0ofYH5kzGSw
         X1dqwcD0MqTaA==
Date:   Tue, 16 Mar 2021 15:47:22 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for
 Tree RCU grace periods
Message-ID: <20210316144722.GD639918@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304002632.23870-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 03, 2021 at 04:26:30PM -0800, paulmck@kernel.org wrote:
> +/**
> + * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
> + *
> + * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
> + *
> + * If a full RCU grace period has elapsed since the earlier call from
> + * which oldstate was obtained, return @true, otherwise return @false.
> + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
> + *
> + * Yes, this function does not take counter wrap into account.
> + * But counter wrap is harmless.  If the counter wraps, we have waited for
> + * more than 2 billion grace periods (and way more on a 64-bit system!).
> + * Those needing to keep oldstate values for very long time periods
> + * (many hours even on 32-bit systems) should check them occasionally
> + * and either refresh them or set a flag indicating that the grace period
> + * has completed.
> + */
> +bool poll_state_synchronize_rcu(unsigned long oldstate)
> +{
> +	if (rcu_seq_done(&rcu_state.gp_seq, oldstate)) {
> +		smp_mb(); /* Ensure GP ends before subsequent accesses. */
> +		return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
> +
> +/**
>   * cond_synchronize_rcu - Conditionally wait for an RCU grace period
>   *
>   * @oldstate: return value from earlier call to get_state_synchronize_rcu()
>   *
>   * If a full RCU grace period has elapsed since the earlier call to
> - * get_state_synchronize_rcu(), just return.  Otherwise, invoke
> - * synchronize_rcu() to wait for a full grace period.
> + * get_state_synchronize_rcu() or start_poll_synchronize_rcu(), just return.
> + * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
>   *
>   * Yes, this function does not take counter wrap into account.  But
>   * counter wrap is harmless.  If the counter wraps, we have waited for
> @@ -3804,7 +3864,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
>   */
>  void cond_synchronize_rcu(unsigned long oldstate)
>  {
> -	if (!rcu_seq_done(&rcu_state.gp_seq, oldstate))
> +	if (!poll_state_synchronize_rcu(oldstate))
>  		synchronize_rcu();
>  	else
>  		smp_mb(); /* Ensure GP ends before subsequent accesses. */

poll_state_synchronize_rcu() already does the full barrier.

> -- 
> 2.9.5
> 
