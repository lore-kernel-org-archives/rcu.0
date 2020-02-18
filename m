Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA05C34047
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 20:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5801A22B48
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582057347;
	bh=JMQSKrxWNzcCHhq6OGdWBkakZuwE3K//goQJu/DR/YY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bRGCMXRHgA70BjEtsFAyTETZZyosrusWVOWaYwS+HlqLSyijTgZFZGhlK1qIIglHf
	 L47radW/n9dCKyTD5O1D1ixL22KbYUSh/x6fHcbROCUlmAGZjrLRxzRRk85DFxNgh2
	 kI5DqxdZNET5ulNwU5WWVLX69fmRdN6IjXkwIQ9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgBRUW1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:22:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgBRUW1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 15:22:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726E92173E;
        Tue, 18 Feb 2020 20:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582057346;
        bh=JMQSKrxWNzcCHhq6OGdWBkakZuwE3K//goQJu/DR/YY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zYDITELqb4XVqamQklQJ+27ONZKS9+wl9YQiwqVKfrJFH4oEHURio1O9wtkfpyC/T
         0KwW9CcwbHr+zfgsfya9x1hIKybJ/mVpf2XAqYCMnsMXfN/1RYCyEj846pWkfsbG7b
         ylUUthKEieEi8TY31Xzx6uwDmPOLojXmH+1SSm80=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4A8403520856; Tue, 18 Feb 2020 12:22:26 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:22:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200218202226.GJ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
 <20200217181615.GP2935@paulmck-ThinkPad-P72>
 <20200218075648.GW14914@hirez.programming.kicks-ass.net>
 <20200218162719.GE2935@paulmck-ThinkPad-P72>
 <20200218201142.GF11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218201142.GF11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 18, 2020 at 09:11:42PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:
> 
> > > I just took offence at the Changelog wording. It seems to suggest there
> > > actually is a problem, there is not.
> > 
> > Quoting the changelog: "Not appropriate for backporting due to failure
> > being unlikely."
> 
> That implies there is failure, however unlikely.
> 
> In this particular case there is absolutely no failure, except perhaps
> in KCSAN. This patch is a pure annotation such that KCSAN can understand
> the code.
> 
> Like said, I don't object to the actual patch, but I do think it is
> important to call out false negatives or to describe the actual problem
> found.

I don't feel at all comfortable declaring that there is absolutely
no possibility of failure.

							Thanx, Paul
