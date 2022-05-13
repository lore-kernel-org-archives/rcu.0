Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE2C433EF
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 00:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiEMAHW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 20:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEMAHV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 20:07:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC8F49C8E
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 17:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5271BB82BCE
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 00:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26C5C385B8;
        Fri, 13 May 2022 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652400437;
        bh=hrejc4Si1YdHU8+GVJYZAseN+WLkbInNICxri072BDs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TCPFJFrMxlz8frdHevtdV9OKnaKWzVY6dG+2VDRnzzTRJwmSUp/m8ZlwsIf+e3DLz
         zsAb9ygOkpmDs5VjUnVtb5bxPcjaxaOVwbiYHRM4PeSBEoCwQwRrO2nK4Mxa/RIb6I
         36CPC6DWjvhoupy8peSoanKyal7PhahgD7uHhLoOJ9MKEhZo/YOIU29Ks99F/36zLO
         dgUI7pFaair+kXE56+FM9xj0CADjlMNBz9m/pMajjE+C9Cr6JG/gj7iQnuNuRn5v0M
         Au+K9meYXuZk4OCyPjYOyr/19PMLj5QXRnC6uS/EJmpJK7DEfOA5zLQIhhILFsVIpL
         LUrwYRCpsYNYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B6D75C051B; Thu, 12 May 2022 17:07:17 -0700 (PDT)
Date:   Thu, 12 May 2022 17:07:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 05/14] fs: Move call_rcu() to call_rcu_lazy() in some
 paths
Message-ID: <20220513000717.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-6-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:33AM +0000, Joel Fernandes (Google) wrote:
> This is required to prevent callbacks triggering RCU machinery too
> quickly and too often, which adds more power to the system.
> 
> When testing, we found that these paths were invoked often when the
> system is not doing anything (screen is ON but otherwise idle).
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Some of these callbacks do additional work.  I don't immediately see a
problem, but careful and thorough testing is required.

							Thanx, Paul

> ---
>  fs/dcache.c     | 4 ++--
>  fs/eventpoll.c  | 2 +-
>  fs/file_table.c | 3 ++-
>  fs/inode.c      | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index c84269c6e8bf..517e02cde103 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -366,7 +366,7 @@ static void dentry_free(struct dentry *dentry)
>  	if (unlikely(dname_external(dentry))) {
>  		struct external_name *p = external_name(dentry);
>  		if (likely(atomic_dec_and_test(&p->u.count))) {
> -			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
> +			call_rcu_lazy(&dentry->d_u.d_rcu, __d_free_external);
>  			return;
>  		}
>  	}
> @@ -374,7 +374,7 @@ static void dentry_free(struct dentry *dentry)
>  	if (dentry->d_flags & DCACHE_NORCU)
>  		__d_free(&dentry->d_u.d_rcu);
>  	else
> -		call_rcu(&dentry->d_u.d_rcu, __d_free);
> +		call_rcu_lazy(&dentry->d_u.d_rcu, __d_free);
>  }
>  
>  /*
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index e2daa940ebce..10a24cca2cff 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -728,7 +728,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
>  	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
>  	 * use of the rbn field.
>  	 */
> -	call_rcu(&epi->rcu, epi_rcu_free);
> +	call_rcu_lazy(&epi->rcu, epi_rcu_free);
>  
>  	percpu_counter_dec(&ep->user->epoll_watches);
>  
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 7d2e692b66a9..415815d3ef80 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -56,7 +56,8 @@ static inline void file_free(struct file *f)
>  	security_file_free(f);
>  	if (!(f->f_mode & FMODE_NOACCOUNT))
>  		percpu_counter_dec(&nr_files);
> -	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
> +
> +	call_rcu_lazy(&f->f_u.fu_rcuhead, file_free_rcu);
>  }
>  
>  /*
> diff --git a/fs/inode.c b/fs/inode.c
> index 63324df6fa27..b288a5bef4c7 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -312,7 +312,7 @@ static void destroy_inode(struct inode *inode)
>  			return;
>  	}
>  	inode->free_inode = ops->free_inode;
> -	call_rcu(&inode->i_rcu, i_callback);
> +	call_rcu_lazy(&inode->i_rcu, i_callback);
>  }
>  
>  /**
> -- 
> 2.36.0.550.gb090851708-goog
> 
