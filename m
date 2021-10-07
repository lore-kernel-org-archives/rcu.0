Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F8C433EF
	for <rcu@archiver.kernel.org>; Thu,  7 Oct 2021 19:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB32160F23
	for <rcu@archiver.kernel.org>; Thu,  7 Oct 2021 19:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhJGTOW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233869AbhJGTOV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Oct 2021 15:14:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74C066103B;
        Thu,  7 Oct 2021 19:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633633947;
        bh=pLn061djoRVzHpAKyRTFX/vkEhTok2R4aa1KwWy8B3g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ok3fbvQdtkocugVAcgvNahdNC/KlhcNi46ZcODAoQzM413B4PrdWyZ7epBOp0RrYb
         AQdnwYV2YOZAKz4p3pfOeV4fQwpcq2cTKqklzDYCYpfGk0iq43R0Q1XoqZgzJC1mO3
         SMAYAIwsroP3j/a5mDId3q5HV/RBX7PGDoZcj8J3BeZdv5JjNMc/O1wDvjS8/RRH+B
         E8VldLzOQPKPkf4PGXx6aUFX37VFR2V8OdG+MK1RcrEROk4h/dtGTFIVIiiVTl8+Ec
         Rd8sb8AH2adGH0/YLJycfTPr3AZ13CoIyv9SbtudeK+3eqkeZZdbCLYzHYQNTk91kp
         k/U4XzH5tavkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 490FE5C0870; Thu,  7 Oct 2021 12:12:27 -0700 (PDT)
Date:   Thu, 7 Oct 2021 12:12:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB
 + a few other fixes
Message-ID: <20211007191227.GM880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210929221012.228270-1-frederic@kernel.org>
 <20211006151339.GA422833@paulmck-ThinkPad-P17-Gen-1>
 <20211007084920.4wo5fmjxmistivqa@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007084920.4wo5fmjxmistivqa@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 07, 2021 at 10:49:20AM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-10-06 08:13:39 [-0700], Paul E. McKenney wrote:
> > On Thu, Sep 30, 2021 at 12:10:01AM +0200, Frederic Weisbecker wrote:
> > > PREEMPT_RT has made rcu_core() preemptible, making it unsafe against
> > > concurrent NOCB (de-)offloading.
> > > 
> > > Thomas suggested to drop the local_lock() based solution and simply
> > > check the offloaded state while context looks safe but that's not
> > > enough. Here is a bit of rework.
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > > 	rcu/rt
> > > 
> > > HEAD: aac1c58961446c731f2e989bd822ca1fd2659bad
> > 
> > Many of these look quite good, but any chance of getting an official
> > Tested-by from someone in the -rt community?
> 
> I looked over the series, bootet the series and run a quick rcutorture
> and didn't notice anything.
> 
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you, Sebastian!!!

							Thanx, Paul
