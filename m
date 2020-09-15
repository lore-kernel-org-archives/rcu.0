Return-Path: <SRS0=zZsG=CY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE286C43461
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EAA20732
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600195043;
	bh=8Bkz/AaoLuYq/JpMcx55TXM/Y/n9rpfhHksMXOG/X/k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Cwc2/xBtm8vrEFNKr8+KmepZR5lvgRWYPrHYkQTnjuWCUkCl4iqGsbjREqwo2T1h7
	 gHEBdpZLVXPaY7OSrscYH/LQCSbPaiGRee4We5y9XMCGfDpJvGWSHW57rUE+hlZlnp
	 0ureLw6CrufRyRojUS9NZxpSOqLa/RL94ZtvEFgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgIOShV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbgIOSHC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Sep 2020 14:07:02 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DEA20738;
        Tue, 15 Sep 2020 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600193174;
        bh=8Bkz/AaoLuYq/JpMcx55TXM/Y/n9rpfhHksMXOG/X/k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VzH21k8tWsnMRpcWFzTngBmcAX87k4b5rRKcDvUNx9Csbri5WH2TKN3PhpZ7VLLEu
         zLzEmxTr6CPzedJhRuwC2/eimadj9ycQi9x0ONmLOu6TazjI+RDOh2w4ggIyLxx3k/
         6MApWg/vAPsmLwxSf8HnJgdDkd8zNU0wX0ISXWVk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D2C133522718; Tue, 15 Sep 2020 11:06:13 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:06:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang,Qiang" <qiang.zhang@windriver.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= RCU: Question on
 force_qs_rnp
Message-ID: <20200915180613.GQ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200914194208.GA2579423@google.com>
 <20200914205642.GE29330@paulmck-ThinkPad-P72>
 <BYAPR11MB263207BFF3AFB6A9D1A7A32FFF200@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200915034139.GK29330@paulmck-ThinkPad-P72>
 <1079509d-c474-42bd-44e9-18cfa948fbae@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1079509d-c474-42bd-44e9-18cfa948fbae@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 15, 2020 at 01:16:39PM +0800, Zhang,Qiang wrote:
> 
> 
> On 9/15/20 11:41 AM, Paul E. McKenney wrote:
> > On Tue, Sep 15, 2020 at 03:18:23AM +0000, Zhang, Qiang wrote:
> > > 
> > > 
> > > ________________________________________
> > > 发件人: Paul E. McKenney <paulmck@kernel.org>
> > > 发送时间: 2020年9月15日 4:56
> > > 收件人: Joel Fernandes
> > > 抄送: Zhang, Qiang; Uladzislau Rezki; josh@joshtriplett.org; rostedt@goodmis.org; mathieu.desnoyers@efficios.com; Lai Jiangshan; rcu@vger.kernel.org; LKML
> > > 主题: Re: RCU: Question on force_qs_rnp
> > > 
> > > On Mon, Sep 14, 2020 at 03:42:08PM -0400, Joel Fernandes wrote:
> > > > On Mon, Sep 14, 2020 at 07:55:18AM +0000, Zhang, Qiang wrote:
> > > > > Hello Paul
> > > > > 
> > > > > I have some questions for you .
> > > > > in force_qs_rnp func ,  if  "f(rdp)" func return true we will call rcu_report_qs_rnp func
> > > > > report a quiescent state for this rnp node, and clear grpmask form rnp->qsmask.
> > > > > after that ,  can we make a check for this rnp->qsmask,  if  rnp->qsmask == 0,
> > > > > we will check blocked readers in this rnp node,  instead of jumping directly to the next node .
> > > > 
> > > > Could you clarify what good is this going to do? What problem are you trying to
> > > > address?
> > > > 
> > > > You could have a task that is blocked in an RCU leaf node, but the
> > > > force_qs_rnp() decided to call rcu_report_qs_rnp(). This is perfectly Ok. The
> > > > CPU could be dyntick-idle and a quiescent state is reported. However, the GP
> > > > must not end and the rcu leaf node should still be present in its parent
> > > > intermediate nodes ->qsmask. In this case, the ->qsmask == 0 does not have
> > > > any relevance.
> > > > 
> > > > Or am I missing the point of the question?
> > > 
> > > > Hello, Qiang,
> > > 
> > > > Another way of making Joel's point is to say that the additional check
> > > > you are asking for is already being done, but by rcu_report_qs_rnp().
> > > 
> > > >                                                         Thanx, Paul
> > > 
> > > Hello Pual,  Joel
> > > 
> > > What I want to express is as follows :
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 7623128d0020..beb554539f01 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2622,6 +2622,11 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> > >                  if (mask != 0) {
> > >                          /* Idle/offline CPUs, report (releases rnp->lock). */
> > >                          rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > > +                       raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > +                       if (rnp->qsmask == 0 && rcu_preempt_blocked_readers_cgp(rnp))
> > > +                               rcu_initiate_boost(rnp, flags);
> > > +                       else
> > > +                               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >                  } else {
> > >                          /* Nothing to do here, so just drop the lock. */
> > >                          raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > 
> > But in that case, why duplicate the code from rcu_initiate_boost()?
> > 
> > 							Thanx, Paul
> > 
> 
> Hello Paul
> 
> When we force a qs for rnp, we first check the leaf node "rnp->qsmask" if it
> is reached zero, will check if there are some blocked readers in this leaf
> rnp node, if so we need to priority-boost blocked readers.
> if not we will check cpu dyntick-idle and report leaf node qs, after this
> leaf rnp node report qs, there is may be some blocked readers in this node,
> should we also need to priority-boost blocked readers?

Yes, but we will do that on the next time around, a few milliseconds
later.  And by that time, it is quite possible that the reader will have
completed, which will save us from having to priority-boost it.

							Thanx, Paul
