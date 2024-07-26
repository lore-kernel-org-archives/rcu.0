Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9238FB9
	for <rcu@vger.kernel.org>; Fri, 26 Jul 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016956; cv=none; b=fgRI10e5IGc2/wdaFKmqi/NFVezFb+tLh4l4mYURI8HCEbuIcbtfjTgxQz163frdAbTmeiV074gCHN/Qu9Cg+SfKXYET3GnkDFSXnVmZUjN9c9hLRyQVxUH2M6243XMnpZcUh8GdGa5nG6Nx0TGZS/dmw6kismtEGHpgMBZMDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016956; c=relaxed/simple;
	bh=Lw+VS8zL9qpaXDjjrSJ+lsT64uRp0we/bnIIleX6nmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/3wwV9nkRHKaFUALkUEMsIvCCqN0rGsegQL9yBysvdEi/j2m2vpxm2ZqsPFdCrv19qFswviDO53AOdMSs2ANu3J+eHYL78V2JkWkpe36TgG/Mx85/kyYckLHpR9jKLLDtKWUgpwnq3crSwIbMdzvdnlucnjFY+/R4O8GuIVnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4A84skF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4A84skF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DFBC4AF09;
	Fri, 26 Jul 2024 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722016956;
	bh=Lw+VS8zL9qpaXDjjrSJ+lsT64uRp0we/bnIIleX6nmc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=l4A84skF0gfikUrJzUohPOc+BT8jpevnltTIaYFHFxx1DCMXcWFoTHFz/5Gw123QB
	 udhdYd+wz30a6QKglqT7MiFc1b/cOovAXvvt0f91Tw1imqM077bJkkRUfgNOb2tPci
	 p+oY3BuTcUgCopbsaerPAlZgTYLTsm3hlxJiuY9NpvtXudqvyI/y36spzxhdqz6YhH
	 p/UmHNWpStwLM3mZ8qutn6KNOUK+wMXkiN4ZmdDruLYcPanrPT3f3fmpDwNKVzUeEi
	 QMUrX7lvtwwFYNwJFwW+kFxBU+Q6sycCzkJ4rm0yRAFXWQAmzJN3I7CK3EgPIpT0Lg
	 npyAaUxxx/CgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D5A25CE08DD; Fri, 26 Jul 2024 11:02:35 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:02:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	rcu@vger.kernel.org
Subject: Re: rcu_sync_dtor() warning question
Message-ID: <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-ansonsten-piste-c4f04d4909fc@brauner>

On Fri, Jul 26, 2024 at 03:54:28PM +0200, Christian Brauner wrote:
> Hey,
> 
> I could use some help with understanding a bug related to rcu that was
> reported today. It first seems to have shown up on the 25th of July:
> 
> https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
> 
> We seem to be hitting the WARN_ON_ONCE() in:
> 
> void rcu_sync_dtor(struct rcu_sync *rsp)
> {
>         int gp_state;
> 
>         WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
> 
> from destroy_super_work() which gets called when a superblock is really freed.
> 
> If the superblock has been visible in userspace we do it via call_rcu():
> 
> static void destroy_super_work(struct work_struct *work)
> {
>         struct super_block *s = container_of(work, struct super_block,
>                                                         destroy_work);
>         fsnotify_sb_free(s);
>         security_sb_free(s);
>         put_user_ns(s->s_user_ns);
>         kfree(s->s_subtype);
>         for (int i = 0; i < SB_FREEZE_LEVELS; i++)
>                 percpu_free_rwsem(&s->s_writers.rw_sem[i]);
>         kfree(s);
> }
> 
> static void destroy_super_rcu(struct rcu_head *head)
> {
>         struct super_block *s = container_of(head, struct super_block, rcu);
>         INIT_WORK(&s->destroy_work, destroy_super_work);
>         schedule_work(&s->destroy_work);
> }
> 
> And I'm really confused because I don't understand the details for sync
> rcu enough to come up with a clear problem statement even. Could someone
> please explain what the WARN_ON_ONCE() is about?

If I am not too confused (and Oleg will correct me if I am), this is
checking a use-after-free error.  A given rcu_sync structure normally
transitions from GP_IDLE->GP_ENTER->GP_PASSED->GP_EXIT->GP_IDLE, with
possible side-trips from the GP_EXIT state through GP_REPLAY and back
to GP_EXIT in special cases such as during early boot.

One way that this can happen is calling percpu_free_rwsem() without
having previously done the percpu_up_write() needed to match an earlier
percpu_down_write().  I don't see any other way that this can happen
right off-hand, but someone might have added something, or I might be
suffering a failure of imagination.

> (I had been wondering if this is related to commit 7180f8d91fcb ("vfs:
> add rcu-based find_inode variants for iget ops") and the fix in commit
> 5bc9ad78c2f8 ("vfs: handle __wait_on_freeing_inode() and evict() race")
> but I don't see how.)

I don't see how either, unless it introduced some timing change
that made the scenario above more probable.

> Thanks for taking a look!

Hope this helps!  If not, you know where to find me.  ;-)

							Thanx, Paul
