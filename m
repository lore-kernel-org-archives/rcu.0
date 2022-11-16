Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C9C4332F
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 13:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiKPNen (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKPNem (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 08:34:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179CF62D6
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 05:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7BE561DF3
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 13:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C7C433D6;
        Wed, 16 Nov 2022 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668605681;
        bh=vD58OhzEiAcnymtDDc3nrxk5GSCoFgOdkF76I3xjgmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCJhu9vKmF7jw84aPBrl0SnvpNitS7lSLUvCQwciPenvK1rOkPZqdXvf1/SaX6wWH
         Cpg5KoWYmEMAX5y7ieO9JkGzF6fT9zVrQGMIgKMOufi9CwRVqd615u0cfIRTz+Ope3
         xOWpgLvnt1nE9w7+/OixSBU1kucihMrS4PqBb/N34v8BMwlsvLBsrGB5SKYfQKwTK8
         FtFIqpNS9jpJJFrfD63b+FUYAZJZM1VSj3AtXOXZ4BTW6Le18vixn0ZDfLbPGCE7jY
         +IYEsdlbBo52l8p1730N/sjmWVumwvL/uVMTHimhYdPu3f/o/9KK/RXmlWdlPsenDw
         3niZ+8+z5ig+Q==
Date:   Wed, 16 Nov 2022 14:34:37 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] srcu: Fix the comparision in srcu_invl_snp_seq()
Message-ID: <20221116133437.GA816333@lothringen>
References: <20221116015244.10539-1-kernelfans@gmail.com>
 <20221116015244.10539-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116015244.10539-2-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 16, 2022 at 09:52:44AM +0800, Pingfan Liu wrote:
> A seq contains two fields: counter and state.
> 
> SRCU_SNP_INIT_SEQ is used as invalid initial value for srcu_node GP
> sequence numbers. Hence srcu_invl_snp_seq() should compare both fields
> of a seq.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: rcu@vger.kernel.org
> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 1c304fec89c0..725c82bb0a6a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -154,7 +154,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
>   */
>  static inline bool srcu_invl_snp_seq(unsigned long s)
>  {
> -	return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
> +	return s == SRCU_SNP_INIT_SEQ;

Doesn't hurt and makes it less confusing as it doesn't suggest anymore
there _might_ be a gp number behind.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


>  }
>  
>  /*
> -- 
> 2.31.1
> 
