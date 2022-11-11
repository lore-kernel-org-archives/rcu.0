Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D18C4332F
	for <rcu@archiver.kernel.org>; Fri, 11 Nov 2022 00:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKKAQ5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Nov 2022 19:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKKAQ4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Nov 2022 19:16:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB760EA1;
        Thu, 10 Nov 2022 16:16:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F47361E63;
        Fri, 11 Nov 2022 00:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E055C433D6;
        Fri, 11 Nov 2022 00:16:54 +0000 (UTC)
Date:   Thu, 10 Nov 2022 19:16:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: RCU stall on 6.1-rc4 (and some previous releases) related to
 ftrace
Message-ID: <20221110191651.3a177417@rorschach.local.home>
In-Reply-To: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
References: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 10 Nov 2022 18:25:41 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> @@ -4184,6 +4184,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
>  		if (rec->flags & FTRACE_FL_DISABLED)
>  			continue;
>  
> +		cond_resched();
>  		if (ftrace_match_record(rec, &func_g, mod_match, exclude_mod)) {
>  			ret = enter_record(hash, rec, clear_filter);
>  			if (ret < 0) {

This isn't where I would put it. I would add it after the if statement.
That is, at the end of the loop.

-- Steve
