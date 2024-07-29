Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789F130A7D
	for <rcu@vger.kernel.org>; Mon, 29 Jul 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241623; cv=none; b=Y+apXr6QZiUX9+Ex3Sb3HoW2k1SQHlWLHot7BilgRy7n+gJBQ72MImMAn3CfQEUjS4LS+XhDEqd6jY8e2X3gSK0k+YCu5Vrw3giPeOjz4y3LjoFnuQRP+MyxrdFw8gTjtQoCk/VkC/YRcpIcc7wc2+ZgkshN4lVHgwDa5Ody1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241623; c=relaxed/simple;
	bh=n8cC2D6l/JLz8rhiw6r4T+MWP0qMhz6r/SX462mrOKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad+eKXIwbf1PKNY8it5xe8FICsxRJQFIu8Af23CPHg55kqQtA6Z76q37S2SKwVHN2IaWKihGFWEGcr+7NpbHhZU70TzyTJvxpsLBAFdMJS6z8BcVMsLkfR0FQp+5WCY3Ik9FGvVX7BjZRNofr2kvANMmtl/6V5VA9BhJN+Qfr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrV7UFTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrV7UFTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0DBC32786;
	Mon, 29 Jul 2024 08:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722241622;
	bh=n8cC2D6l/JLz8rhiw6r4T+MWP0qMhz6r/SX462mrOKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrV7UFTIai7xSZ9Y907cA2q9jm6IT+ehpuV6nzkCEvIu/P84mIKHYdXPvzjglglui
	 3bB/7f6p1dLlT/USXrZzsZJD1wwxbEp7lx8uBhAAurPWW9hwqZmMQ9xmjeFMr8PHSD
	 35vO3Alq8AFfs4JauGIyc3n5YjVpFoh6nF3ads832SkGALuHgmI2BFELPaVxnJ6ldF
	 wkvLc7pzpVrooixXw2rlQLt7E31Ye41QGzC3FvGEIObv7AtBXLTIl+vfs/sefTtkSk
	 UE2NG29oQ8Y/XV8xgrePDmpDm58uR/kGSiBzPwY2A7fdEVZXRK0oVBu7e1ExmWQr5/
	 tb0P0XmKLo9SA==
Date: Mon, 29 Jul 2024 10:26:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	rcu@vger.kernel.org
Subject: Re: rcu_sync_dtor() warning question
Message-ID: <20240729-gastieren-gassen-819d78e3e2eb@brauner>
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner>
 <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>

On Fri, Jul 26, 2024 at 11:02:35AM GMT, Paul E. McKenney wrote:
> On Fri, Jul 26, 2024 at 03:54:28PM +0200, Christian Brauner wrote:
> > Hey,
> > 
> > I could use some help with understanding a bug related to rcu that was
> > reported today. It first seems to have shown up on the 25th of July:
> > 
> > https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
> > 
> > We seem to be hitting the WARN_ON_ONCE() in:
> > 
> > void rcu_sync_dtor(struct rcu_sync *rsp)
> > {
> >         int gp_state;
> > 
> >         WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
> > 
> > from destroy_super_work() which gets called when a superblock is really freed.
> > 
> > If the superblock has been visible in userspace we do it via call_rcu():
> > 
> > static void destroy_super_work(struct work_struct *work)
> > {
> >         struct super_block *s = container_of(work, struct super_block,
> >                                                         destroy_work);
> >         fsnotify_sb_free(s);
> >         security_sb_free(s);
> >         put_user_ns(s->s_user_ns);
> >         kfree(s->s_subtype);
> >         for (int i = 0; i < SB_FREEZE_LEVELS; i++)
> >                 percpu_free_rwsem(&s->s_writers.rw_sem[i]);
> >         kfree(s);
> > }
> > 
> > static void destroy_super_rcu(struct rcu_head *head)
> > {
> >         struct super_block *s = container_of(head, struct super_block, rcu);
> >         INIT_WORK(&s->destroy_work, destroy_super_work);
> >         schedule_work(&s->destroy_work);
> > }
> > 
> > And I'm really confused because I don't understand the details for sync
> > rcu enough to come up with a clear problem statement even. Could someone
> > please explain what the WARN_ON_ONCE() is about?
> 
> If I am not too confused (and Oleg will correct me if I am), this is
> checking a use-after-free error.  A given rcu_sync structure normally
> transitions from GP_IDLE->GP_ENTER->GP_PASSED->GP_EXIT->GP_IDLE, with
> possible side-trips from the GP_EXIT state through GP_REPLAY and back
> to GP_EXIT in special cases such as during early boot.
> 
> One way that this can happen is calling percpu_free_rwsem() without
> having previously done the percpu_up_write() needed to match an earlier
> percpu_down_write().  I don't see any other way that this can happen
> right off-hand, but someone might have added something, or I might be
> suffering a failure of imagination.

And you were spot on of course!

> 
> > (I had been wondering if this is related to commit 7180f8d91fcb ("vfs:
> > add rcu-based find_inode variants for iget ops") and the fix in commit
> > 5bc9ad78c2f8 ("vfs: handle __wait_on_freeing_inode() and evict() race")
> > but I don't see how.)
> 
> I don't see how either, unless it introduced some timing change
> that made the scenario above more probable.
> 
> > Thanks for taking a look!
> 
> Hope this helps!  If not, you know where to find me.  ;-)

Thank you for taking the time, Paul. That was indeed helpful!
