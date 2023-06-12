Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1716BC7EE2E
	for <rcu@archiver.kernel.org>; Mon, 12 Jun 2023 21:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjFLV1b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbjFLV1A (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 17:27:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18364199C;
        Mon, 12 Jun 2023 14:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A341A6211C;
        Mon, 12 Jun 2023 21:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FBDC433EF;
        Mon, 12 Jun 2023 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605172;
        bh=2Naiw0Ihz2w9F8q346H/VjTQrsskkCS4eikc/f0I9Lk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Nhh2DReFNe8gftX3dFkp0bphGaKqFFjunC/y0q7qVm6Z/fhUdjn9/mpzTuE8F4SQi
         pTpXSF11uidAH3XXwdFJ0TqPGMccYO/bqU1WF3q88c5FhdjMexdpQUuKvJkFb28O7P
         G+rYKmw+2zMzJfbxYlznh7ViwbkJT7Em1rMstkqfsWMg8tQNpaYxUXa+ypw9Jh6Mdr
         vlqyH299ZF0LKOojVQYPsF6jG1b/9gzX7VVSgfk4gGhrnl7xtEFFkbwapkXFQ0Snba
         r8Abbcc72aO1t/nfccL5+zkMF+52oDpimpWTRD+PCe/v9CgirC8jhiZGxJRwlKEqAB
         91ZO6qcKA2XaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A705CE09E7; Mon, 12 Jun 2023 14:26:11 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:26:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/RCU: Add the missing rcu_read_unlock()
Message-ID: <1ca60542-5d9f-4e16-9b10-b4c79f495d03@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230610040608.6355-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610040608.6355-1-mmpgouride@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 10, 2023 at 04:06:08AM +0000, Alan Huang wrote:
> We should exit the RCU read-side critical section before re-entering.
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
>  Documentation/RCU/rculist_nulls.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> index 9a734bf54..4370ac864 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -30,6 +30,7 @@ algorithms:
>    obj = lockless_lookup(key);
>    if (obj) {
>      if (!try_get_ref(obj)) // might fail for free objects
> +      rcu_read_unlock();

Good eyes!  But don't we also need a pair of braces?

						Thanx, Paul

>        goto begin;
>      /*
>      * Because a writer could delete object, and a writer could
> -- 
> 2.34.1
> 
