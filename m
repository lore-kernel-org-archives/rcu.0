Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846DC4167B
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 22:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiLMWeh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiLMWeb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 17:34:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DF514019;
        Tue, 13 Dec 2022 14:34:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10136B815E0;
        Tue, 13 Dec 2022 22:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77DAC433EF;
        Tue, 13 Dec 2022 22:34:26 +0000 (UTC)
Date:   Tue, 13 Dec 2022 17:34:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        rcu@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Message-ID: <20221213173425.609618fb@gandalf.local.home>
In-Reply-To: <07b8285c-abfc-dcc6-5a20-b6f8c9bc7e1e@igalia.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
        <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
        <07b8285c-abfc-dcc6-5a20-b6f8c9bc7e1e@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 13 Dec 2022 19:04:41 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Hi Steve, sorry to annoy, just a regular ping to see if we can get this
> into 6.2 (if too late, not a huge deal).

Thanks for the ping. For some reason this patch didn't make it into my
internal Patchwork, so I missed it (even though I did reply to you, I just
assumed it was in my patchwork).

It's not too late. I have some last minute patches I'm still testing. I'll
queue this one up.

BTW, we now have a kernel ftrace mailing list that you can Cc (but still Cc
LKML). 

  linux-trace-kernel@vger.kernel.org

-- Steve
