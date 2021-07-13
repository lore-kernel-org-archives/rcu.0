Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77268C07E95
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 13:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DAA61073
	for <rcu@archiver.kernel.org>; Tue, 13 Jul 2021 13:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhGMNL6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Jul 2021 09:11:58 -0400
Received: from mail.efficios.com ([167.114.26.124]:47762 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhGMNL4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Jul 2021 09:11:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0E51A9B0B6;
        Tue, 13 Jul 2021 09:09:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AX09Z6F5_rWq; Tue, 13 Jul 2021 09:09:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8B2409AEEA;
        Tue, 13 Jul 2021 09:09:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8B2409AEEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1626181744;
        bh=rwUgiTkIr4C//Zi3ZCbCC+KkCr16aUd//0fkaJH5ftg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RtZFuG59a4D0MN2//vkD6iQI9MR/JYZvUIn0bu0oe39KC5pSMMHpXjC+xiX2bF4mF
         56uEKzOgUZVDnb0kyGi1cYcjqfhTmFcDphQzcaYV7XyNHLkb7Xq4cOCoHCx/vBf8N3
         rMxAE5G8a5g9nX0Q0bCbC2yginEZIr6CRMuOY4/a/btIWU5kds3YhYWCfG3OETbsuv
         KJSCb7o3uF+uJ8fGBNWRBB77EtDkmhqKbXyNGxgzTKa6rEmXFbbJqBUScPUMX9ltOL
         hNXaVBx2JeuDV2wocsIB3miOytoeDFcl7o9os8T82RUb2dA63jslwCR90TH4UxbI0s
         gu+0gOPtUjpWg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5xVyNO2WsDun; Tue, 13 Jul 2021 09:09:04 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7B60D9B237;
        Tue, 13 Jul 2021 09:09:04 -0400 (EDT)
Date:   Tue, 13 Jul 2021 09:09:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     zhouzhouyi@gmail.com, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <520385500.15226.1626181744332.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210713005645.8565-1-zhouzhouyi@gmail.com> <20210713041607.GU4397@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: [PATCH] RCU: Fix macro name CONFIG_TASKS_RCU_TRACE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4059)
Thread-Topic: Fix macro name CONFIG_TASKS_RCU_TRACE
Thread-Index: ROUS2UuRwOuQB1BTugtLk1BJzQIfiw==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Jul 13, 2021, at 12:16 AM, paulmck paulmck@kernel.org wrote:

> On Tue, Jul 13, 2021 at 08:56:45AM +0800, zhouzhouyi@gmail.com wrote:
>> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
>> 
>> Hi Paul,
>> 
>> During my studying of RCU, I did a grep in the kernel source tree.
>> I found there are 3 places where the macro name CONFIG_TASKS_RCU_TRACE
>> should be CONFIG_TASKS_TRACE_RCU instead.
>> 
>> Without memory fencing, the idle/userspace task inspection may not
>> be so accurate.
>> 
>> Thanks for your constant encouragement for my studying.
>> 
>> Best Wishes
>> Zhouyi
>> 
>> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> Good eyes, and those could cause real bugs, so thank you!

Hi Paul,

This makes me wonder: what is missing testing-wise in rcutorture to
catch those issues with testing before they reach mainline ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
