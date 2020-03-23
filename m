Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1187C3F2CD
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CC520735
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFr8BX6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCWSIp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:08:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25065 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727289AbgCWSIp (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 23 Mar 2020 14:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584986923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2P7VoVY9lo6a7MhH8O+9cow+9oWrLXzQHPFSk6fMSdo=;
        b=DFr8BX6xbiL60UIvoMLE/Ez/fZ2YUIBey/p+Qp1ibQNv+g8wy9dvz5888BeYIesG0D464Q
        Go7B0Ei3/YOACri2Zz5rJ8UugZEdxAlweCi5P5uVZbPPYJmOe6tIMJa8n79R7sQK8o2ig+
        pCZyLeWdEdiuvsFJs5szMkvoHjkzp2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-LKAUHvlWNGqOgfKfgQlKBA-1; Mon, 23 Mar 2020 14:08:40 -0400
X-MC-Unique: LKAUHvlWNGqOgfKfgQlKBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD0718018B7;
        Mon, 23 Mar 2020 18:08:38 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-56.rdu2.redhat.com [10.10.117.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6B519497D;
        Mon, 23 Mar 2020 18:08:37 +0000 (UTC)
Subject: Re: [PATCH v3] ipc: use a work queue to free_ipc
To:     Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, ebiederm@xmission.com, paulmck@kernel.org,
        viro@zeniv.linux.org.uk
References: <20200225145419.527994-1-gscrivan@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1cdee0c9-58d3-62c1-92db-3f2035fb8424@redhat.com>
Date:   Mon, 23 Mar 2020 14:08:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200225145419.527994-1-gscrivan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2/25/20 9:54 AM, Giuseppe Scrivano wrote:
> the reason is to avoid a delay caused by the synchronize_rcu() call in
> kern_umount() when the mqueue mount is freed.
>
> the code:
>
> \#define _GNU_SOURCE
> \#include <sched.h>
> \#include <error.h>
> \#include <errno.h>
> \#include <stdlib.h>
> int main()
> {
>   int i;
>   for (i  = 0; i < 1000; i++)
>     if (unshare (CLONE_NEWIPC) < 0)
>       error (EXIT_FAILURE, errno, "unshare");
> }
>
> gets from:
>
> 	Command being timed: "./ipc-namespace"
> 	User time (seconds): 0.00
> 	System time (seconds): 0.06
> 	Percent of CPU this job got: 0%
> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:08.05
>
> to:
>
> 	Command being timed: "./ipc-namespace"
> 	User time (seconds): 0.00
> 	System time (seconds): 0.02
> 	Percent of CPU this job got: 96%
> 	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.03
>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v3:
> - added comment for free_ipc_work
> - commit message rephrased
>
> v2: https://lkml.org/lkml/2020/2/17/839
> - comment added in free_ipc_ns()
>
> v1: https://lkml.org/lkml/2020/2/11/692
>
>  include/linux/ipc_namespace.h |  2 ++
>  ipc/namespace.c               | 24 ++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> index c309f43bde45..a06a78c67f19 100644
> --- a/include/linux/ipc_namespace.h
> +++ b/include/linux/ipc_namespace.h
> @@ -68,6 +68,8 @@ struct ipc_namespace {
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;
>  
> +	struct llist_node mnt_llist;
> +
>  	struct ns_common ns;
>  } __randomize_layout;
>  
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index b3ca1476ca51..c0470aef41a0 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -117,6 +117,10 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
>  
>  static void free_ipc_ns(struct ipc_namespace *ns)
>  {
> +	/* mq_put_mnt() waits for a grace period as kern_unmount()
> +	 * uses synchronize_rcu().
> +	 */
> +	mq_put_mnt(ns);
>  	sem_exit_ns(ns);
>  	msg_exit_ns(ns);
>  	shm_exit_ns(ns);
> @@ -127,6 +131,21 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>  	kfree(ns);
>  }
>  
> +static LLIST_HEAD(free_ipc_list);
> +static void free_ipc(struct work_struct *unused)
> +{
> +	struct llist_node *node = llist_del_all(&free_ipc_list);
> +	struct ipc_namespace *n, *t;
> +
> +	llist_for_each_entry_safe(n, t, node, mnt_llist)
> +		free_ipc_ns(n);
> +}
> +
> +/*
> + * The work queue is used to avoid the cost of synchronize_rcu in kern_unmount.
> + */
> +static DECLARE_WORK(free_ipc_work, free_ipc);
> +
>  /*
>   * put_ipc_ns - drop a reference to an ipc namespace.
>   * @ns: the namespace to put
> @@ -148,8 +167,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
>  	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
>  		mq_clear_sbinfo(ns);
>  		spin_unlock(&mq_lock);
> -		mq_put_mnt(ns);
> -		free_ipc_ns(ns);
> +
> +		if (llist_add(&ns->mnt_llist, &free_ipc_list))
> +			schedule_work(&free_ipc_work);
>  	}
>  }
>  

I also have used llist recently. This is the standard way llist is used
and I don't any problem using it to defer the freeing so that it won't
block the put_ipc_ns() caller.

Reviewed-by: Waiman Long <longman@redhat.com>

