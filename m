Return-Path: <SRS0=YNYv=U2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86819C48BD7
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 14:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3320828
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 14:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0Oep (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:34:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:56090 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfF0Oep (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jun 2019 10:34:45 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AC227537;
        Thu, 27 Jun 2019 14:34:44 +0000 (UTC)
Date:   Thu, 27 Jun 2019 08:34:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [Linux-kernel-mentees][PATCH v5 1/5] Documentation: RCU:
 Convert RCU basic concepts to reST
Message-ID: <20190627083443.4f4918a7@lwn.net>
In-Reply-To: <20190626200705.24501-2-c0d1n61at3@gmail.com>
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
        <20190626200705.24501-2-c0d1n61at3@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 26 Jun 2019 15:07:01 -0500
Jiunn Chang <c0d1n61at3@gmail.com> wrote:

> RCU basic concepts reST markup.
> 
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

So this is a little detail but ... your signoff should be the last thing
in the set of tags on the patch.

This isn't worth making you do yet another revision, so I went ahead and
applied the patches and fixed the tag ordering on the way in.  I'll also
append a patch adding the new RCU stuff into the core-api manual so people
can actually get to it.

Thanks,

jon
