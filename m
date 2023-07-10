Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B91EB64DC
	for <rcu@archiver.kernel.org>; Mon, 10 Jul 2023 19:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGJTK3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjGJTKO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Jul 2023 15:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67E2722;
        Mon, 10 Jul 2023 12:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C595D611AE;
        Mon, 10 Jul 2023 19:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B0DC433CA;
        Mon, 10 Jul 2023 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689016119;
        bh=Frt1mjerTXPRvhoyvZG7BYM7UCWVRKdMNPk0daCzDA8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FtzMy+sQXOoaWAPrsWsID8EYpChRMy6e7Zikyx4aqJrS1XxJi55L6T6khKhKE3Wbz
         gRiopAk1JilRJjFT7E2w2F4EBOcwAfk00QrCmgn7KStM5XPp79+/C9bzKBIYxW0qeB
         W3aGiInMmSzxb7EmEZ/pSKM89DEzuzy8wdZqI+TDmIshD5RJTlbcAM3yXqlg9A/XT7
         YjnQbW1M7/FhhZRqw1RmB6eQ7asb44oq1j6RekBEopJCfar44fmGnIbTe1y94KW0CO
         XlJFcpR7gGJpm5yxBPowoEVfAjWRptZTWT2nkNSI26SC0JttB9XPehrL7gh/YJX7xC
         0PvqcTb65d83A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B409ECE00C6; Mon, 10 Jul 2023 12:08:38 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:08:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu: Use WRITE_ONCE() for assignments to ->next for
 rculist_nulls
Message-ID: <fd65010f-13bf-4bbe-95da-88097459ab7c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230706102849.437687-1-mmpgouride@gmail.com>
 <20230706102849.437687-2-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706102849.437687-2-mmpgouride@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 06, 2023 at 10:28:48AM +0000, Alan Huang wrote:
> When the objects managed by rculist_nulls are allocated with
> SLAB_TYPESAFE_BY_RCU, readers may still hold references to this
> object that is being added, which means the modification of ->next
> is visible to readers. So, this patch uses WRITE_ONCE() for assignments
> to ->next.
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>

Very good, queued for the v6.6 merge window, thank you!

							Thanx, Paul

> ---
>  include/linux/rculist_nulls.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index ba4c00dd8005..89186c499dd4 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>  {
>  	struct hlist_nulls_node *first = h->first;
>  
> -	n->next = first;
> +	WRITE_ONCE(n->next, first);
>  	WRITE_ONCE(n->pprev, &h->first);
>  	rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
>  	if (!is_a_nulls(first))
> @@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>  		last = i;
>  
>  	if (last) {
> -		n->next = last->next;
> +		WRITE_ONCE(n->next, last->next);
>  		n->pprev = &last->next;
>  		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>  	} else {
> -- 
> 2.34.1
> 
