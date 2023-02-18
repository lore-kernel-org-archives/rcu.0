Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95F4C61DA4
	for <rcu@archiver.kernel.org>; Sat, 18 Feb 2023 19:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBRTgN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Feb 2023 14:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRTgM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Feb 2023 14:36:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A012BC1;
        Sat, 18 Feb 2023 11:36:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C95EB808BF;
        Sat, 18 Feb 2023 19:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C0C433D2;
        Sat, 18 Feb 2023 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676748968;
        bh=JEWYKjqvmed6R/0HtSyMOqbojUJ36MZfuGinMa5IcOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MW8Pe0Xov3zk1XzgyOOpUX6SKT8RVSqBZn+IUdvZ6Bq5KZNSsRzll8ATUDUjei7bT
         04MaZ5wQ5+Dpp+OA89igv4fOhbk0zwDGPjZYFv91TMOJ1q0PlqxUKG6vyYcESL984e
         Xjhqm3ynv+lXC1V2DdHq2B+fotQhTrM/gW/auflGHS8FOehxi5QwPU6xT4scIoeP/T
         mEQksJxkzd7hG1EARBFfXBDUOW/5QaxYcP7alW4J+LYezbQ4uz2BI4YPRLg0F+YKlg
         5cJN8DrhqDT7M7HyBwwJ5I4zFTBAodJG0Eunuvlwlai8lIy5fej4EdmdP0qIh8GcfT
         W96N3MA8wcBjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8BFA85C0ACF; Sat, 18 Feb 2023 11:36:06 -0800 (PST)
Date:   Sat, 18 Feb 2023 11:36:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, akiyks@gmail.com
Subject: Re: [PATCH v4] srcu: Clarify comments on memory barrier "E"
Message-ID: <20230218193606.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230128035902.1758726-1-joel@joelfernandes.org>
 <20230128182440.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTK1ejOcuNyAqJ3ibKKyfR21UYHRNa7jpWS_H71xpnTpg@mail.gmail.com>
 <20230129050904.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230208033831.GA3160511@paulmck-ThinkPad-P17-Gen-1>
 <51b1d566-2a5a-763e-fb0f-cc3eb387b917@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b1d566-2a5a-763e-fb0f-cc3eb387b917@efficios.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 07, 2023 at 10:48:42PM -0500, Mathieu Desnoyers wrote:
> On 2023-02-07 22:38, Paul E. McKenney wrote:
> [...]
> > 
> > Except that it was pointed out to me that the Co-developed-by tags also
> > need Signed-off-by tags.  If there are no objections to the update shown
> > below, I will fix this on my next rebase.
> 
> No objection from me, thanks!

And I have updated this commit, thank you all!

							Thanx, Paul
