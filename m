Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C407C433EF
	for <rcu@archiver.kernel.org>; Thu, 30 Sep 2021 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BD2613A7
	for <rcu@archiver.kernel.org>; Thu, 30 Sep 2021 15:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbhI3PjX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:39:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbhI3PjX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Sep 2021 11:39:23 -0400
Date:   Thu, 30 Sep 2021 17:37:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633016258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSUo1ok0Gfuwkn0q6B4OK+IDqp4mq2TmsE79ya8gqyc=;
        b=dXT/6ABw/+kqhTbVmKiG6sNw3hdKQ4cikyrgmktM+/19iGOA2ZsB5mFqooC4ll4pHPG7Zp
        yEoiEJbqGmvZdBzFBtAue2HVwqURCLtyA/4TorcOvpW2h8Cg56HZWuXBu1Esy/WyTHo4t2
        3vRU1PuPqduGTMc/koVVsck+0wYkCqQ9E2WZFZeHm6ytA72u4SmrqzKh3DcPvFNvy6DkX4
        ADOVzlRmf34cxFl3COQjHRunkIFD4t6+9/7SaEZwV59U8CTIIQbDw371ofVrR/NMZl7CQj
        cwBk7vo4w6cR7lrCRh8oPkW2i+g+Xkg/+JVR3f7RSszMk2BvBJNesZUaM5DqgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633016258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSUo1ok0Gfuwkn0q6B4OK+IDqp4mq2TmsE79ya8gqyc=;
        b=cJ7PQOMjC1UbbRmYixsk3/uybvQ/Juns9rUMg5tDtBlZKzFBWl+4+kIdT+8/rIv+e36mk0
        bMG1Rt+G6J/wLVCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 11/11] rcu/nocb: Don't invoke local rcu core on callback
 overload from nocb kthread
Message-ID: <20210930153737.lljjay2cquph7cfv@linutronix.de>
References: <20210929221012.228270-1-frederic@kernel.org>
 <20210929221012.228270-12-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210929221012.228270-12-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-09-30 00:10:12 [+0200], Frederic Weisbecker wrote:
> rcu_core() tries to ensure that its self-invocation in case of callbacks
> overload only happen in softirq/rcuc mode. Indeed it doesn't make sense
> to trigger local RCU core from nocb_cb kthread since it can execute
> on a CPU different from the target rdp. Also in case of overload, the
> nocb_cb kthread simply iterates a new loop of callbacks processing.
> 
> However the "offloaded" check that aims at preventing that is wrong.
- that?

> First of all that state is volatile and second: softirq/rcuc can
> execute while the target rdp is offloaded. As a result rcu_core() can

can what?

> Fix that with moving the rcu_core() self-invocation to rcu_core() itself,
> irrespective of the rdp offloaded state.

Sebastian
