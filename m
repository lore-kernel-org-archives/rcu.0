Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BA3C4332E
	for <rcu@archiver.kernel.org>; Mon, 11 Jan 2021 17:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93142247F
	for <rcu@archiver.kernel.org>; Mon, 11 Jan 2021 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbhAKRfJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389515AbhAKRfJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Jan 2021 12:35:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630752247F;
        Mon, 11 Jan 2021 17:34:28 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:34:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Only trace when cbs are accelerated
Message-ID: <20210111123426.333cd960@gandalf.local.home>
In-Reply-To: <1610365501-6196-1-git-send-email-neeraju@codeaurora.org>
References: <1610365501-6196-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 11 Jan 2021 17:15:01 +0530
Neeraj Upadhyay <neeraju@codeaurora.org> wrote:

> Fix rcu_accelerate_cbs() traces to only trace when cbs are
> accelerated in current call.

The body of the commit should explain "why" not "what". Why not trace the
cbs when not accelerated in the current call?

-- Steve


> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
