Return-Path: <SRS0=jzWG=WP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDE9C3A5A0
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 16:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69DE22CE9
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566233835;
	bh=PIPf/GTYR/xzw/v6Qsuh4LmYPERtKbYQDP+oauvwTWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gc9A4JAo66FqX1T+28+5lr8pFERrLPFrnWbzdbDumFRUsz96q/Dxeuwke1sv+bLQo
	 WyM5T6xv/+eoAXz+eeoyiynduNXRzyDLdIW07P7Fk3OxFVnDeL3hT8D2jzUPMboCYF
	 K3dV64nQV0Z8AUTAGy4k9idZxux6pUWPTubrXO9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfHSQ5P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSQ5O (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Aug 2019 12:57:14 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3DCC22CE9;
        Mon, 19 Aug 2019 16:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566233833;
        bh=PIPf/GTYR/xzw/v6Qsuh4LmYPERtKbYQDP+oauvwTWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItoB/gE1ytnOgOBoK5Rav5Lbiz4b7KVa2hfYBltM9yO8gzGwxRYLsLPyfdAwDTE/5
         GsL/0JShegzgi3cjUrckxtqQkQdBRD2qawloTGcTM0r4hZis+FVKmkTHecKP+UXsSa
         YWAo/+BS9VLrgFNWzUuLJYMFXzG/C4BIQGo5vF7E=
Date:   Mon, 19 Aug 2019 18:57:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190819165710.GF27088@lenoir>
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
 <20190815200432.GB23194@google.com>
 <20190815203107.GL28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815203107.GL28441@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 01:31:07PM -0700, Paul E. McKenney wrote:
> On Thu, Aug 15, 2019 at 04:04:32PM -0400, Joel Fernandes wrote:
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index be9707f68024..e697c7a2ce67 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -198,6 +198,10 @@ static bool check_tick_dependency(atomic_t *dep)
> >  		return true;
> >  	}
> >  
> > +	if (val & TICK_DEP_MASK_CLOCK_RCU) {
> > +		return true;
> > +	}
> > +
> >  	return false;
> >  }
> 
> That one is not in my tree, either.  Frederic, should I add this to
> your patch?  For that matter, may I add your Signed-off-by as well?
> Your original is in my -rcu tree at:
> 
> 0cb41806c799 ("EXP nohz: Add TICK_DEP_BIT_RCU")
> 
> I am testing Joel's suggested addition now.

Also this:

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index b7a904825e7d..295517f109d7 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -367,7 +367,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(POSIX_TIMER)		\
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
-		tick_dep_name_end(CLOCK_UNSTABLE)
+		tick_dep_name(CLOCK_UNSTABLE)		\
+		tick_dep_name_end(RCU)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name

