Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B568C6FD18
	for <rcu@archiver.kernel.org>; Tue, 28 Mar 2023 22:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjC1W0J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Mar 2023 18:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjC1W0I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Mar 2023 18:26:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46CE6;
        Tue, 28 Mar 2023 15:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E8C2B81EB2;
        Tue, 28 Mar 2023 22:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D562BC433EF;
        Tue, 28 Mar 2023 22:26:01 +0000 (UTC)
Date:   Tue, 28 Mar 2023 18:26:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, douglas.raillard@arm.com,
        tglx@linutronix.de, rcu@vger.kernel.org, kernel-team@fb.com
Subject: Re: [GIT PULL] Fix rcu_torture_read ftrace event
Message-ID: <20230328182600.32e672ed@gandalf.local.home>
In-Reply-To: <9f32a8e2-7fc3-427b-b1e2-238fe81ce97e@paulmck-laptop>
References: <9f32a8e2-7fc3-427b-b1e2-238fe81ce97e@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 28 Mar 2023 10:48:14 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> ----------------------------------------------------------------
> Urgent RCU pull request for v6.3
> 
> This commit brings the rcu_torture_read event trace into line with
> the new trace tools by replacing this event trace's __field() with the
> corresponding __array().  Without this commit, the new trace tools will
> fail when presented wtih an rcu_torture_read event trace, which is a
> regression from the viewpoint of trace tools users.
> 
> https://lore.kernel.org/all/20230320133650.5388a05e@gandalf.local.home/

Thanks! I'll base my change on top of v6.3-rc5 as that will include this
pull request.

 https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/

Which the kernel robot flagged as causing a build error due to this RCU
issue ;-)

-- Steve
