Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CFC433FE
	for <rcu@archiver.kernel.org>; Tue, 22 Nov 2022 15:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiKVPt2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Nov 2022 10:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKVPt1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Nov 2022 10:49:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BAF2E689;
        Tue, 22 Nov 2022 07:49:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59C45B81BF6;
        Tue, 22 Nov 2022 15:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C92C433D6;
        Tue, 22 Nov 2022 15:49:22 +0000 (UTC)
Date:   Tue, 22 Nov 2022 10:49:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Message-ID: <20221122104921.0185c58e@gandalf.local.home>
In-Reply-To: <d32e7b3d-31f3-9699-1eee-c1e3b2839fe2@igalia.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
        <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
        <d32e7b3d-31f3-9699-1eee-c1e3b2839fe2@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 22 Nov 2022 10:16:41 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Hi Steve, apologies for the ping, just want to ask you if you plan to
> take this one or should I change something? Thanks in advance,

I was traveling for work from Oct 31-Nov 14 and when I got back, I had over
300 patches to review in my queue. I'm now down under 100, so hopefully I
can get to it soon.

Just may take a bit.

Thanks,

-- Steve
