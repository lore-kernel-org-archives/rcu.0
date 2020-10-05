Return-Path: <SRS0=BSCp=DM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F3DC4363A
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D835207F7
	for <rcu@archiver.kernel.org>; Mon,  5 Oct 2020 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Bmw2n+ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgJEOiK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Oct 2020 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgJEOiJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Oct 2020 10:38:09 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B71C0613CE
        for <rcu@vger.kernel.org>; Mon,  5 Oct 2020 07:38:09 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o21so9725497qtp.2
        for <rcu@vger.kernel.org>; Mon, 05 Oct 2020 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jGjcwRAoiqcduLL2bxQ4mHoOvaw+GK5le8AMRCfmziw=;
        b=Bmw2n+ZEzJQaKE0lF5o7u1Lny3AaHHJ1s/MBbnlqcsehpjY15tpnjoS32mD482jU+8
         GqOGgIv5kVYk/89W/E4oaUfgOT7R1AxCmW1IB36WtIvZxuHdbUwphs4F5otG5l4NMVKh
         ctvXvL01VhWc29V2l6tVKaiiczQVgnQWDQ4Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGjcwRAoiqcduLL2bxQ4mHoOvaw+GK5le8AMRCfmziw=;
        b=RLD2Zi5u04TYdq0RIMkTLojGR6DfKGOiKy9wWVDCtC7H2LV8/QcaSlfIj1i4RTSoDb
         3gqgf3oPifh8Otxf99YALaT/wEkfAaAXT/kYFQu4OAJVZ4WnGWcLe77OsvwEaezsqilp
         vG7CUWCs3V1iNetWw+VFjFqxLIrx0gK2Gc6Pq58N4Mg/Hcf+kpwgQQmXFd1yDW7uJbaN
         oNwTCloA7JlqQK1A7tqpXRJp52awYm2P2OR1vWBKGrp1K0H5ixkBa2qCAYIMshrKcmrn
         A+QX2ZGF5scfY1R+Q/4YxO8jaDyACoCxEQxwR/g37Cq0XtCb7IzPIaK6J6AzXgOqYHE4
         P2Qg==
X-Gm-Message-State: AOAM530T+hdB2FO0ivum0ibX3ay00UhA9rS3lLxCKxljcaFjOQxnDeTr
        MSbQoBbXkCYINwYIrvK4jMHOMg==
X-Google-Smtp-Source: ABdhPJwlsLhBT0dRBWHT+f4KE7q+zVHQeWZVqYsZai7MVOu1pu+fWrvddx8Y+xXI+Z25jCQFeGPMDw==
X-Received: by 2002:ac8:5d0d:: with SMTP id f13mr117396qtx.87.1601908688715;
        Mon, 05 Oct 2020 07:38:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n7sm463339qtp.93.2020.10.05.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:38:08 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:38:07 -0400
From:   joel@joelfernandes.org
To:     linux-kernel@vger.kernel.org
Cc:     neeraju@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are
 ready to execute CBs
Message-ID: <20201005143807.GA524504@google.com>
References: <20201005021132.146534-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005021132.146534-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 04, 2020 at 10:11:32PM -0400, Joel Fernandes (Google) wrote:
> During testing, I see it is possible that rcu_pending() returns 1 when
> offloaded callbacks are ready to execute thus raising the RCU softirq.
> 
> However, softirq does not execute offloaded callbacks. They are executed in a
> kthread which is awakened independent of the softirq.
> 
> This commit therefore avoids raising the softirq in the first place. That's
> probably a good thing considering that the purpose of callback offloading is to
> reduce softirq activity.
> 
> Passed 30 minute tests of TREE01 through TREE09 each.
> 
> On TREE08, I notice that there is atmost 150us from when the softirq was
> NOT raised when ready cbs were present, to when the ready callbacks were
> invoked by the rcuop thread. This also further confirms that there is no
> need to raise the softirq for ready cbs in the first place.

Hi Paul,
You had asked me about whether removing this softirq invocation indirectly
slows down grace period progression.

This morning, I ran rcutorture.fwd_progress on TREE08 and I don't see any
difference in number of grace periods with/without this patch. Just want to
let you know.

Thanks,

 - Joel

> 
> Cc: neeraju@codeaurora.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
> 
> v1->v2: Also cleaned up another test of the nocb configuration macro.
> 
>  kernel/rcu/tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f78ee759af9c..2b1e1b21db92 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3652,13 +3652,13 @@ static int rcu_pending(int user)
>  		return 1;
>  
>  	/* Does this CPU have callbacks ready to invoke? */
> -	if (rcu_segcblist_ready_cbs(&rdp->cblist))
> +	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
> +	    rcu_segcblist_ready_cbs(&rdp->cblist))
>  		return 1;
>  
>  	/* Has RCU gone idle with this CPU needing another grace period? */
>  	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
> -	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
> -	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
> +	    (!rcu_segcblist_is_offloaded(&rdp->cblist)) &&
>  	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>  		return 1;
>  
> -- 
> 2.28.0.806.g8561365e88-goog
