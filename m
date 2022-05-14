Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70BC433F5
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiENOk3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiENOk2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:40:28 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5152A25F
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:40:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s22so3579086qta.0
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Za/2h4hrKIh+oqS43I+EgLnZ0tCCCK9W5dB27LPJgAo=;
        b=pDh6xWmwbX9+DQcV/9+/emHe+kR1QYWgZ5Iz2Y0tTzowErdcOsQLEEf5jtzzIrGiH7
         0ykhBlNdzAWYBQjoeNVuwdCawlDvZvFNskkXBZa6Vlkz8tRpHcfGwZ6uVl1UOgnuI3MX
         xeDtzxmqIaJVwszI/ksh4ReAv4CNjw96OTxhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Za/2h4hrKIh+oqS43I+EgLnZ0tCCCK9W5dB27LPJgAo=;
        b=X6mgSIUlu9dJlQHKoklgtLGM+ueBYHkYPI8GOjgqRUyz8Dvc68YE8iSSGo8Da6vIv8
         Eh7nb0VSJD7WlkYG6dcVRD2FYaPLlHzJ3D7ipOFssG2RuOx6A4/9bN+LssQSZtul2/wj
         9cNvqGQCS54McLxD7FH2pFm3M/fIYeXKDPHkBz6Vfnfvo5dj3/Tv9arh0rHSiSo+bq7N
         VbmxxRFTdD/tbNDobJIGelFIFLc8G5GVOYc0FZ19iTeSRI8srqNDMvjMCilaOwJTxhWc
         AI5y98f39+e9dOQIFqyBTtKpY3UOlI3geIf0bar8NnH9oVxmY8vVWJ+o+mtehPLZ4d3G
         MidQ==
X-Gm-Message-State: AOAM5303hbDLHXEjhQlxP6OCUdyVARFvBDczUg2xSjBKVqCbwk1BNd1j
        9pTvLlWqwbLfKrn7BByCI4LJ+gtV8bIRYg==
X-Google-Smtp-Source: ABdhPJx1MURB7B6pVgMHBzH7b5otdItm2Od84QUrE734iETE1D+xbMCeTq+a9zmjCBE/JkOkxD3CzA==
X-Received: by 2002:ac8:5988:0:b0:2f3:decb:6b6b with SMTP id e8-20020ac85988000000b002f3decb6b6bmr8715156qte.289.1652539226088;
        Sat, 14 May 2022 07:40:26 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id d15-20020ac8118f000000b002f39b99f693sm2989554qtj.45.2022.05.14.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:40:25 -0700 (PDT)
Date:   Sat, 14 May 2022 14:40:25 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 05/14] fs: Move call_rcu() to call_rcu_lazy() in some
 paths
Message-ID: <Yn+/WeuADEExfkwq@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-6-joel@joelfernandes.org>
 <20220513000717.GY1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513000717.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 05:07:17PM -0700, Paul E. McKenney wrote:
> On Thu, May 12, 2022 at 03:04:33AM +0000, Joel Fernandes (Google) wrote:
> > This is required to prevent callbacks triggering RCU machinery too
> > quickly and too often, which adds more power to the system.
> > 
> > When testing, we found that these paths were invoked often when the
> > system is not doing anything (screen is ON but otherwise idle).
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Some of these callbacks do additional work.  I don't immediately see a
> problem, but careful and thorough testing is required.

Full agreed, fwiw I did choose several of them by looking at what the
callback did but I agree additional review and testing is needed.

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > ---
> >  fs/dcache.c     | 4 ++--
> >  fs/eventpoll.c  | 2 +-
> >  fs/file_table.c | 3 ++-
> >  fs/inode.c      | 2 +-
> >  4 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index c84269c6e8bf..517e02cde103 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -366,7 +366,7 @@ static void dentry_free(struct dentry *dentry)
> >  	if (unlikely(dname_external(dentry))) {
> >  		struct external_name *p = external_name(dentry);
> >  		if (likely(atomic_dec_and_test(&p->u.count))) {
> > -			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
> > +			call_rcu_lazy(&dentry->d_u.d_rcu, __d_free_external);
> >  			return;
> >  		}
> >  	}
> > @@ -374,7 +374,7 @@ static void dentry_free(struct dentry *dentry)
> >  	if (dentry->d_flags & DCACHE_NORCU)
> >  		__d_free(&dentry->d_u.d_rcu);
> >  	else
> > -		call_rcu(&dentry->d_u.d_rcu, __d_free);
> > +		call_rcu_lazy(&dentry->d_u.d_rcu, __d_free);
> >  }
> >  
> >  /*
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index e2daa940ebce..10a24cca2cff 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -728,7 +728,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
> >  	 * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
> >  	 * use of the rbn field.
> >  	 */
> > -	call_rcu(&epi->rcu, epi_rcu_free);
> > +	call_rcu_lazy(&epi->rcu, epi_rcu_free);
> >  
> >  	percpu_counter_dec(&ep->user->epoll_watches);
> >  
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 7d2e692b66a9..415815d3ef80 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -56,7 +56,8 @@ static inline void file_free(struct file *f)
> >  	security_file_free(f);
> >  	if (!(f->f_mode & FMODE_NOACCOUNT))
> >  		percpu_counter_dec(&nr_files);
> > -	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
> > +
> > +	call_rcu_lazy(&f->f_u.fu_rcuhead, file_free_rcu);
> >  }
> >  
> >  /*
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 63324df6fa27..b288a5bef4c7 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -312,7 +312,7 @@ static void destroy_inode(struct inode *inode)
> >  			return;
> >  	}
> >  	inode->free_inode = ops->free_inode;
> > -	call_rcu(&inode->i_rcu, i_callback);
> > +	call_rcu_lazy(&inode->i_rcu, i_callback);
> >  }
> >  
> >  /**
> > -- 
> > 2.36.0.550.gb090851708-goog
> > 
