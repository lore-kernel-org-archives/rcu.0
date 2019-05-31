Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE9DC04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 13:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69C6269B7
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 13:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaNpj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 09:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaNpj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 May 2019 09:45:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84B6C302451A;
        Fri, 31 May 2019 13:45:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6B0D02FC57;
        Fri, 31 May 2019 13:45:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 31 May 2019 15:45:33 +0200 (CEST)
Date:   Fri, 31 May 2019 15:45:30 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Question about cacheline bounching with percpu-rwsem and rcu-sync
Message-ID: <20190531134529.GC31323@redhat.com>
References: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 31 May 2019 13:45:39 +0000 (UTC)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 05/31, Joel Fernandes wrote:
>
> The problem with traditional read-write semaphores is that when multiple
> cores take the lock for reading, the cache line containing the semaphore
> is bouncing between L1 caches of the cores, causing performance
> degradation.
>
> However, it appears to me that the struct percpu_rwsem "rss" element
> which is used by the RCU-sync is not a per-cpu element. So even in the
> fastpath case (only readers and no writers), the cacheline containing
> rss is shared and will bounce by multiple CPUs. For that matter, even
> the cacheline containing the percpu_rw_semaphore itself will be bounce
> among multiple reader CPUs.

The readers won't modify this memory? read_lock/unlock will only update
the per-cpu counter, ->read_count.

Oleg.

