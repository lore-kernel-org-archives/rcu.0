Return-Path: <SRS0=LYSJ=3T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9354C33C9E
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 11:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD93C206D3
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnxJ2hMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgA3Ldw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:33:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727145AbgA3Ldw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jan 2020 06:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580384031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LckSruGS9mnZBhfnh1yRL8G9a5TasGSKYWZgAtg7IgQ=;
        b=LnxJ2hMKK37F6m/OVEnYpZ2yJ9b7idtobo2MAnraRIV2mGol/JxvHrVRyTL/R2gGtOyVsf
        xRI9s5LXw7hMznXfmv7WkdB10M45YBJtMK1yN4/IYdUNu+Ic0uEhGGWEdQiRD5udUHMb2w
        9u2baHnyv5jfiG19xF1JK6GQne7P0go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-WnfvjFYcPFqnPoKMKI5ZAQ-1; Thu, 30 Jan 2020 06:33:46 -0500
X-MC-Unique: WnfvjFYcPFqnPoKMKI5ZAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4EF190B2D7;
        Thu, 30 Jan 2020 11:33:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 431E487B01;
        Thu, 30 Jan 2020 11:33:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 Jan 2020 12:33:43 +0100 (CET)
Date:   Thu, 30 Jan 2020 12:33:41 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     madhuparnabhowmik10@gmail.com, peterz@infradead.org,
        mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH] exit.c: Fix Sparse errors and warnings
Message-ID: <20200130113339.GA25426@redhat.com>
References: <20200130062028.4870-1-madhuparnabhowmik10@gmail.com>
 <20200130103158.azxldyfnugwvv6vy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130103158.azxldyfnugwvv6vy@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 01/30, Christian Brauner wrote:
>
> On Thu, Jan 30, 2020 at 11:50:28AM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> > This patch fixes the following sparse error:
> > kernel/exit.c:627:25: error: incompatible types in comparison expression
> >
> > And the following warning:
> > kernel/exit.c:626:40: warning: incorrect type in assignment
> >
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> I think the previous version was already fine but hopefully
> RCU_INIT_POINTER() really saves some overhead. In any case:

It is not about overhead, RCU_INIT_POINTER() documents the fact that we
didn't make any changes to the new parent, we only need to change the
pointer.

And btw, I don't really understand the __rcu annotations. Say, according
to sparse this code is wrong:

	int __rcu *P;

	void func(int *p)
	{
		P = p;
	}

OK, although quite possibly it is fine.

However, this code

	int __rcu *P;

	void func(int __rcu *p)
	{
		*p = 10;
	       	P = p;
	}

is almost certainly wrong but sparse is happy, asn is the same.


> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Oleg Nesterov <oleg@redhat.com>

