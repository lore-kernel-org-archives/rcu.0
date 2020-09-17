Return-Path: <SRS0=GKHO=C2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC844C433E2
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC642064B
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600361921;
	bh=NUy17Wp9AvMVlvP9VNsHeGbqpNFRkHeKJDWptL5/lrE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ADK1d0cSAiaafZPf1iVbAKu/N7qBdsisk4w1RxhY9H8CyLfu034C8TRUisqjM42BR
	 2kIeG1+PTHqY/z45TAU1mLsqgX2XxKQR0hD/7Ol+yg3xGOg7zbb7EToyYQaTUqUCMA
	 qqE0z2hy8HYoTumP0mc4IxIrjKcyPYd1uoIxS7Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgIQQ6Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Sep 2020 12:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbgIQQ6S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Sep 2020 12:58:18 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1A4206A4;
        Thu, 17 Sep 2020 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600361898;
        bh=NUy17Wp9AvMVlvP9VNsHeGbqpNFRkHeKJDWptL5/lrE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xF2R6RMc1vzJUadr+hUQyZjdO9B40AKvv6SePne9Wkj/G9gGKnY5KNJvRE54NgoPc
         JVsMA1WTn26sjfyxI3f96nNbdldTIprcr9dCLLk+blJiGDjgmx6N0KBTtUyHW4uj1a
         JhVwFXjHbX+4DkRh8WBDn4HjeAKsQ29FwACmmMDQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EED3335225FA; Thu, 17 Sep 2020 09:58:17 -0700 (PDT)
Date:   Thu, 17 Sep 2020 09:58:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] locktorture: doesn't check nreaders_stress when no
 readlock support
Message-ID: <20200917165817.GK29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200917135910.137389-1-houtao1@huawei.com>
 <20200917135910.137389-2-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917135910.137389-2-houtao1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 17, 2020 at 09:59:09PM +0800, Hou Tao wrote:
> To ensure there is always at least one locking thread.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/locking/locktorture.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 9cfa5e89cff7f..bebdf98e6cd78 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -868,7 +868,8 @@ static int __init lock_torture_init(void)
>  		goto unwind;
>  	}
>  
> -	if (nwriters_stress == 0 && nreaders_stress == 0) {
> +	if (nwriters_stress == 0 &&
> +	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {

You lost me on this one.  How does it help to allow tests with zero
writers on exclusive locks?  Or am I missing something subtle here?

							Thanx, Paul

>  		pr_alert("lock-torture: must run at least one locking thread\n");
>  		firsterr = -EINVAL;
>  		goto unwind;
> -- 
> 2.25.0.4.g0ad7144999
> 
