Return-Path: <SRS0=CE9U=EI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89061C388F2
	for <rcu@archiver.kernel.org>; Mon,  2 Nov 2020 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D87C22258
	for <rcu@archiver.kernel.org>; Mon,  2 Nov 2020 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604328808;
	bh=VEIG3LBk/WEoZWa26azx9qnRXxepxNNUo5Togk7O9K8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=m1jEQKErgo0MuLW80GzQAWaoFpiX1k5XodTAuTvuqRV9SBRXihTF1i5JMTggSGYmU
	 Q9zNYJ8b3pk3/M4GegpNmi++Uw5+uzmwGPsNoNhsM1eVjOYZJp4yW3pzeOSezSRtpd
	 +Fk3c7/jtbWdTn+I4SADYSBw1l4JjU4mODsft6/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKBOx1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKBOx1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Nov 2020 09:53:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30882242C;
        Mon,  2 Nov 2020 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604328806;
        bh=VEIG3LBk/WEoZWa26azx9qnRXxepxNNUo5Togk7O9K8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e/v4Fmrvy5Eu2Pc6C3rJkdLn1ar9JeLrjCJyOow1wYjoMQ/pHiiuLmN1LxsRVSjIh
         pkdF8vQ92aVeV9VlDWN2pIYHHLBI9tMNkFspG5AcUJWugg2YgtWyFUrqnOj673HHeS
         EmqbJepn+0EYg46FNPBBg/DaMDqFmsn/V32DK4i8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 62D583522755; Mon,  2 Nov 2020 06:53:26 -0800 (PST)
Date:   Mon, 2 Nov 2020 06:53:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RCU stall uses try_invoke_on_locked_down_task() with disabled
 interrupts
Message-ID: <20201102145326.GX3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201030132835.plzgp5d6bv3rslr2@linutronix.de>
 <20201030140032.GS3249@paulmck-ThinkPad-P72>
 <20201030171537.ichx22kn3omioilx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030171537.ichx22kn3omioilx@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 30, 2020 at 06:15:37PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-30 07:00:32 [-0700], Paul E. McKenney wrote:
> > Is this fixed by the following commit 8a26c219cafe ("rcu: Don't invoke
> > try_invoke_on_locked_down_task() with irqs disabled")?
> 
> Yes, thank you.
> 
> > If so, apologies, I failed to make the -rcu tree's for-v5.11 commits
> > visible to -next until quite recently.  :-/
> 
> Since it affects v5.10-rc1, wouldn't it qualify to be applied now?

If you supply your Tested-by, I will give it a shot.

							Thanx, Paul
