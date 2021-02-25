Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0050C433DB
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 23:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9685364EDB
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 23:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBYXGN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhBYXGN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Feb 2021 18:06:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 466F86148E;
        Thu, 25 Feb 2021 23:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614294332;
        bh=u5cNwC/0SBRpVqhs1EzbZYC3OkzpGcKrfdb1YzTIUdY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KwKQ7rPc0MY6Fyegj/4Jxr9w05oINHgTd9haFcexkb2zllWr+kYMiiHOa3PxWiYnS
         r+bv5X8RoeQWxTYeHXCHEtDWrtCHU7DwmmqPlCLBonrMNrJxUs7/m/2xjUl+THQB21
         py2BLiYljc96fMz145ktswWH6DOEL3Hr38uEJt5GSeC3tyrxTkeNLJjP9DgA54XHTV
         k97wPG9rT8DwvQYJt5e617+MRrtLcWHYuvhOqFL+W1vnvPFK890+soDxLLsk0SiioB
         dYkm+bpmN29mAOzcDVUPyXAqtaOiphIzPdy1yHcq/rZ0phR+iAvGA1sR/Vz3yH+G/y
         mBCOcf3ARSuIw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F2D8E352260A; Thu, 25 Feb 2021 15:05:31 -0800 (PST)
Date:   Thu, 25 Feb 2021 15:05:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: tasks-trace RCU: question about grace period forward progress
Message-ID: <20210225230531.GW2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com>
 <20210225153656.GQ2743@paulmck-ThinkPad-P72>
 <47558398.5024.1614268052985.JavaMail.zimbra@efficios.com>
 <20210225183321.GT2743@paulmck-ThinkPad-P72>
 <20210225222318.GG4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225222318.GG4746@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 25, 2021 at 11:23:18PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 25, 2021 at 10:33:21AM -0800, Paul E. McKenney wrote:
> > One question for Peter...  Does each and every context switch imply a
> > full barrier?
> 
> Yes, also see the smp_mb__after_spinlock() in __schedule() :-)

Whew!!!  ;-)

Yeah, I could make RCU Tasks Trace deal with lack of a full barrier in
that case, but I would rather not...  I could imagine optimizing so
that the full barrier happened only when tasks migrated, but I could
also imagine a world of hurt stemming from such an optimization!

							Thanx, Paul
