Return-Path: <SRS0=RZVH=3R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DFC33CB3
	for <rcu@archiver.kernel.org>; Tue, 28 Jan 2020 14:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0B12467E
	for <rcu@archiver.kernel.org>; Tue, 28 Jan 2020 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoRmfeGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA1O76 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:59:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgA1O76 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Jan 2020 09:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580223597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BbkQzI2OT5qwL33e/dmyxTt6JaLNl9+AOWiQKWYEhPs=;
        b=RoRmfeGNvGXRdZ8D7N7lji5cvUi9vk7iQ3R59I5h0aJSGq7It6SaBz5gvOYAuEUW5sal1g
        y2WGookJ0s3+417iV8PKZIA+C6AgWxe7Jnec7bx9atad0s+2bud8fx8POozq5ALmy+sBUo
        OTnegliKv85nOWURj8KSBJ+ARWbdaDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-fwA69Ao3McuaMqHdt6RuLQ-1; Tue, 28 Jan 2020 09:59:52 -0500
X-MC-Unique: fwA69Ao3McuaMqHdt6RuLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47CEF189F760;
        Tue, 28 Jan 2020 14:59:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6C74A84BC4;
        Tue, 28 Jan 2020 14:59:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Jan 2020 15:59:49 +0100 (CET)
Date:   Tue, 28 Jan 2020 15:59:46 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     christian.brauner@ubuntu.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] fork.c: Use RCU_INIT_POINTER() instead of
 rcu_access_pointer()
Message-ID: <20200128145946.GE17943@redhat.com>
References: <20200127175821.10833-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127175821.10833-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 01/27, madhuparnabhowmik10@gmail.com wrote:
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1508,7 +1508,7 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
>  		return 0;
>  	}
>  	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
> -	rcu_assign_pointer(tsk->sighand, sig);
> +	RCU_INIT_POINTER(tsk->sighand, sig);

Acked-by: Oleg Nesterov <oleg@redhat.com>

