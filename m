Return-Path: <SRS0=qU2T=4J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8F6C35666
	for <rcu@archiver.kernel.org>; Fri, 21 Feb 2020 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80D320578
	for <rcu@archiver.kernel.org>; Fri, 21 Feb 2020 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBUUMk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:12:40 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:48724 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUUMk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 Feb 2020 15:12:40 -0500
X-Greylist: delayed 1961 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 15:12:39 EST
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j5E9V-0004rL-Qy; Fri, 21 Feb 2020 12:39:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j5E9V-0004U8-19; Fri, 21 Feb 2020 12:39:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk
References: <20200217183627.4099690-1-gscrivan@redhat.com>
Date:   Fri, 21 Feb 2020 13:37:57 -0600
In-Reply-To: <20200217183627.4099690-1-gscrivan@redhat.com> (Giuseppe
        Scrivano's message of "Mon, 17 Feb 2020 19:36:27 +0100")
Message-ID: <87lfov68a2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j5E9V-0004U8-19;;;mid=<87lfov68a2.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hbbZqknfDn39SoIooqGEcoP9YtOWFd30=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] ipc: use a work queue to free_ipc
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> it avoids blocking on synchronize_rcu() in kern_umount().
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

I have a question.  You create 1000 namespaces in a single process
and then free them.  So I expect that single process is busy waiting
for that kern_umount 1000 types, and waiting for 1000 synchronize_rcu's.

Does this ever show up in a real world work-load?

Is the cost of a single synchronize_rcu a problem?

The code you are working to avoid is this.

void kern_unmount(struct vfsmount *mnt)
{
	/* release long term mount so mount point can be released */
	if (!IS_ERR_OR_NULL(mnt)) {
		real_mount(mnt)->mnt_ns = NULL;
		synchronize_rcu();	/* yecchhh... */
		mntput(mnt);
	}
}

Which makes me wonder if perhaps there might be a simpler solution
involving just that code.  But I do realize such a solution
would require analyzing all of the code after kern_unmount
to see if any of it depends upon the synchronize_rcu.


In summary, I see no correctness problems with your code.
Code that runs faster is always nice.  In this case I just
see the cost being shifted somewhere else not eliminated.
I also see a slight increase in complexity.

So I am wondering if this was an exercise to speed up a toy
benchmark or if this is an effort to speed of real world code.

At the very least some version of the motivation needs to be
recorded so that the next time some one comes in an reworks
the code they can look in the history and figure out what
they need to do to avoid introducing a regeression.

Eric

> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v2:
> - comment added in free_ipc_ns()
>
> v1: https://lkml.org/lkml/2020/2/11/692
>
>  include/linux/ipc_namespace.h |  2 ++
>  ipc/namespace.c               | 20 ++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
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
> index b3ca1476ca51..7b9922244891 100644
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
> @@ -127,6 +131,17 @@ static void free_ipc_ns(struct ipc_namespace *ns)
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
> +static DECLARE_WORK(free_ipc_work, free_ipc);
> +
>  /*
>   * put_ipc_ns - drop a reference to an ipc namespace.
>   * @ns: the namespace to put
> @@ -148,8 +163,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
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
