Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D110DC433F5
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 00:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358383AbiEMAML (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 20:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358319AbiEMAMK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 20:12:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B351552B23
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 17:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D5E2B82BD1
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 00:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A12BC385B8;
        Fri, 13 May 2022 00:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652400727;
        bh=jLh42iOli+Kip+cC19o4uyL6RBV8cFklx9AnOZfMsD8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eSDXOOSgGZeJRmYYJ6lPlpqLVHbTkUZG2ZSg6QHt0kePHrMNnK5uf7m3TvM3CSsuu
         UQW5FokjETc1VWSRWWZjw0t6UxUdBx64ghmMK6cOjMdrmgTRaAWWJhOAYltt/kCagt
         oJ9IYnyKiCqsnTsrCN87/yKTiXw13Ek6QgNWgEXT2uOpZGDGGdx/Ta/+EcHtnNuCaD
         5sYj/5XJz6E8OBwXkHJoUm3Yfz617nzEoVUrCMU0YVdG2F3V3OvOaODSPdQOF+xrgJ
         7EuyzMG+HMTt9ua6FQk+tFOIe3l5Mui7XSIU4SaMMbEjRmqxyk2bLul6Rtjg1juk1P
         jRpz83aL8sn/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B6AA35C051B; Thu, 12 May 2022 17:12:06 -0700 (PDT)
Date:   Thu, 12 May 2022 17:12:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 10/14] kfree/rcu: Queue RCU work via
 queue_rcu_work_lazy()
Message-ID: <20220513001206.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-11-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-11-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:38AM +0000, Joel Fernandes (Google) wrote:
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Again, given that kfree_rcu() is doing its own laziness, is this really
helping?  If so, would it instead make sense to adjust the kfree_rcu()
timeouts?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ebdf6f7c9023..3baf29014f86 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3407,7 +3407,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queue_rcu_work_lazy(system_wq, &krwp->rcu_work);
>  		}
>  	}
>  
> -- 
> 2.36.0.550.gb090851708-goog
> 
