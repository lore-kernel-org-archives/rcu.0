Return-Path: <SRS0=TgV7=74=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96941C433E0
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 16:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7755220679
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 16:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgFOQC7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:02:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55470 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOQC6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Jun 2020 12:02:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jkrZX-0000Jz-9p; Mon, 15 Jun 2020 10:02:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jkrZS-0006kj-Th; Mon, 15 Jun 2020 10:02:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org>
Date:   Mon, 15 Jun 2020 10:58:38 -0500
In-Reply-To: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org> (Randy
        Dunlap's message of "Sun, 14 Jun 2020 20:45:07 -0700")
Message-ID: <87a714cocx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jkrZS-0006kj-Th;;;mid=<87a714cocx.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/yVMbGMInvS5dqSamTLx7OYsQlVCtOJTs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] <linux/rculist.h>: fix kernel-doc notation & warning
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix a kernel-doc warning due to missing a beginning '*' on the
> comment line.
>
> ../include/linux/rculist.h:515: warning: bad line:                           [@right ][node2 ... ]
>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Fixes: 35fc0e3b0bd5 ("rculist: Add hlists_swap_heads_rcu")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: rcu@vger.kernel.org
> ---
>  include/linux/rculist.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-58-rc1.orig/include/linux/rculist.h
> +++ lnx-58-rc1/include/linux/rculist.h
> @@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(str
>   * @right: The hlist head on the right
>   *
>   * The lists start out as [@left  ][node1 ... ] and
> -                          [@right ][node2 ... ]
> + *                        [@right ][node2 ... ]
>   * The lists end up as    [@left  ][node2 ... ]
>   *                        [@right ][node1 ... ]
>   */
