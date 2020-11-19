Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AB7C388F9
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DDB2222A
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 21:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLC/r4pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgKSVtf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 16:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSVtf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 16:49:35 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E76122202;
        Thu, 19 Nov 2020 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605822574;
        bh=lgAn2uZfXwrK3t1Xt8ZZpJYTlpWEe1luzKZWCEUopZE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GLC/r4pkO62o9TYS4mAQn84rKyToTW76TMYi3McpxIbrnaGEQ4IKCz/nrun7Ltbyq
         X49EHqajO2Q/mk7hEmzqQgfq5NotEJ/6SjOke+joQKPb1+9r+Hr+tfq0wJCLkzpfcX
         Se/tF0dB2vo+aGseHsVTidfdqEbYYXvpVbsicxZE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 18BE135225D3; Thu, 19 Nov 2020 13:49:34 -0800 (PST)
Date:   Thu, 19 Nov 2020 13:49:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, urezki@gmail.com
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
Message-ID: <20201119214934.GC1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118035309.19144-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Add kasan_record_aux_stack function for kvfree_call_rcu function to
> record call stacks.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Thank you, but this does not apply on the "dev" branch of the -rcu tree.
See file:///home/git/kernel.org/rcutodo.html for more info.

Adding others on CC who might have feedback on the general approach.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index da3414522285..a252b2f0208d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		success = true;
>  		goto unlock_return;
>  	}
> -
> +	kasan_record_aux_stack(ptr);
>  	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
>  	if (!success) {
>  		run_page_cache_worker(krcp);
> -- 
> 2.17.1
> 
