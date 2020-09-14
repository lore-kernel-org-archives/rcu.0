Return-Path: <SRS0=r7Mw=CX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB1C43461
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 20:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC09921BE5
	for <rcu@archiver.kernel.org>; Mon, 14 Sep 2020 20:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600117007;
	bh=91ZQHPpXzVYPM1kY5tNaht13UGMxQL4Ref/OgbCg9h0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=M/33/nwsaBZN4THN8qONlk9tRYWZTB5GLxY5+7fmclarWAQc8CwQkKTLDInIhu5Jx
	 qH3vWtXWddvrQ7ikq0HQplQ1a8aC/vCyaaJJl8MOuSZjj1nA8gMwyvU6eYYxu0jyWp
	 VVTNDHyGgBrPAw9dVqyI12QJ7MBI/M1aWpSHYqEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINU4p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgINU4m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Sep 2020 16:56:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F09B2193E;
        Mon, 14 Sep 2020 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600117002;
        bh=91ZQHPpXzVYPM1kY5tNaht13UGMxQL4Ref/OgbCg9h0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rUX3bhtctscjf/GF6iRwny6FU/Y4zB+mOFYpGbV8pOvplCLWDQp72DCUpp9qXhbdn
         q/ifxj3kSWyHz9Bkuj9N3OhbFnwqFzY2jpeazQ9CbvkwhIcsGBmlus5ZQzQqvci3IV
         +3DkM4GJNK7HvJx5ACofl3KIgHk4JvqEiEP1lpbI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 146F53522718; Mon, 14 Sep 2020 13:56:42 -0700 (PDT)
Date:   Mon, 14 Sep 2020 13:56:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RCU: Question on force_qs_rnp
Message-ID: <20200914205642.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <BYAPR11MB2632C4C06386B39BB5488428FF230@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200914194208.GA2579423@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914194208.GA2579423@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 14, 2020 at 03:42:08PM -0400, Joel Fernandes wrote:
> On Mon, Sep 14, 2020 at 07:55:18AM +0000, Zhang, Qiang wrote:
> > Hello Paul
> > 
> > I have some questions for you .
> > in force_qs_rnp func ,  if  "f(rdp)" func return true we will call rcu_report_qs_rnp func
> > report a quiescent state for this rnp node, and clear grpmask form rnp->qsmask.
> > after that ,  can we make a check for this rnp->qsmask,  if  rnp->qsmask == 0, 
> > we will check blocked readers in this rnp node,  instead of jumping directly to the next node .
> 
> Could you clarify what good is this going to do? What problem are you trying to
> address?
> 
> You could have a task that is blocked in an RCU leaf node, but the
> force_qs_rnp() decided to call rcu_report_qs_rnp(). This is perfectly Ok. The
> CPU could be dyntick-idle and a quiescent state is reported. However, the GP
> must not end and the rcu leaf node should still be present in its parent
> intermediate nodes ->qsmask. In this case, the ->qsmask == 0 does not have
> any relevance.
> 
> Or am I missing the point of the question?

Hello, Qiang,

Another way of making Joel's point is to say that the additional check
you are asking for is already being done, but by rcu_report_qs_rnp().

							Thanx, Paul
