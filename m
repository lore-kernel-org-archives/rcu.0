Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D14C433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 15:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D19B2072E
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 15:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FPBrUaqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbgFWPmR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733007AbgFWPmQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Jun 2020 11:42:16 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CC1C061573
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2020 08:42:16 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv17so9827250qvb.13
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2020 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k9npaZkB/RX+A77Mjxy8tZOLesXDgVyirFfZLx7RsY8=;
        b=FPBrUaqD+INXJNZq97GAZ8wt0va9XMksIvOQgUMsCLh5PhfHnsz+Efu5Na78VXWJDy
         1XGzChK2G0CNZjY7N2MBk7hQmzSCtWqq7r6C/3RhPhMC7Ezb5WuUmKtWAZG5o1xssGYG
         JfuM2ZMrklYBBVcoZO2EY1qioMp/UBzxm+s4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k9npaZkB/RX+A77Mjxy8tZOLesXDgVyirFfZLx7RsY8=;
        b=JHrYbKqAb7Q11xCq7cWo4j8RlXfBGGMq01me1Bu9BBDBe6maz1CnB5LXnwUSq1IWMO
         7Mo4lTDLqrq71LhXbLs7OB+zG3IY4L1K+528Mx1lmjQVacfLXYn/n59kCX4ci4AJ+e7D
         HbzVYjoQB8t+UrwduNZI77icJ4+5AQUtb/GHglVQqU75Vp4cvIIh2N2+Zx16fAEhnzW9
         n3nyGBSckWi33LMnNos69N5qk788chTnAA135vrAw4PLjKx7zuPcAo7IFUxcogzpL6av
         XB0S3SwdLP9FwNnUCbYKwyDAbxy229FIsPg1kaR33qGykRMmGlWqoY8AR387/laa0IvN
         d4Mw==
X-Gm-Message-State: AOAM533ZZlFnlzakgYPpl3/pTN5T3Z/yxULVWSBW8bvPoLYTC0yUmiVs
        PnLDvqAMiv064t6s0s/gccPi0A==
X-Google-Smtp-Source: ABdhPJzCnBPX85hWbeFdqNNPtt+wSv9RuuKhMXclYBSr+NMQYCtrb2esRWUO8PeTG4ifuFQWlIHL7g==
X-Received: by 2002:ad4:4f23:: with SMTP id fc3mr27529525qvb.25.1592926935691;
        Tue, 23 Jun 2020 08:42:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g4sm843079qka.97.2020.06.23.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:42:14 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:42:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
Message-ID: <20200623154214.GE9005@google.com>
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
> On callback overload, we want to force quiescent state immediately,
> for the first and second fqs. Enforce the same, by including
> RCU_GP_FLAG_OVLD flag, in fqsstart check.
> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And I think needs fixes tag:
Fixes: 1fca4d12f4637 ("rcu: Expedite first two FQS scans under callback-overload conditions")

thanks,

 - Joel


>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d0988a1..6226bfb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
>  			break;
>  		/* If time for quiescent-state forcing, do it. */
>  		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> -		    (gf & RCU_GP_FLAG_FQS)) {
> +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
>  			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>  					       TPS("fqsstart"));
>  			rcu_gp_fqs(first_gp_fqs);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
