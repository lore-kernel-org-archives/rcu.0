Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F9BC433F5
	for <rcu@archiver.kernel.org>; Wed, 20 Apr 2022 18:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbiDTSqB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiDTSqA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Apr 2022 14:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F21A419A3;
        Wed, 20 Apr 2022 11:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8226BB8214A;
        Wed, 20 Apr 2022 18:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62ADC385A0;
        Wed, 20 Apr 2022 18:43:10 +0000 (UTC)
Date:   Wed, 20 Apr 2022 14:43:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420144309.69c6b8d1@gandalf.local.home>
In-Reply-To: <20220420183726.GJ4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
        <20220418225033.3944860-1-paulmck@kernel.org>
        <20220420113231.6d3202e4@gandalf.local.home>
        <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
        <20220420121906.13752d3e@gandalf.local.home>
        <20220420164847.GG4285@paulmck-ThinkPad-P17-Gen-1>
        <20220420140226.32a10ece@gandalf.local.home>
        <20220420183726.GJ4285@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 20 Apr 2022 11:37:26 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> The original purpose of RCU Tasks Rude was to deal with the idle tasks,
> given that RCU Tasks dealt only with the non-idle tasks.
> 
> Or is there a trick that I missed?

It use to be that ftrace trampolines could be called from all sorts of
locations until Peter introduced the "noinstr" annotation that causes
objtool to fail to build when tracing happens there. If that prevents
ftrace from happening in that idle case where RCU tasks can not handle it,
then it may be that we can simply switch ftrace to the RCU tasks and get
rid of rude. ?

-- Steve
