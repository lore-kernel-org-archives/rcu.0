Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85BC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCD820780
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 16:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592929780;
	bh=mbaaoMZTzav02bOHei4uXB3XoJg3Dnr+E13AuHoDQBI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=uXH12fW7t+gvzf3HEd4lPqraGaOeHtq88QkNbFHhRh5m+eDTNwMWiwdaV/+FspQvk
	 KPlIIkOeJFillj2TM+RFjeKtBAZ5NreltJC0YZFviUbGm6IiYZXKJsAHEP0AqcqDzA
	 qbGQqA2E/fDlWF5/BLTQys2llVlMo9v9/uok3nYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgFWQ3k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732236AbgFWQ3k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Jun 2020 12:29:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83F6206D4;
        Tue, 23 Jun 2020 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592929779;
        bh=mbaaoMZTzav02bOHei4uXB3XoJg3Dnr+E13AuHoDQBI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kfCT6QLVgEmqi31KGs2QpUAdI0azvG9avr9O61z25PZoaWFLv2NTb1IZClCTaucRM
         /g1iABIs3YDnimuiPOboaMNjRSJBugszB0c50d8lUMqfi1gQHbZ9aEaqIe11kAMo4F
         2RFW/skFBcIU3Mhm9Il/eDXlvaf43S5n/XdjlZtA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8BFB03522657; Tue, 23 Jun 2020 09:29:39 -0700 (PDT)
Date:   Tue, 23 Jun 2020 09:29:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
Message-ID: <20200623162939.GJ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
 <20200623154214.GE9005@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623154214.GE9005@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 23, 2020 at 11:42:14AM -0400, Joel Fernandes wrote:
> On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
> > On callback overload, we want to force quiescent state immediately,
> > for the first and second fqs. Enforce the same, by including
> > RCU_GP_FLAG_OVLD flag, in fqsstart check.
> > 
> > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > ---
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> And I think needs fixes tag:
> Fixes: 1fca4d12f4637 ("rcu: Expedite first two FQS scans under callback-overload conditions")

Excellent, both applied, thank you!

					Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d0988a1..6226bfb 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
> >  			break;
> >  		/* If time for quiescent-state forcing, do it. */
> >  		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> > -		    (gf & RCU_GP_FLAG_FQS)) {
> > +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
> >  			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> >  					       TPS("fqsstart"));
> >  			rcu_gp_fqs(first_gp_fqs);
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> > 
